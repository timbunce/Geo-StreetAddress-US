use blib;
use Test::More tests => 40;
use strict;
use warnings;
use Data::Dumper;

use_ok( "Geo::StreetAddress::US" );

my %address = (
    "1005 Gravenstein Hwy 95472" => {
	      'number' => '1005',
	      'street' => 'Gravenstein',
	      'state' => undef,
	      'city' => undef,
	      'zip' => '95472',
	      'suffix' => undef,
	      'type' => 'Hwy',
	      'prefix' => undef
	    },
    "1005 Gravenstein Hwy, 95472" => {
	      'number' => '1005',
	      'street' => 'Gravenstein',
	      'state' => undef,
	      'city' => undef,
	      'zip' => '95472',
	      'suffix' => undef,
	      'type' => 'Hwy',
	      'prefix' => undef
	    },
    "1005 Gravenstein Hwy N, 95472" => {
	      'number' => '1005',
	      'street' => 'Gravenstein',
	      'state' => undef,
	      'city' => undef,
	      'zip' => '95472',
	      'suffix' => 'N',
	      'type' => 'Hwy',
	      'prefix' => undef
	    },
    "1005 Gravenstein Highway North, 95472" => {
	      'number' => '1005',
	      'street' => 'Gravenstein',
	      'state' => undef,
	      'city' => undef,
	      'zip' => '95472',
	      'suffix' => 'N',
	      'type' => 'Hwy',
	      'prefix' => undef
	    },
    "1005 N Gravenstein Highway, Sebastopol, CA" => {
	      'number' => '1005',
	      'street' => 'Gravenstein',
	      'state' => 'CA',
	      'city' => 'Sebastopol',
	      'zip' => undef,
	      'suffix' => undef,
	      'type' => 'Hwy',
	      'prefix' => 'N'
	    },
    "1005 N Gravenstein Highway, Suite 500, Sebastopol, CA" => {
	      'number' => '1005',
	      'street' => 'Gravenstein',
	      'state' => 'CA',
	      'city' => 'Sebastopol',
	      'zip' => undef,
	      'suffix' => undef,
	      'type' => 'Hwy',
	      'prefix' => 'N'
	    },
    "1005 N Gravenstein Hwy Suite 500 Sebastopol, CA" => {
	      'number' => '1005',
	      'street' => 'Gravenstein',
	      'state' => 'CA',
	      'city' => 'Sebastopol',
	      'zip' => undef,
	      'suffix' => undef,
	      'type' => 'Hwy',
	      'prefix' => 'N'
	    },
    "1005 N Gravenstein Highway, Sebastopol, CA, 95472" => {
	      'number' => '1005',
	      'street' => 'Gravenstein',
	      'state' => 'CA',
	      'city' => 'Sebastopol',
	      'zip' => '95472',
	      'suffix' => undef,
	      'type' => 'Hwy',
	      'prefix' => 'N'
	    },
    "1005 N Gravenstein Highway Sebastopol CA 95472" => {
	      'number' => '1005',
	      'street' => 'Gravenstein',
	      'state' => 'CA',
	      'city' => 'Sebastopol',
	      'zip' => '95472',
	      'suffix' => undef,
	      'type' => 'Hwy',
	      'prefix' => 'N'
	    },
    "1005 Gravenstein Hwy N Sebastopol CA" => {
	      'number' => '1005',
	      'street' => 'Gravenstein',
	      'state' => 'CA',
	      'city' => 'Sebastopol',
	      'zip' => undef,
	      'suffix' => 'N',
	      'type' => 'Hwy',
	      'prefix' => undef
	    },
    "1005 Gravenstein Hwy N, Sebastopol CA" => {
	      'number' => '1005',
	      'street' => 'Gravenstein',
	      'state' => 'CA',
	      'city' => 'Sebastopol',
	      'zip' => undef,
	      'suffix' => 'N',
	      'type' => 'Hwy',
	      'prefix' => undef
	    },
    "1005 Gravenstein Hwy, N Sebastopol CA" => {
	      'number' => '1005',
	      'street' => 'Gravenstein',
	      'state' => 'CA',
	      'city' => 'North Sebastopol',
	      'zip' => undef,
	      'suffix' => undef,
	      'type' => 'Hwy',
	      'prefix' => undef
	    },
    "1005 Gravenstein Hwy, North Sebastopol CA" => {
	      'number' => '1005',
	      'street' => 'Gravenstein',
	      'state' => 'CA',
	      'city' => 'North Sebastopol',
	      'zip' => undef,
	      'suffix' => undef,
	      'type' => 'Hwy',
	      'prefix' => undef
	    },
    "1005 Gravenstein Hwy Sebastopol CA" => {
	      'number' => '1005',
	      'street' => 'Gravenstein',
	      'state' => 'CA',
	      'city' => 'Sebastopol',
	      'zip' => undef,
	      'suffix' => undef,
	      'type' => 'Hwy',
	      'prefix' => undef
	    },
    "115 Broadway San Francisco CA" => {
	      'number' => '115',
	      'street' => 'Broadway',
	      'state' => 'CA',
	      'city' => 'San Francisco',
	      'zip' => undef,
	      'suffix' => undef,
	      'type' => '',
	      'prefix' => undef
	    },
    "7800 Mill Station Rd, Sebastopol, CA 95472" => {
	      'number' => '7800',
	      'street' => 'Mill Station',
	      'state' => 'CA',
	      'city' => 'Sebastopol',
	      'zip' => '95472',
	      'suffix' => undef,
	      'type' => 'Rd',
	      'prefix' => undef
	    },
    "7800 Mill Station Rd Sebastopol CA 95472" => {
	      'number' => '7800',
	      'street' => 'Mill Station',
	      'state' => 'CA',
	      'city' => 'Sebastopol',
	      'zip' => '95472',
	      'suffix' => undef,
	      'type' => 'Rd',
	      'prefix' => undef
	    },
    "1005 State Highway 116 Sebastopol CA 95472" => {
	      'number' => '1005',
	      'street' => 'State Highway 116',
	      'state' => 'CA',
	      'city' => 'Sebastopol',
	      'zip' => '95472',
	      'suffix' => undef,
	      'type' => 'Hwy',
	      'prefix' => undef
	    },
    "1600 Pennsylvania Ave. Washington DC" => {
	      'number' => '1600',
	      'street' => 'Pennsylvania',
	      'state' => 'DC',
	      'city' => 'Washington',
	      'zip' => undef,
	      'suffix' => undef,
	      'type' => 'Ave',
	      'prefix' => undef
	    },
    "1600 Pennsylvania Avenue Washington DC" => {
	      'number' => '1600',
	      'street' => 'Pennsylvania',
	      'state' => 'DC',
	      'city' => 'Washington',
	      'zip' => undef,
	      'suffix' => undef,
	      'type' => 'Ave',
	      'prefix' => undef
	    },
    "48S 400E, Salt Lake City UT" => {
	      'number' => '48',
	      'street' => '400',
	      'state' => 'UT',
	      'city' => 'Salt Lake City',
	      'zip' => undef,
	      'suffix' => 'E',
	      'type' => '',
	      'prefix' => 'S'
	    },
    "100 South St, Philadelphia, PA" => {
	      'number' => '100',
	      'street' => 'South',
	      'state' => 'PA',
	      'city' => 'Philadelphia',
	      'zip' => undef,
	      'suffix' => undef,
	      'type' => 'St',
	      'prefix' => undef
	    },
    "100 S.E. Washington Ave, Minneapolis, MN" => {
	      'number' => '100',
	      'street' => 'Washington',
	      'state' => 'MN',
	      'city' => 'Minneapolis',
	      'zip' => undef,
	      'suffix' => undef,
	      'type' => 'Ave',
	      'prefix' => 'SE'
	    },
    "3813 1/2 Some Road, Los Angeles, CA" => {
	      'number' => '3813',
	      'street' => 'Some',
	      'state' => 'CA',
	      'city' => 'Los Angeles',
	      'zip' => undef,
	      'suffix' => undef,
	      'type' => 'Rd',
	      'prefix' => undef,
	    },
    "Mission & Valencia San Francisco CA" => {
	      'type1' => '',
	      'type2' => '',
	      'street1' => 'Mission',
	      'state' => 'CA',
	      'suffix2' => undef,
	      'prefix2' => undef,
	      'suffix1' => undef,
	      'zip' => undef,
	      'city' => 'San Francisco',
	      'prefix1' => undef,
	      'street2' => 'Valencia'
	    },
    "Mission & Valencia, San Francisco CA" => {
	      'type1' => '',
	      'type2' => '',
	      'street1' => 'Mission',
	      'state' => 'CA',
	      'suffix2' => undef,
	      'prefix2' => undef,
	      'suffix1' => undef,
	      'zip' => undef,
	      'city' => 'San Francisco',
	      'prefix1' => undef,
	      'street2' => 'Valencia'
	    },
    "Mission St and Valencia St San Francisco CA" => {
	      'type1' => 'St',
	      'type2' => 'St',
	      'street1' => 'Mission',
	      'state' => 'CA',
	      'suffix2' => undef,
	      'prefix2' => undef,
	      'suffix1' => undef,
	      'zip' => undef,
	      'city' => 'San Francisco',
	      'prefix1' => undef,
	      'street2' => 'Valencia'
	    },
    "Mission St & Valencia St San Francisco CA" => {
	      'type1' => 'St',
	      'type2' => 'St',
	      'street1' => 'Mission',
	      'state' => 'CA',
	      'suffix2' => undef,
	      'prefix2' => undef,
	      'suffix1' => undef,
	      'zip' => undef,
	      'city' => 'San Francisco',
	      'prefix1' => undef,
	      'street2' => 'Valencia'
	    },
    "Mission and Valencia Sts San Francisco CA" => {
	      'type1' => 'St',
	      'type2' => 'St',
	      'street1' => 'Mission',
	      'state' => 'CA',
	      'suffix2' => undef,
	      'prefix2' => undef,
	      'suffix1' => undef,
	      'zip' => undef,
	      'city' => 'San Francisco',
	      'prefix1' => undef,
	      'street2' => 'Valencia'
	    },
    "Mission & Valencia Sts. San Francisco CA" => {
	      'type1' => 'St',
	      'type2' => 'St',
	      'street1' => 'Mission',
	      'state' => 'CA',
	      'suffix2' => undef,
	      'prefix2' => undef,
	      'suffix1' => undef,
	      'zip' => undef,
	      'city' => 'San Francisco',
	      'prefix1' => undef,
	      'street2' => 'Valencia'
	    },
    "Mission & Valencia Streets San Francisco CA" => {
	      'type1' => 'St',
	      'type2' => 'St',
	      'street1' => 'Mission',
	      'state' => 'CA',
	      'suffix2' => undef,
	      'prefix2' => undef,
	      'suffix1' => undef,
	      'zip' => undef,
	      'city' => 'San Francisco',
	      'prefix1' => undef,
	      'street2' => 'Valencia'
	    },
    "Mission Avenue and Valencia Street San Francisco CA" => {
	      'type1' => 'Ave',
	      'type2' => 'St',
	      'street1' => 'Mission',
	      'state' => 'CA',
	      'suffix2' => undef,
	      'prefix2' => undef,
	      'suffix1' => undef,
	      'zip' => undef,
	      'city' => 'San Francisco',
	      'prefix1' => undef,
	      'street2' => 'Valencia'
        },
    "1 First St, e San Jose CA" => { # lower case city direction
          'number' => '1',
          'street' => 'First',
          'state' => 'CA',
          'city' => 'East San Jose',
          'zip' => undef,
          'suffix' => undef,
          'type' => 'St',
          'prefix' => undef
        },
    "123 Maple Rochester, New York" => { # space in state name
          'number' => '123',
          'street' => 'Maple',
          'state' => 'NY',
          'city' => 'Rochester',
          'zip' => undef,
          'suffix' => undef,
          'type' => '',
          'prefix' => undef
        },
);

my @failures = (
    "1005 N Gravenstein Hwy Sebastopol",
    "1005 N Gravenstein Hwy Sebastopol CZ",
    "Gravenstein Hwy 95472",
    "E1005 Gravenstein Hwy 95472",
    "1005E Gravenstein Hwy 95472",
);


while (my ($addr, $expected) = each %address) {
    my $parse = Geo::StreetAddress::US->parse_location( $addr );
    is_deeply( $parse, $expected, "can parse $addr" )
        or print Dumper($parse);
}

for my $fail (@failures) {
    my $parse = Geo::StreetAddress::US->parse_location( $fail );
    ok( !$parse || !defined($parse->{state}), "can't parse $fail" );
}
