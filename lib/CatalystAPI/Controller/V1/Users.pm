package CatalystAPI::Controller::V1::Users;
use Moose;
use namespace::autoclean;
BEGIN { extends 'Catalyst::Controller::REST' }

__PACKAGE__->config(
  namespace => 'v1/users',
  action    => { '*' => { Consumes => 'JSON', Path => '' } });

# GET /v1/users
sub list : GET Args(0) {
  my ($self, $c) = @_;
  $c->stash->{data} = $c->model('Users')->all;
}

# GET /v1/users/1
sub retrieve : GET Args(1) {
  my ($self, $c, $id) = @_;
  my $data = $c->model('Users')->load($id);

  $c->detach('error', [ 404, "No such user: $id" ]) if !$data;
  $c->stash->{data} = $data;
}

# POST /v1/users
sub create : POST Args(0) {
  my ($self, $c) = @_;

  my $params = $c->req->body_data;
  my $id     = $c->model('Users')->create($params);

  $c->detach('error', [ 400, "Invalid gift data" ]) if !$id;
  $c->res->location("/v1/users/$id");
}

# POST /v1/users/1
sub update : POST Args(1) {
  my ($self, $c, $id) = @_;
  my $params = $c->req->body_data;
  my $ok = $c->model('Users')->update($id, $params);
  $c->detach('error', [ 400, "Fail to update user: $id" ]) if !$ok;
}

# DELETE /v1/users/1
sub delete : DELETE Args(1) {
  my ($self, $c, $id) = @_;
  my $ok = $c->model('Users')->delete_gift($id);
  $c->detach('error', [ 400, "Invalid user id: $id" ]) if !$ok;
}

sub end : Private {
  my ($self, $c) = @_;
  $c->forward($c->view('JSON'));
}

sub error : Private {
  my ($self, $c, $code, $reason) = @_;
  $reason ||= 'Unknown Error';
  $code   ||= 500;

  $c->res->status($code);
  $c->stash->{data} = { error => $reason };
}

__PACKAGE__->meta->make_immutable;
1;
