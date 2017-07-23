use strict;
use warnings;

use CatalystAPI;

my $app = CatalystAPI->apply_default_middlewares(CatalystAPI->psgi_app);
$app;

