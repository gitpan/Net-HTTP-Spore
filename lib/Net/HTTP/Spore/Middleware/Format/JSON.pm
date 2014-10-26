package Net::HTTP::Spore::Middleware::Format::JSON;
BEGIN {
  $Net::HTTP::Spore::Middleware::Format::JSON::VERSION = '0.01';
}

# ABSTRACT: middleware for JSON format

use JSON;
use Moose;
extends 'Net::HTTP::Spore::Middleware::Format';

has _json_parser => (
    is      => 'rw',
    isa     => 'JSON',
    lazy    => 1,
    default => sub { JSON->new->allow_nonref },
);

sub encode       { $_[0]->_json_parser->encode( $_[1] ); }
sub decode       { $_[0]->_json_parser->decode( $_[1] ); }
sub accept_type  { ( 'Accept' => 'application/json' ) }
sub content_type { ( 'Content-Type' => 'application/json' ) }

1;


__END__
=pod

=head1 NAME

Net::HTTP::Spore::Middleware::Format::JSON - middleware for JSON format

=head1 VERSION

version 0.01

=head1 SYNOPSIS

    my $client = Net::HTTP::Spore->new_from_spec('twitter.json');
    $client->enable('Format::JSON');

=head1 DESCRIPTION

Net::HTTP::Spore::Middleware::Format::JSON is a simple middleware to handle the JSON format. It will set the appropriate B<Accept> header in your request. If the request method is PUT or POST, the B<Content-Type> header will also be set to JSON.

This middleware will also deserialize content in the response. The deserialized content will be store in the B<body> of the response.

=head1 EXAMPLES

=head1 AUTHOR

franck cuny <franck@lumberjaph.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by linkfluence.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

