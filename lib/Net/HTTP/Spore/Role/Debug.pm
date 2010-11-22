package Net::HTTP::Spore::Role::Debug;
BEGIN {
  $Net::HTTP::Spore::Role::Debug::VERSION = '0.03';
}

use Moose::Role;

has trace => (
    is      => 'rw',
    isa     => 'Bool',
    lazy    => 1,
    default => sub { $ENV{SPORE_TRACE} ? 1 : 0; }
);

sub _trace_msg { print STDOUT $_[1]."\n" if $_[0]->trace; }

1;

__END__
=pod

=head1 NAME

Net::HTTP::Spore::Role::Debug

=head1 VERSION

version 0.03

=head1 AUTHOR

franck cuny <franck@lumberjaph.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by linkfluence.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

