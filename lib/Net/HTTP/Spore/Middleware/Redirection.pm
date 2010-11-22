package Net::HTTP::Spore::Middleware::Redirection;
BEGIN {
  $Net::HTTP::Spore::Middleware::Redirection::VERSION = '0.03';
}

use Moose;

extends 'Net::HTTP::Spore::Middleware';

with 'Net::HTTP::Spore::Role::Request', 'Net::HTTP::Spore::Role::UserAgent';

has max_redirect => ( is => 'rw', isa => 'Int', lazy => 1, default => 5 );

sub call {
    my ( $self, $req ) = @_;

    my $nredirect = 0;

    return $self->response_cb(
        sub {
            my $res      = shift;
            while ( $nredirect < $self->max_redirect ) {
                my $location = $res->header('location');
                my $status   = $res->status;
                if (
                    $location
                    and (  $status == 301
                        or $status == 302
                        or $status == 303
                        or $status == 307 )
                  )
                {
                    my $uri = URI->new($location);
                    $req->env->{HTTP_HOST}   = $uri->host;
                    $req->env->{PATH_INFO}   = $uri->path;
                    $req->env->{SERVER_PORT} = $uri->port;
                    $req->env->{SERVER_NAME} = $uri->host;
                    $res = $self->_request($req);
                    $nredirect++;
                }else{
                    last;
                }
            }
            return $res;
        }
    );
}

1;

__END__
=pod

=head1 NAME

Net::HTTP::Spore::Middleware::Redirection

=head1 VERSION

version 0.03

=head1 AUTHOR

franck cuny <franck@lumberjaph.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by linkfluence.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

