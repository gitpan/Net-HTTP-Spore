package Net::HTTP::Spore::Role::Request;
BEGIN {
  $Net::HTTP::Spore::Role::Request::VERSION = '0.01';
}

# ABSTRACT: make HTTP request

use Try::Tiny;
use Moose::Role;

use Net::HTTP::Spore::Request;

sub http_request {
    my ( $self, $env ) = @_;

    my ($request, $response);
    $request = Net::HTTP::Spore::Request->new($env);

    my @middlewares;
    foreach my $mw ( $self->middlewares ) {
        my $res;
        try {
            $res = $mw->($request);
        }
        catch {
            $res = $request->new_response( 599, [], { error => $_, } );
        };

        if ( ref $res && ref $res eq 'CODE' ) {
            push @middlewares, $res;
        }
        elsif ( ref $res && ref $res eq 'Net::HTTP::Spore::Response' ) {
            return $res if ($res->status == 599);
            $response = $res;
            last;
        }
    }

    if (defined $response) {
        map { $_->($response) } reverse @middlewares;
        return $response;
    }

    my $result = $self->request($request->finalize);

    $response = $request->new_response(
        $result->code,
        $result->headers,
        $result->content,
    );

    map { $_->($response) } reverse @middlewares;

    $response;
}

1;


__END__
=pod

=head1 NAME

Net::HTTP::Spore::Role::Request - make HTTP request

=head1 VERSION

version 0.01

=head1 SYNOPSIS

=head1 DESCRIPTION

=head2 METHODS

=over 4

=item B<http_request>

=back

=head2 ATTRIBUTES

=over 4

=item B<api_base_url>

=back

=head1 AUTHOR

franck cuny <franck@lumberjaph.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by linkfluence.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

