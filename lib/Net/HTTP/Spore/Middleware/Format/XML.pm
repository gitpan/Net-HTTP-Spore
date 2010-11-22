package Net::HTTP::Spore::Middleware::Format::XML;
BEGIN {
  $Net::HTTP::Spore::Middleware::Format::XML::VERSION = '0.03';
}

# ABSTRACT: middleware for XML format

use Moose;
extends 'Net::HTTP::Spore::Middleware::Format';

use XML::Simple;

sub accept_type  { ( 'Accept'       => 'text/xml' ); }
sub content_type { ( 'Content-Type' => 'text/xml' ) }
sub encode       { XMLout( $_[1] ) }
sub decode       { XMLin( $_[1] ) }

1;


__END__
=pod

=head1 NAME

Net::HTTP::Spore::Middleware::Format::XML - middleware for XML format

=head1 VERSION

version 0.03

=head1 SYNOPSIS

    my $client = Net::HTTP::Spore->new_from_spec('twitter.json');
    $client->enable('Format::XML');

=head1 DESCRIPTION

Net::HTTP::Spore::Middleware::Format::XML is a simple middleware to handle the XML format. It will set the appropriate B<Accept> header in your request. If the request method is PUT or POST, the B<Content-Type> header will also be set to XML.

This middleware will also deserialize content in the response. The deserialized content will be store in the B<body> of the response.

=head1 EXAMPLES

=head1 AUTHOR

franck cuny <franck@lumberjaph.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by linkfluence.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

