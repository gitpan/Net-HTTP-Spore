package Net::HTTP::Spore::Middleware;
BEGIN {
  $Net::HTTP::Spore::Middleware::VERSION = '0.01';
}

# ABSTRACT: middlewares base class

use strict;
use warnings;

sub new {
    my $class = shift;
    bless {@_}, $class;
}

sub response_cb {
    my ($self, $cb) = @_;

    my $body_filter = sub {
        my $filter = $cb->(@_);
    };
    return $body_filter;
}

sub wrap {
    my ($self, $cond, @args) = @_;

    if (!ref $self) {
        $self = $self->new(@args);
    }

    return sub {
        my $request = shift;
        if ($cond->($request)) {
            $self->call($request, @_);
        }
    };
}

1;

__END__
=pod

=head1 NAME

Net::HTTP::Spore::Middleware - middlewares base class

=head1 VERSION

version 0.01

=head1 AUTHOR

franck cuny <franck@lumberjaph.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by linkfluence.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
