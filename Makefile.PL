
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'SPORE client',
  'AUTHOR' => 'franck cuny <franck@lumberjaph.net>',
  'BUILD_REQUIRES' => {
    'Test::Exception' => '0',
    'Test::More' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Net-HTTP-Spore',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Net::HTTP::Spore',
  'PREREQ_PM' => {
    'Carp' => '0',
    'HTTP::Headers' => '0',
    'HTTP::Request' => '0',
    'Hash::MultiValue' => '0',
    'IO::All' => '0',
    'JSON' => '0',
    'LWP::UserAgent' => '0',
    'MIME::Base64' => '0',
    'Moose' => '0',
    'Moose::Exporter' => '0',
    'Moose::Meta::Method' => '0',
    'Moose::Role' => '0',
    'Moose::Util::MetaRole' => '0',
    'Moose::Util::TypeConstraints' => '0',
    'MooseX::Types::Moose' => '0',
    'MooseX::Types::URI' => '0',
    'Net::HTTP::API::Error' => '0',
    'Net::OAuth' => '0',
    'Time::HiRes' => '0',
    'Try::Tiny' => '0',
    'URI' => '0',
    'URI::Escape' => '0',
    'XML::Simple' => '0',
    'YAML' => '0',
    'overload' => '0'
  },
  'VERSION' => '0.01',
  'test' => {
    'TESTS' => 't/*.t t/spore-method/*.t t/spore-middleware/*.t t/spore-request/*.t t/spore-response/*.t t/spore/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);


