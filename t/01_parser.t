use blib;
use strict;
use warnings;
use Data::Dumper qw( Dumper );
use Test::More;

use_ok( "Geo::StreetAddress::US" );

my %address = (
    "1005 Gravenstein Hwy 95472" => {
          'number' => '1005',
          'street' => 'Gravenstein',
          'zip' => '95472',
          'type' => 'Hwy',
        },
    "1005 Gravenstein Hwy, 95472" => {
          'number' => '1005',
          'street' => 'Gravenstein',
          'zip' => '95472',
          'type' => 'Hwy',
        },
    "1005 Gravenstein Hwy N, 95472" => {
          'number' => '1005',
          'street' => 'Gravenstein',
          'zip' => '95472',
          'suffix' => 'N',
          'type' => 'Hwy',
        },
    "1005 Gravenstein Highway North, 95472" => {
          'number' => '1005',
          'street' => 'Gravenstein',
          'zip' => '95472',
          'suffix' => 'N',
          'type' => 'Hwy',
        },
    "1005 N Gravenstein Highway, Sebastopol, CA" => {
          'number' => '1005',
          'street' => 'Gravenstein',
          'state' => 'CA',
          'city' => 'Sebastopol',
          'type' => 'Hwy',
          'prefix' => 'N'
        },
    "1005 N Gravenstein Highway, Suite 500, Sebastopol, CA" => {
          'number' => '1005',
          'street' => 'Gravenstein',
          'state' => 'CA',
          'city' => 'Sebastopol',
          'type' => 'Hwy',
          'prefix' => 'N',
          'sec_unit_type' => 'Suite',
          'sec_unit_num' => '500',
        },
    "1005 N Gravenstein Hwy Suite 500 Sebastopol, CA" => {
          'number' => '1005',
          'street' => 'Gravenstein',
          'state' => 'CA',
          'city' => 'Sebastopol',
          'type' => 'Hwy',
          'prefix' => 'N',
          'sec_unit_type' => 'Suite',
          'sec_unit_num' => '500',
        },
    "1005 N Gravenstein Highway, Sebastopol, CA, 95472" => {
          'number' => '1005',
          'street' => 'Gravenstein',
          'state' => 'CA',
          'city' => 'Sebastopol',
          'zip' => '95472',
          'type' => 'Hwy',
          'prefix' => 'N'
        },
    "1005 N Gravenstein Highway Sebastopol CA 95472" => {
          'number' => '1005',
          'street' => 'Gravenstein',
          'state' => 'CA',
          'city' => 'Sebastopol',
          'zip' => '95472',
          'type' => 'Hwy',
          'prefix' => 'N'
        },
    "1005 Gravenstein Hwy N Sebastopol CA" => {
          'number' => '1005',
          'street' => 'Gravenstein',
          'state' => 'CA',
          'city' => 'Sebastopol',
          'suffix' => 'N',
          'type' => 'Hwy',
        },
    "1005 Gravenstein Hwy N, Sebastopol CA" => {
          'number' => '1005',
          'street' => 'Gravenstein',
          'state' => 'CA',
          'city' => 'Sebastopol',
          'suffix' => 'N',
          'type' => 'Hwy',
        },
    "1005 Gravenstein Hwy, N Sebastopol CA" => {
          'number' => '1005',
          'street' => 'Gravenstein',
          'state' => 'CA',
          'city' => 'North Sebastopol',
          'type' => 'Hwy',
        },
    "1005 Gravenstein Hwy, North Sebastopol CA" => {
          'number' => '1005',
          'street' => 'Gravenstein',
          'state' => 'CA',
          'city' => 'North Sebastopol',
          'type' => 'Hwy',
        },
    "1005 Gravenstein Hwy Sebastopol CA" => {
          'number' => '1005',
          'street' => 'Gravenstein',
          'state' => 'CA',
          'city' => 'Sebastopol',
          'type' => 'Hwy',
        },
    "115 Broadway San Francisco CA" => {
          'type' => '',
          'number' => '115',
          'street' => 'Broadway',
          'state' => 'CA',
          'city' => 'San Francisco',
        },
    "7800 Mill Station Rd, Sebastopol, CA 95472" => {
          'number' => '7800',
          'street' => 'Mill Station',
          'state' => 'CA',
          'city' => 'Sebastopol',
          'zip' => '95472',
          'type' => 'Rd',
        },
    "7800 Mill Station Rd Sebastopol CA 95472" => {
          'number' => '7800',
          'street' => 'Mill Station',
          'state' => 'CA',
          'city' => 'Sebastopol',
          'zip' => '95472',
          'type' => 'Rd',
        },
    "1005 State Highway 116 Sebastopol CA 95472" => {
          'number' => '1005',
          'street' => 'State Highway 116',
          'state' => 'CA',
          'city' => 'Sebastopol',
          'zip' => '95472',
          'type' => 'Hwy',
        },
    "1600 Pennsylvania Ave. Washington DC" => {
          'number' => '1600',
          'street' => 'Pennsylvania',
          'state' => 'DC',
          'city' => 'Washington',
          'type' => 'Ave',
        },
    "1600 Pennsylvania Avenue Washington DC" => {
          'number' => '1600',
          'street' => 'Pennsylvania',
          'state' => 'DC',
          'city' => 'Washington',
          'type' => 'Ave',
        },
    "48S 400E, Salt Lake City UT" => {
          'type' => '',
          'number' => '48',
          'street' => '400',
          'state' => 'UT',
          'city' => 'Salt Lake City',
          'suffix' => 'E',
          'prefix' => 'S'
        },
    "550 S 400 E #3206, Salt Lake City UT 84111" => {
            'number' => '550',
            'street' => '400',
            'state' => 'UT',
            'sec_unit_num' => '3206',
            'zip' => '84111',
            'city' => 'Salt Lake City',
            'suffix' => 'E',
            'type' => '',
            'sec_unit_type' => '#',
            'prefix' => 'S'
    },
    "6641 N 2200 W Apt D304 Park City, UT 84098" => {
          'number' => '6641',
          'street' => '2200',
          'state' => 'UT',
          'sec_unit_num' => 'D304',
          'zip' => '84098',
          'city' => 'Park City',
          'suffix' => 'W',
          'type' => '',
          'sec_unit_type' => 'Apt',
          'prefix' => 'N'
    },
    "100 South St, Philadelphia, PA" => {
          'number' => '100',
          'street' => 'South',
          'state' => 'PA',
          'city' => 'Philadelphia',
          'type' => 'St',
        },
    "100 S.E. Washington Ave, Minneapolis, MN" => {
          'number' => '100',
          'street' => 'Washington',
          'state' => 'MN',
          'city' => 'Minneapolis',
          'type' => 'Ave',
          'prefix' => 'SE'
        },
    "3813 1/2 Some Road, Los Angeles, CA" => {
          'number' => '3813',
          'street' => 'Some',
          'state' => 'CA',
          'city' => 'Los Angeles',
          'type' => 'Rd',
        },
    "Mission & Valencia San Francisco CA" => {
          'type1' => '',
          'type2' => '',
          'street1' => 'Mission',
          'state' => 'CA',
          'city' => 'San Francisco',
          'street2' => 'Valencia'
        },
    "Mission & Valencia, San Francisco CA" => {
          'type1' => '',
          'type2' => '',
          'street1' => 'Mission',
          'state' => 'CA',
          'city' => 'San Francisco',
          'street2' => 'Valencia'
        },
    "Mission St and Valencia St San Francisco CA" => {
          'type1' => 'St',
          'type2' => 'St',
          'street1' => 'Mission',
          'state' => 'CA',
          'city' => 'San Francisco',
          'street2' => 'Valencia'
        },
    "Mission St & Valencia St San Francisco CA" => {
          'type1' => 'St',
          'type2' => 'St',
          'street1' => 'Mission',
          'state' => 'CA',
          'city' => 'San Francisco',
          'street2' => 'Valencia'
        },
    "Mission and Valencia Sts San Francisco CA" => {
          'type1' => 'St',
          'type2' => 'St',
          'street1' => 'Mission',
          'state' => 'CA',
          'city' => 'San Francisco',
          'street2' => 'Valencia'
        },
    "Mission & Valencia Sts. San Francisco CA" => {
          'type1' => 'St',
          'type2' => 'St',
          'street1' => 'Mission',
          'state' => 'CA',
          'city' => 'San Francisco',
          'street2' => 'Valencia'
        },
    "Mission & Valencia Streets San Francisco CA" => {
          'type1' => 'St',
          'type2' => 'St',
          'street1' => 'Mission',
          'state' => 'CA',
          'city' => 'San Francisco',
          'street2' => 'Valencia'
        },
    "Mission Avenue and Valencia Street San Francisco CA" => {
          'type1' => 'Ave',
          'type2' => 'St',
          'street1' => 'Mission',
          'state' => 'CA',
          'city' => 'San Francisco',
          'street2' => 'Valencia'
        },
    "1 First St, e San Jose CA" => { # lower case city direction
          'number' => '1',
          'street' => 'First',
          'state' => 'CA',
          'city' => 'East San Jose',
          'type' => 'St',
        },
    "123 Maple Rochester, New York" => { # space in state name
          'type' => '',
          'number' => '123',
          'street' => 'Maple',
          'state' => 'NY',
          'city' => 'Rochester',
        },
    "233 S Wacker Dr 60606-6306" => { # zip+4 with hyphen
          'number' => '233',
          'street' => 'Wacker',
          'zip' => '60606',
          'type' => 'Dr',
          'prefix' => 'S'
        },
    "233 S Wacker Dr 606066306" => { # zip+4 without hyphen
          'number' => '233',
          'street' => 'Wacker',
          'zip' => '60606',
          'type' => 'Dr',
          'prefix' => 'S'
        },
    "233 S Wacker Dr lobby 60606" => { # unnumbered secondary unit type
          'number' => '233',
          'street' => 'Wacker',
          'zip' => '60606',
          'type' => 'Dr',
          'prefix' => 'S',
          'sec_unit_type' => 'lobby',
        },
    "(233 S Wacker Dr lobby 60606)" => { # surrounding punctuation
          'number' => '233',
          'street' => 'Wacker',
          'zip' => '60606',
          'type' => 'Dr',
          'prefix' => 'S',
          'sec_unit_type' => 'lobby',
        },
    "#42 233 S Wacker Dr 60606" => { # leading numbered secondary unit type
          'sec_unit_num' => '42',
          'zip' => '60606',
          'number' => '233',
          'street' => 'Wacker',
          'sec_unit_type' => '#',
          'type' => 'Dr',
          'prefix' => 'S'
        },
    "lt42 99 Some Road, Some City LA" => { # no space before sec_unit_num
          'sec_unit_num' => '42',
          'city' => 'Some City',
          'number' => '99',
          'street' => 'Some',
          'sec_unit_type' => 'lt',
          'type' => 'Rd',
          'state' => 'LA'
        },
    "36401 County Road 43, Eaton, CO 80615" => { # numbered County Road
          'city' => 'Eaton',
          'zip' => '80615',
          'number' => '36401',
          'street' => 'County Road 43',
          'type' => 'Rd',
          'state' => 'CO'
        },
    "1234 COUNTY HWY 60E, Town, CO 12345" => {
        'city' => 'Town',
        'zip' => '12345',
        'number' => '1234',
        'street' => 'COUNTY HWY 60',
        'suffix' => 'E',
        'type'   => 'Hwy',
        'state' => 'CO'
        },

    "321 S. Washington" => { # RT#82146
          'type' => '',
          'prefix' => 'S',
          'street' => 'Washington',
          'number' => '321'
        },

    "'45 Quaker Ave, Ste 105'" => { # RT#73397
          'number' => '45',
          'street' => 'Quaker',
          'type' => 'Ave',
          'sec_unit_num' => '105',
          'sec_unit_type' => 'Ste'
        },
    '123 West Main Avenue apt 9N' => {
        number        => '123',
        prefix        => 'W',
        street        => 'Main',
        type          => 'Ave',
        sec_unit_type => 'apt',
        sec_unit_num  => '9N',
    },
    '123 Main St 123456' => {
        number        => '123',
        street        => 'Main',
        type          => 'St',
        sec_unit_num  => '123456',
    },
    '123 Main Blvd FT456' => {
        number        => '123',
        street        => 'Main',
        type          => 'Blvd',
        sec_unit_num  => '456',
        sec_unit_type => 'FT',
    },
    '1234 Main AV #567' => {
        number        => '1234',
        street        => 'Main',
        type          => 'Ave',
        sec_unit_type => '#',
        sec_unit_num  => '567',
    },
    '123 County Road 456' => {
        number        => '123',
        street        => 'County Road 456',
        type          => 'Rd',
    },
    '123 County Road 4' => {
        number        => '123',
        street        => 'County Road 4',
        type          => 'Rd',
    },
    '123 County Road 4567' => {
        number        => '123',
        street        => 'County Road 4567',
        type          => 'Rd',
    },
    '1234 Main Road FIP #567B' => {
        number        => '1234',
        street        => 'Main',
        type          => 'Rd',
        sec_unit_type => '#',
        sec_unit_num  => '567B',
    },
    '1234 NW 56th ST Apt7890' => {
        number        => '1234',
        prefix        => 'NW',
        street        => '56th',
        type          => 'St',
        sec_unit_type => 'Apt',
        sec_unit_num  => '7890',
    },
    '1234 Main Ave B2' => {
        number        => '1234',
        street        => 'Main',
        type          => 'Ave',
        sec_unit_num  => 'B2',
    },
    '1234 Highway 56 S' => {
        number        => '1234',
        street        => 'Highway 56',
        type          => 'Hwy',
        suffix        => 'S',
    },
    '123 Road 4567' => {
        number        => '123',
        street        => 'Road 4567',
        type          => 'Rd',
    },
    '1234 NW 56th Street 789' => {
        number        => '1234',
        prefix        => 'NW',
        street        => '56th',
        type          => 'St',
        sec_unit_num  => '789',
    },
    '12 N. St. Boethius Blvd.' => {
        number        => '12',
        prefix        => 'N',
        street        => 'St Boethius',
        type          => 'Blvd',
    },
    '12 Main , Apt 3' => {
        number        => '12',
        street        => 'Main',
        type          => '',
        sec_unit_type => 'Apt',
        sec_unit_num  => '3',
    },
    '1 E 24th St, Suite 567' => {
        number        => '1',
        prefix        => 'E',
        street        => '24th',
        type          => 'St',
        sec_unit_type => 'Suite',
        sec_unit_num  => '567',
    },
    '1 E. 24th St., Suite 567' => {
        number        => '1',
        prefix        => 'E',
        street        => '24th',
        type          => 'St',
        sec_unit_type => 'Suite',
        sec_unit_num  => '567',
    },
    '1234 Main Dr.NE. Apartment D5.' => {
        number        => '1234',
        street        => 'Main',
        type          => 'Dr',
        suffix        => 'NE',
        sec_unit_type => 'Apartment',
        sec_unit_num  => 'D5',
    },
    '12345 HIGHWAY 67 S' => {
        number        => '12345',
        street        => 'HIGHWAY 67',
        type          => 'Hwy',
        suffix        => 'S',
    },
    '1234 Highway 56 East' => {
        number        => '1234',
        street        => 'Highway 56',
        type          => 'Hwy',
        suffix        => 'E',
    },
    '1234 Main Drive, Apt 567' => {
        number        => '1234',
        street        => 'Main',
        type          => 'Dr',
        sec_unit_type => 'Apt',
        sec_unit_num  => '567',
    },
    '1234 NW 56th Street 567' => {
        number        => '1234',
        prefix        => 'NW',
        street        => '56th',
        type          => 'St',
        sec_unit_num  => '567',
    },
    '12 Main Place 4' => {
        number        => '12',
        street        => 'Main',
        type          => 'Pl',
        sec_unit_num  => '4',
    },
    '1234 LA MAIN MARINA' => {
        number        => '1234',
        street        => 'LA MAIN',
        type          => 'Marina',
    },
    '1234 W. Main Blvd.' => {
        number        => '1234',
        prefix        => 'W',
        street        => 'Main',
        type          => 'Blvd',
    },
    '1234 Hwy T56 S' => {
        number        => '1234',
        street        => 'Hwy T56',
        type          => 'Hwy',
        suffix        => 'S',
    },
    '12345 Main St 67' => {
        number        => '12345',
        street        => 'Main',
        type          => 'St',
        sec_unit_num  => '67',
    },
    '123 Main Drive SPO # 4567' => {
        number        => '123',
        street        => 'Main',
        type          => 'Dr',
        sec_unit_type => 'SPO #',
        sec_unit_num  => '4567',
    },
    '123 Main Ave Unit 4 123 Main Ave., Unit 4' => { # Almost double
        number        => '123',
        street        => 'Main Ave Unit 4 123 Main', # Not great, but poor input
        type          => 'Ave',
        sec_unit_type => 'Unit',
        sec_unit_num  => '4',
    },
    '123 E Main St., Suite A' => {
        number        => '123',
        prefix        => 'E',
        street        => 'Main',
        type          => 'St',
        sec_unit_type => 'Suite',
        sec_unit_num  => 'A',
    },
    '123 E Main St, Suite A' => {
        number        => '123',
        prefix        => 'E',
        street        => 'Main',
        type          => 'St',
        sec_unit_type => 'Suite',
        sec_unit_num  => 'A',
    },
    '1234 Main Drive, apt 567' => {
        number        => '1234',
        street        => 'Main',
        type          => 'Dr',
        sec_unit_type => 'apt',
        sec_unit_num  => '567',
    },
    'N1234 5th Avenue' => {
        street        => '5th',
        type          => 'Ave',
        sec_unit_num  => 'N1234', # Arguable
    },
    '123 Great Main Ct' => {
        number        => '123',
        street        => 'Great Main',
        type          => 'Ct',
    },
    'W1234 Main rd' => {
        street        => 'Main',
        type          => 'Rd',
        sec_unit_num  => 'W1234', # Arguable
    },
    '1234 nw cove cir.' => {
        number        => '1234',
        prefix        => 'nw',
        street        => 'cove',
        type          => 'Cir',
    },
    '1234 nw cove cir' => {
        number        => '1234',
        prefix        => 'nw',
        street        => 'cove',
        type          => 'Cir',
    },
    'N1234 MAIN LN' => {
        street        => 'MAIN',
        type          => 'Ln',
        sec_unit_num  => 'N1234', # Arguable
    },
    '1 S.4th Ave' => {
        number        => '1',
        prefix        => 'S',
        street        => '4th',
        type          => 'Ave',
    },
    '1234 Main Street, Suite 567' => {
        number        => '1234',
        street        => 'Main',
        type          => 'St',
        sec_unit_type => 'Suite',
        sec_unit_num  => '567',
    },
    '1234 Van Zandt County Road 5678' => {
        number        => '1234',
        street        => 'Van Zandt County Road 5678',
        type          => 'Rd',
    },
    '123 Main Ave SW, Suite A' => {
        number        => '123',
        street        => 'Main',
        type          => 'Ave',
        suffix        => 'SW',
        sec_unit_type => 'Suite',
        sec_unit_num  => 'A',
    },
    '12 Main Place 3' => {
        number        => '12',
        street        => 'Main',
        type          => 'Pl',
        sec_unit_num  => '3',
    },
    '1234 Main Dr, Apt 56789' => {
        number        => '1234',
        street        => 'Main',
        type          => 'Dr',
        sec_unit_type => 'Apt',
        sec_unit_num  => '56789',
    },
    'W1234 Cty Rd FF' => {
        street        => 'Cty',
        type          => 'Rd',
        sec_unit_num  => 'W1234',
    },
    '12345 Mainy Main Ct.' => {
        number        => '12345',
        street        => 'Mainy Main',
        type          => 'Ct',
    },
    'S1234 Main St' => {
        street        => 'Main',
        type          => 'St',
        sec_unit_num  => 'S1234',
    },
    '12345                                                           NW 601st Rd.AB-7890123' => {
        number        => '12345',
        prefix        => 'NW',
        street        => '601st',
        type          => 'Rd',
        sec_unit_num  => '7890123',
    },
    '1234 Main Dr, 56' => {
        number        => '1234',
        street        => 'Main',
        type          => 'Dr',
        sec_unit_num  => '56',
    },
    '1234 Main Circle # 5' => {
        number        => '1234',
        street        => 'Main',
        type          => 'Cir',
        sec_unit_type => '#',
        sec_unit_num  => '5',
    },
    '123 Main Ave.#4A' => {
        number        => '123',
        street        => 'Main',
        type          => 'Ave',
        sec_unit_type => '#',
        sec_unit_num  => '4A',
    },
    '1234 Main #56' => {
        number        => '1234',
        street        => 'Main',
        type          => '',
        sec_unit_type => '#',
        sec_unit_num  => '56',
    },
    '1234 S. Main Mall #5678' => {
        number        => '1234',
        prefix        => 'S',
        street        => 'Main',
        type          => 'Mall',
        sec_unit_type => '#',
        sec_unit_num  => '5678',
    },
    'Post Office Box 12345' => {
        sec_unit_num => '12345',
        sec_unit_type => 'PO Box',
    },
    'Unit 12345 Box 678' => { # Poor
        street        => 'Box',
        type          => '',
        sec_unit_type => 'Unit',
        sec_unit_num  => '12345',
    },
    'PO Box 1234' => {
        sec_unit_type => 'PO Box',
        sec_unit_num  => '1234',
    },
    'P.O. 1234' => {
        sec_unit_type => 'PO Box',
        sec_unit_num  => '1234',
    },
    '1234 West Main Drive 5A' => {
        number        => '1234',
        prefix        => 'W',
        street        => 'Main',
        type          => 'Dr',
        sec_unit_num  => '5A',
    },
    '123 Main Pl 45A' => {
        number        => '123',
        street        => 'Main',
        type          => 'Pl',
        sec_unit_num  => '45A',
    },
    # Problematic. We require zip to come at end, so ABC confuses things in
    # that regard. ShipMe could presumably be treated as a unit, but even that
    # seems arguable.
    '1234 NW 56th Avenue ShipMe 78901 ABC' => { # Poor
        number        => '1234',
        prefix        => 'NW',
        street        => '56th',
        type          => 'Ave',
        sec_unit_type => 'ShipMe',
        sec_unit_num  => '78901',
    },
    '1234 Main Drive ABC Pod A' => {
        number        => '1234',
        street        => 'Main',
        type          => 'Dr',
        sec_unit_type => 'Pod',
        sec_unit_num  => 'A',
    },
    '1 N 21st Ave Hammock' => { # Poor
        number        => '1',
        prefix        => 'N',
        street        => '21st',
        type          => 'Ave',
    },
    'Ab 12 box 3456' => { # Poor
        street        => 'Ab',
        type          => '',
        sec_unit_num  => '12',
    },
    '1234 east Avenue a5' => { # Poor
        number        => '1234',
        street        => 'east',
        type          => 'Ave',
        sec_unit_num  => 'a5',
    },
    '1234 N Main Rd A5-678' => {
        number        => '1234',
        prefix        => 'N',
        street        => 'Main',
        type          => 'Rd',
        sec_unit_num  => 'A5-678',
    },
    '12345 NW 61ST ST STE 789 0123456' => { # Poor
        number        => '12345',
        prefix        => 'NW',
        street        => '61ST',
        type          => 'St',
        sec_unit_type => 'STE', # Suite
        sec_unit_num  => '789 0123456',
    },
    '12345 co rd 14' => {
        number        => '12345',
        street        => 'co rd 14',
        type          => 'Rd',
    },
    '123 E. Ave. A-4' => {
        number        => '123',
        street        => 'E',
        type          => 'Ave',
        sec_unit_num  => 'A-4',
    },
    '123 N Main Street, 4A' => {
        number        => '123',
        prefix        => 'N',
        street        => 'Main',
        type          => 'St',
        sec_unit_num  => '4A',
    },
    '1234 S Main' => {
        number        => '1234',
        prefix        => 'S',
        street        => 'Main',
        type          => '',
    },
    '1234 Main Dr Apt 5 A' => {
        number        => '1234',
        street        => 'Main',
        type          => 'Dr',
        sec_unit_type => 'Apt',
        sec_unit_num  => '5 A',
    },
    '123 Main Pl 45a' => {
        number        => '123',
        street        => 'Main',
        type          => 'Pl',
        sec_unit_num  => '45a',
    },
    '1234 E Farm Rd 567' => {
        number        => '1234',
        prefix        => 'E',
        street        => 'Farm Rd 567',
        type          => 'Rd',
    },
    '1234 Ga hwy 567' => {
        number        => '1234',
        street        => 'Ga hwy 567',
        type          => 'Hwy',
    },
    '123 42nd Avenue Southeast, A' => {
        number        => '123',
        street        => '42nd',
        type          => 'Ave',
        suffix        => 'SE',
        sec_unit_num  => 'A',
    },
    '123 Main Ave, 45th Floor' => {
        number        => '123',
        street        => 'Main',
        type          => 'Ave',
        sec_unit_num  => '45th',
        sec_unit_type => 'Floor',
    },
    '123 Main Ave 4a' => {
        number        => '123',
        street        => 'Main',
        type          => 'Ave',
        sec_unit_num  => '4a',
    },
    # Ideally we could treat Big Beach as city and pull zipcode. However there
    # are issues doing that as it is easy to confuse them with street names and
    # vice versa.
    '1234 Main Blvd, Big Beach, 56789' => {
        number        => '1234',
        street        => 'Main',
        type          => 'Blvd',
    },
    '1234  Main Drive 567, 1234  Main Drive567' => { # Poor
        number        => '1234',
        street        => 'Main',
        type          => 'Dr',
        sec_unit_num  => '567',
    },
    '12345 N 63rd Ave #7890 12345 N 63rd Ave #7890' => { # Poor
        number        => '12345',
        prefix        => 'N',
        street        => '63rd Ave #7890 12345 N 63rd', # Not ideal
        type          => 'Ave',
        sec_unit_type => '#',
        sec_unit_num  => '7890',
    },
    '123 Main Blvd AB0123456789' => {
        number        => '123',
        street        => 'Main',
        type          => 'Blvd',
        sec_unit_num  => '0123456789',
    },
    '1234 W MAIN ST APT 5 APT 6' => { # Poor
        number        => '1234',
        prefix        => 'W',
        street        => 'MAIN',
        type          => 'St',
        sec_unit_type => 'APT',
        sec_unit_num  => '5',
    },
    '1234 NW 56th ST BLD A B' => { # Poor
        number        => '1234',
        prefix        => 'NW',
        street        => '56th',
        type          => 'St',
        sec_unit_type => 'BLD',
        sec_unit_num  => 'A',
    },
    '123-45 main ave # 678' => {
        number        => '123-45',
        street        => 'main',
        type          => 'Ave',
        sec_unit_type => '#',
        sec_unit_num  => '678',
    },
    '1234 Main Rd NW Apt 567 A' => {
        number        => '1234',
        street        => 'Main',
        type          => 'Rd',
        suffix        => 'NW',
        sec_unit_type => 'Apt',
        sec_unit_num  => '567 A',
    },
    '1234 State Route 56-A' => {
        number        => '1234',
        street        => 'State Route 56-A',
        type          => 'Rte',
    },
    '1234 N Main Island Dr Suit A' => { # Typo in suite
        number        => '1234',
        prefix        => 'N',
        street        => 'Main Island',
        type          => 'Dr',
        sec_unit_type => 'Suit',
        sec_unit_num  => 'A',
    },
    '1234 NW 56th street, Suit, ab7' => { # Poor
        number        => '1234',
        prefix        => 'NW',
        street        => '56th',
        type          => 'St',
        sec_unit_type => 'Suit',
        sec_unit_num  => 'ab7',
    },
    '123 Main St. Unit 4 AB12CD4567' => {
        number        => '123',
        street        => 'Main',
        type          => 'St',
        sec_unit_type => 'Unit',
        sec_unit_num  => '4',
    },
    '123 E VALLEY BLVD' => {
        number        => '123',
        street        => 'E', # Not ideal
        type          => 'Vly', # Not ideal
        sec_unit_num  => 'D', # Not ideal
    },
    '123 HIGHWAY 45S' => {
        number        => '123',
        street        => 'HIGHWAY 45',
        type          => 'Hwy',
        suffix        => 'S',
    },
    '1234 State Route 56 N' => {
        number        => '1234',
        street        => 'State Route 56',
        type          => 'Rte', # Ideally we could have suffix N
    },
    'apt-ab12345 6789Nw 10th St' => { # Poor
        street        => '6789', # Not ideal
        type          => '', # Not ideal
        suffix        => 'Nw', # Not ideal
        sec_unit_type => 'apt',
        sec_unit_num  => 'ab12345',
    },
    'P o box 1234' => {
        sec_unit_type => 'P o box',
        sec_unit_num  => '1234',
    },
    '1234 SR 56 City Fl 78901' => {
        number        => '1234',
        street        => 'SR',
        type          => '',
        sec_unit_num  => '56',
        city          => 'City',
        state         => 'Fl',
        zip           => '78901',
    },
    '1 Main Street Ft#23' => {
        number        => '1',
        street        => 'Main',
        type          => 'St',
        sec_unit_type => 'Ft',
        sec_unit_num  => '23',
    },
    '12 Main st Ft#345' => {
        number        => '12',
        street        => 'Main',
        type          => 'St',
        sec_unit_type => 'Ft',
        sec_unit_num  => '345',
    },
    "123 E Main St, Apt 456\n123 E Main St, Apt 456" => { # Poor
        number        => '123',
        prefix        => 'E',
        street        => 'Main',
        type          => 'St',
        sec_unit_type => 'Apt',
        sec_unit_num  => '456',
    },
    '12Main st' => {
        number        => '12',
        street        => 'Main',
        type          => 'St',
    },
    '1234 N Main Avenue, Apartment 567 N/A' => {
        number        => '1234',
        prefix        => 'N',
        street        => 'Main',
        type          => 'Ave',
        sec_unit_type => 'Apartment',
        sec_unit_num  => '567',
    },
    '1234 E 5th Street, Apt 6789 Apartment 6789' => {
        number        => '1234',
        prefix        => 'E',
        street        => '5th',
        type          => 'St',
        sec_unit_type => 'Apt',
        sec_unit_num  => '6789',
    },
    '123main st' => {
        number        => '123',
        street        => 'main',
        type          => 'St',
    },
    '1234 N Main Ave, Mailbox 0567' => {
        number        => '1234',
        prefix        => 'N',
        street        => 'Main',
        type          => 'Ave',
        sec_unit_type => 'Mailbox',
        sec_unit_num  => '0567',
    },
    '123 W 42nd St, New York, NY, United States' => {
        number        => '123',
        prefix        => 'W',
        street        => '42nd',
        type          => 'St',
        city          => 'New York',
        state         => 'NY',
    },
    '123 N Main St Boethius, TX 45678 United States' => {
        number        => '123',
        prefix        => 'N',
        street        => 'Main',
        type          => 'St',
        city          => 'Boethius',
        state         => 'TX',
        zip           => '45678',
    },
    '12 Main St Apt 3A Apt 4B' => {
        number        => '12',
        street        => 'Main',
        type          => 'St',
        sec_unit_type => 'Apt',
        sec_unit_num  => '3A',
    },
    'Flat 123, 32 Main St.' => {
        type          => 'St',
        sec_unit_num  => '123',
        street        => '32 Main',
        sec_unit_type => 'Flat'
    },
);


