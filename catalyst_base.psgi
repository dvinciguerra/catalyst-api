use strict;
use warnings;

use CatalystBase;
my $app = CatalystBase->apply_default_middlewares(CatalystBase->psgi_app);
$app;

