package Net::HTTP::Spore::Role::Description;
{
  $Net::HTTP::Spore::Role::Description::VERSION = '0.06';
}

# ABSTRACT: attributes for API description

use Moose::Role;
use MooseX::Types::Moose qw/ArrayRef/;
use MooseX::Types::URI qw/Uri/;
use Net::HTTP::Spore::Meta::Types qw/Boolean/;

has base_url => (
    is       => 'rw',
    isa      => Uri,
    coerce   => 1,
    required => 1,
);

has formats => (
    is        => 'rw',
    isa       => ArrayRef,
    predicate => 'has_formats',
);

has authentication => (
    is        => 'rw',
    isa       => Boolean,
    predicate => 'has_authentication',
    coerce    => 1,
);

has expected_status => (
    is      => 'rw',
    isa     => ArrayRef,
    lazy    => 1,
    default => sub { [] },
);

1;

__END__

=pod

=head1 NAME

Net::HTTP::Spore::Role::Description - attributes for API description

=head1 VERSION

version 0.06

=head1 AUTHORS

=over 4

=item *

franck cuny <franck@lumberjaph.net>

=item *

Ash Berlin <ash@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by linkfluence.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