while (my ($addr, $expected) = each %address) {
    my $parse = Geo::StreetAddress::US->parse_location( $addr );
    is_deeply( $parse, $expected, "can parse $addr" )
        or warn "Got: ".Dumper($parse);
}


my @failures = (
    "1005 N Gravenstein Hwy Sebastopol",
    "1005 N Gravenstein Hwy Sebastopol CZ",
    "Gravenstein Hwy 95472",
    "E1005 Gravenstein Hwy 95472",
    "1005E Gravenstein Hwy 95472",
);

for my $fail (@failures) {
    my $parse = Geo::StreetAddress::US->parse_location( $fail );
    ok( !$parse || !defined($parse->{state}), "can't parse $fail" );
}

ok not Geo::StreetAddress::US->avoid_redundant_street_type;
Geo::StreetAddress::US->avoid_redundant_street_type(1);
ok Geo::StreetAddress::US->avoid_redundant_street_type;

is_deeply Geo::StreetAddress::US->parse_location("36401 County Road 43, Eaton, CO 80615"), {
    'city' => 'Eaton',
    'zip' => '80615',
    'number' => '36401',
    'street' => 'County Road 43',
    'type' => undef,  #
    'state' => 'CO'
}, 'type should be undef for Country Road 43 with avoid_redundant_street_type';

# XXX TODO: a suffix like "COUNTY HWY 60E" breaks this logic
# but not very badly, suffix='E', street='COUNTY HWY 60' and type='' (not undef)
is_deeply Geo::StreetAddress::US->parse_location("1234 COUNTY HWY 60, Town, CO 12345"), {
    'city' => 'Town',
    'zip' => '12345',
    'number' => '1234',
    'street' => 'COUNTY HWY 60',
    'type' => undef,
    'state' => 'CO'
}, 'type should be undef for COUNTY HWY 60 with avoid_redundant_street_type';

done_testing();

