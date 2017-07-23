package CatalystAPI::Controller::V1::Users;
use Moose;
use namespace::autoclean;
BEGIN { extends 'Catalyst::Controller::REST' }

use 5.20.0;
use experimental 'signatures';

__PACKAGE__->config(
  action    => { '*' => { Consumes => 'JSON', Path => '' } });

# GET /v1/users
sub list($self, $c) : GET Args(0) {
  $c->stash->{data} = $c->model('Users')->all;
}

# GET /v1/users/1
sub retrieve($self, $c, $id) : GET Args(1) {
  my $data = $c->model('Users')->load($id);

  $c->detach('error', [ 404, "No such user: $id" ]) if !$data;
  return $c->stash->{data} = $data;
}

# POST /v1/users
sub create($self, $c) : POST Args(0) {
  my $params = $c->req->body_data;
  my $id     = $c->model('Users')->create($params);

  $c->detach('error', [ 400, "Invalid gift data" ]) if !$id;
  $c->res->location("/v1/users/$id");
}

# POST /v1/users/1
sub update($self, $c, $id) : POST Args(1) {
  my $params = $c->req->body_data;
  my $ok = $c->model('Users')->update($id, $params);
  $c->detach('error', [ 400, "Fail to update user: $id" ]) if !$ok;
}

# DELETE /v1/users/1
sub delete($self, $c, $id) : DELETE Args(1) {
  my $ok = $c->model('Users')->delete_gift($id);
  $c->detach('error', [ 400, "Invalid user id: $id" ]) if !$ok;
}

sub end($self, $c) : Private {
  $c->forward($c->view('JSON'));
}

sub error($self, $c, $code = 500, $reason = 'Unknown Error') : Private {
  $c->res->status($code);
  $c->stash->{data} = { error => $reason };
}

__PACKAGE__->meta->make_immutable;
1;
