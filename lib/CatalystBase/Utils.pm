package CatalystBase::Utils;
use common::sense;

use Crypt::PRNG qw(random_string);
use Data::Section::Simple qw(get_data_section);

use vars qw(@ISA @EXPORT);

@ISA    = (qw(Exporter));
@EXPORT = qw(is_test truncate_money);

sub is_test {
    if ( $ENV{HARNESS_ACTIVE} || $0 =~ m{forkprove} ) {
        return 1;
    }
    return 0;
}

sub truncate_money {
    my $number = shift;

    if ( !defined($number) || $number < 0 ) {
        die "invalid number";
    }

    return int( $number * 100 ) / 100;
}

1;
