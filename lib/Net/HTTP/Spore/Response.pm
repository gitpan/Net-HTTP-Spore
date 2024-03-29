package Net::HTTP::Spore::Response;
{
  $Net::HTTP::Spore::Response::VERSION = '0.06';
}

# ABSTRACT: Portable HTTP Response object for SPORE response

use strict;
use warnings;

use overload
    '@{}' => \&finalize,
    '""' => \&to_string,
    fallback => 1;

use HTTP::Headers;

sub new {
    my ( $class, $rc, $headers, $body ) = @_;

    my $self = bless {}, $class;

    $self->status($rc) if defined $rc;
    $self->body($body) if defined $body;
    $self->headers( $headers || [] );
    $self;
}

sub code           { shift->status(@_) }
sub content        { shift->body(@_) }
sub env            { shift->request->env }
sub content_type   { shift->headers->content_type(@_) }
sub content_length { shift->headers->content_length(@_) }
sub location       { shift->header->header( 'Location' => @_ ) }
sub is_success     { shift->status =~ /^2\d\d$/ }

sub status {
    my $self = shift;
    if (@_) {
        $self->{status} = shift;
    }
    else {
        return $self->{status};
    }
}

sub body {
    my $self = shift;
    if (@_) {
        $self->{body} = shift;
        if ( !defined $self->{raw_body} ) {
            $self->{raw_body} = $self->{body};
        }
    }
    else {
        return $self->{body};
    }
}

sub raw_body {
    my $self = shift;
    if (@_) {
        $self->{raw_body} = shift;
    }else{
        return $self->{raw_body};
    }
}

sub headers {
    my $self = shift;
    if (@_) {
        my $headers = shift;
        if ( ref $headers eq 'ARRAY' ) {
            $headers = HTTP::Headers->new(@$headers);
        }
        elsif ( ref $headers eq 'HASH' ) {
            $headers = HTTP::Headers->new(%$headers);
        }
        $self->{headers} = $headers;
    }
    else {
        return $self->{headers} ||= HTTP::Headers->new();
    }
}

sub request {
    my $self = shift;
    if (@_) {
        $self->{request} = shift;
    }else{
        return $self->{request};
    }
}

sub header {
    my $self = shift;
    $self->headers->header(@_);
}

sub to_string {
    my $self = shift;
    my $status = "HTTP status: ".$self->{status};
    if ($self->{body} =~ /read timeout/){
        $status .= " - read timeout";
    }
    return $status;
}

sub finalize {
    my $self = shift;

    return [
        $self->status,
        +[
            map {
                my $k = $_;
                map { ( $k => $_ ) } $self->headers->header($_);
              } $self->headers->header_field_names
        ],
        $self->body,
    ];
}

1;

__END__

=pod

=head1 NAME

Net::HTTP::Spore::Response - Portable HTTP Response object for SPORE response

=head1 VERSION

version 0.06

=head1 SYNOPSIS

    use Net:HTTP::Spore::Response;

    my $response = Net::HTTP::Spore::Response->new(
        200, ['Content-Type', 'application/json'], '{"foo":1}';
    );
    $response->request($request);

=head1 DESCRIPTION

Net::HTTP::Spore::Response create a HTTP response

=head1 METHODS

=over 4

=item new

    my $res = Net::HTTP::Spore::Response->new;
    my $res = Net::HTTP::Spore::Response->new($status);
    my $res = Net::HTTP::Spore::Response->new($status, $headers);
    my $res = Net::HTTP::Spore::Response->new($status, $headers, $body);

Creates a new Net::HTTP::Spore::Response object.

=item code

=item status

    $res->status(200);
    my $status = $res->status;

Gets or sets the HTTP status of the response

=item env

   $res->env($env);
   my $env = $res->env;

Gets or sets the environment for the response. Shortcut to C<< $res->request->env >>

=item content

=item body

    $res->body($body);
    my $body = $res->body;

Gets or sets the body for the response

=item raw_body

    my $raw_body = $res->raw_body

The raw_body value is the same as body when the body is sets for the first time.

=item content_type

    $res->content_type('application/json');
    my $ct = $res->content_type;

Gets or sets the content type of the response body

=item content_length

    $res->content_length(length($body));
    my $cl = $res->content_length;

Gets or sets the content type of the response body

=item location

    $res->location('http://example.com');
    my $location = $res->location;

Gets or sets the location header for the response

=item request

    $res->request($request);
    $request = $res->request;

Gets or sets the HTTP request that created the current HTTP response.

=item headers

    $headers = $res->headers;
    $res->headers(['Content-Type' => 'application/json']);

Gets or sets HTTP response headers.

=item header

    my $cl = $res->header('Content-Length');
    $res->header('Content-Type' => 'application/json');

Shortcut for C<< $res->headers->header >>.

=item finalise

    my $res = Net::HTTP::Response->new($status, $headers, $body);
    say "http status is ".$res->[0];

Return an arrayref:

=over 2

=item status

The first element of the array ref is the HTTP status

=item headers

The second element is an arrayref containing the list of HTTP headers

=item body

The third and final element is the body

=back

=back

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
