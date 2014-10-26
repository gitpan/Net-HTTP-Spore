package Net::HTTP::Spore::Role::Debug;
{
  $Net::HTTP::Spore::Role::Debug::VERSION = '0.06';
}

use IO::File;
use Moose::Role;

has trace => (
    is        => 'rw',
    isa       => 'Str',
    predicate => 'has_trace',
    clearer => 'reset_trace',
);

has _trace_fh => (
    is      => 'rw',
    isa     => 'GLOB',
);

sub BUILD {
    my ($self, $args) = @_;
    my $trace;

    $trace = $args->{trace} if $args->{trace};
    $trace = $ENV{SPORE_TRACE} if defined $ENV{SPORE_TRACE};

    if (!defined $trace){
        $self->reset_trace;
        return;
    }

    my ($level, $fh);
    if ( $trace =~ /(\d)=(.+)$/ ) {
        $level = $1;
        my $file  = $2;
        $fh    = IO::File->new( $file, 'w' )
          or die "Cannot open trace file $file";
    }
    else {
        $level = $trace;
        $fh = IO::File->new('>&STDERR')
              or die('Duplication of STDERR for debug output failed (perhaps your STDERR is closed?)');
    }
    $fh->autoflush;
    $self->_trace_fh($fh);
    $self->trace($level);
}

sub _trace_msg {
    my $self     = shift;
    my $template = shift;
    return unless $self->has_trace;

    my $fh = $self->_trace_fh();
    print $fh (sprintf( $template, @_ )."\n");
}

sub _trace_verbose {
    my $self = shift;
    return unless $self->trace && $self->trace > 1;
    $self->_trace_msg(@_);
}

1;

__END__

=pod

=head1 NAME

Net::HTTP::Spore::Role::Debug

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
