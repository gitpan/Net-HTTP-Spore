package Net::HTTP::Spore::Middleware::Format::YAML;
BEGIN {
  $Net::HTTP::Spore::Middleware::Format::YAML::VERSION = '0.03';
}

# ABSTRACT: middleware for YAML format

use YAML;
use Moose;
extends 'Net::HTTP::Spore::Middleware::Format';

sub encode       { YAML::Decode( $_[1] ); }
sub decode       { YAML::Load( $_[1] ); }
sub accept_type  { ( 'Accept' => 'text/x-yaml' ) }
sub content_type { ( 'Content-Type' => 'text/x-yaml' ) }

1;


__END__
=pod

=head1 NAME

Net::HTTP::Spore::Middleware::Format::YAML - middleware for YAML format

=head1 VERSION

version 0.03

=head1 SYNOPSIS

    my $client = Net::HTTP::Spore->new_from_spec('github.json');
    $client->enable('Format::YAML');

=head1 DESCRIPTION

Net::HTTP::Spore::Middleware::Format::YAML is a simple middleware to handle the YAML format. It will set the appropriate B<Accept> header in your request. If the request method is PUT or POST, the B<Content-Type> header will also be set to YAML.

This middleware will also deserialize content in the response. The deserialized content will be store in the B<body> of the response.

=head1 EXAMPLES

=head1 AUTHOR

franck cuny <franck@lumberjaph.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by linkfluence.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

