package CatalystAPI::Model::Users;
use Moose;
use namespace::autoclean;
BEGIN { extends 'Catalyst::Model' }

use List::Util qw/first max/;
use List::MoreUtils qw/first_index/;

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

sub load {
  my ($self, $id) = @_;
  return first { $_->{id} == $id } @data;
}

sub create {
  my ($self, $gift_data) = @_;

  # Verify all fields in place
  return if !$gift_data->{name} || !$gift_data->{img};

  my $next_id = max(map $_->{id}, @data) + 1;
  push @data, { %$gift_data, id => $next_id };
  return $#data;
}

sub update {
  my ($self, $gift_id, $gift_data) = @_;
  return
    if !defined($gift_data->{name})
    || !defined($gift_data->{id});

  my $idx = first_index { $_->{id} == $gift_id } @data;
  return if !defined($idx);

  $data[$idx] = { %$gift_data, id => $gift_id };
  return 1;
}

sub remove {
  my ($self, $gift_id) = @_;
  my $idx = first_index { $_->{id} == $gift_id } @data;

  return if !defined($idx);

  splice @data, $idx, 1;
}
