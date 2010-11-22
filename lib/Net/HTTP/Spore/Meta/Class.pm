package Net::HTTP::Spore::Meta::Class;
BEGIN {
  $Net::HTTP::Spore::Meta::Class::VERSION = '0.03';
}

# ABSTRACT: metaclass for all API client

use Moose::Role;

with qw/Net::HTTP::Spore::Meta::Method::Spore Net::HTTP::Spore::Role::Debug/;

1;


__END__
=pod

=head1 NAME

Net::HTTP::Spore::Meta::Class - metaclass for all API client

=head1 VERSION

version 0.03

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 AUTHOR

franck cuny <franck@lumberjaph.net>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by linkfluence.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

