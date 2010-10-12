package Net::HTTP::Spore::Role::Description;
BEGIN {
  $Net::HTTP::Spore::Role::Description::VERSION = '0.01';
}

# ABSTRACT: attributes for API description

use Moose::Role;
use MooseX::Types::URI qw/Uri/;

has api_base_url => (
    is       => 'rw',
    isa      => Uri,
    coerce   => 1,
    required => 1,
);

has api_format => (
    is        => 'rw',
    isa       => 'ArrayRef',
    predicate => 'has_api_format',
);

has api_authentication => (
    is        => 'rw',
    isa       => 'Bool',
    predicate => 'has_api_authentication',
);

1;

__END__
=pod

=head1 NAME

Net::HTTP::Spore::Role::Description - attributes for API description

=head1 VERSION

version 0.01

=head1 AUTHOR

franck cuny <franck@lumberjaph.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by linkfluence.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

