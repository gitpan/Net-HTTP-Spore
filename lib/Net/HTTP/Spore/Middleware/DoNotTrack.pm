package Net::HTTP::Spore::Middleware::DoNotTrack;
{
  $Net::HTTP::Spore::Middleware::DoNotTrack::VERSION = '0.05';
}

# ABSTRACT: add a new header to not track

use Moose;
extends 'Net::HTTP::Spore::Middleware';

sub call {
    my ($self, $req) = @_;
    $req->header('x-do-not-track' => 1);
}

1;

__END__

=pod

=head1 NAME

Net::HTTP::Spore::Middleware::DoNotTrack - add a new header to not track

=head1 VERSION

version 0.05

=head1 SYNOPSIS

    my $client = Net::HTTP::Spore->new_from_spec('twitter.json');
    $client->enable('DoNotTrack');

=head1 DESCRIPTION

Add a header B<x-do-not-track> to your requests. For more details see L<http://donottrack.us/>.

=head1 AUTHOR

franck cuny <franck@lumberjaph.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by linkfluence.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
