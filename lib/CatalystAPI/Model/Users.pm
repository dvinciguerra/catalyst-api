package CatalystAPI::Model::Users;
use Moose;
use namespace::autoclean;
BEGIN { extends 'Catalyst::Model' }

use List::Util qw/first max/;
use List::MoreUtils qw/first_index/;

use 5.20.0;
use experimental 'signatures';

my @data = (
  { id => 1, name => 'User 01', email => 'test1@test.com' },
  { id => 2, name => 'User 02', email => 'test2@test.com' },
  { id => 3, name => 'User 03', email => 'test3@test.com' },
  { id => 4, name => 'User 04', email => 'test4@test.com' },
);

sub _get_data { return @data }


sub all {
  return [ map { id => $_->{id}, name => $_->{name} }, @data ];
}

sub load ($self, $id) {
  return first { $self->{id} == $id } @data;
}

sub create ($self, $data) {
  return if !$data->{name} || !$data->{img};

  my $next_id = max(map $_->{id}, @data) + 1;
  push @data, { %$data, id => $next_id };
  return $#data;
}

sub update ($self, $id, $data) {
  return if !defined($data->{name}) || !defined($data->{id});

  my $idx = first_index { $_->{id} == $id } @data;
  return if !defined($idx);

  $data[$idx] = { %$data, id => $id };
  return 1;
}

sub remove ($self, $id) {
  my $idx = first_index { $self->{id} == $id } @data;
  return if !defined($idx);
  splice @data, $idx, 1;
}
