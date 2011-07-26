package Net::HTTP::Spore::Role::Description;
BEGIN {
  $Net::HTTP::Spore::Role::Description::VERSION = '0.04';
}

# ABSTRACT: attributes for API description

use Moose::Role;
use MooseX::Types::URI qw/Uri/;

has base_url => (
    is       => 'rw',
    isa      => Uri,
    coerce   => 1,
    required => 1,
);

has formats => (
    is        => 'rw',
    isa       => 'ArrayRef',
    predicate => 'has_formats',
);

has authentication => (
    is        => 'rw',
    isa       => 'Bool',
    predicate => 'has_authentication',
);

has expected_status => (
    is      => 'rw',
    isa     => 'Array',
    lazy    => 1,
    default => sub { [] },
);

1;

__END__
=pod

=head1 NAME

Net::HTTP::Spore::Role::Description - attributes for API description

=head1 VERSION

version 0.04

=head1 AUTHOR

franck cuny <franck@lumberjaph.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by linkfluence.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

