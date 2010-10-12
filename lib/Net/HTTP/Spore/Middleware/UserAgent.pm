package Net::HTTP::Spore::Middleware::UserAgent;
BEGIN {
  $Net::HTTP::Spore::Middleware::UserAgent::VERSION = '0.01';
}

# ABSTRACT: middleware to change the user-agent value

use Moose;
extends qw/Net::HTTP::Spore::Middleware/;

has useragent => (is => 'ro', isa => 'Str', required => 1);

sub call {
    my ($self, $req) = @_;

    $req->header('User-Agent' => $self->useragent);
}

1;


__END__
=pod

=head1 NAME

Net::HTTP::Spore::Middleware::UserAgent - middleware to change the user-agent value

=head1 VERSION

version 0.01

=head1 SYNOPSIS

    my $client = Net::HTTP::Spore->new_from_spec('twitter.json');
    $client->enable('UserAgent', useragent => 'Mozilla/5.0 (X11; Linux x86_64; rv:2.0b4) Gecko/20100818 Firefox/4.0b4');

=head1 DESCRIPTION

Net::HTTP::Spore::Middleware::UserAgent change the default value of the useragent.

=head1 AUTHOR

franck cuny <franck@lumberjaph.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by linkfluence.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

