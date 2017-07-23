
use Test::Spec;
use Catalyst::Test 'CatalystAPI';
use CatalystAPI::Controller::V1::Users;

describe "Users request" => sub {
  my $endpoint = '/v1/users';

  before each => sub {
    # code to run before every test
  };


  describe "GET $endpoint" => sub {
    it "does return user list" => sub {
      my $page = request($endpoint);
      ok $page->is_success
    };
  };


  describe "POST $endpoint" => sub {
    it "does return user list" => sub {
      my $page = request($endpoint);
      ok $page->is_success
    };
  };

};

runtests unless caller;
