#!/usr/bin/perl

use strict;
use warnings;
use FindBin qw/$Bin/;
use lib "$Bin/lib";
use Test::More;
use WWW::Contact;
use Data::Dumper;

BEGIN {
    unless ( $ENV{TEST_163} and $ENV{TEST_163_PASS} ) {
        plan skip_all => 'set $ENV{TEST_163} and $ENV{TEST_163_PASS} to test';
    }
    plan tests => 4;
}

my $wc = WWW::Contact->new();

my @contacts = $wc->get_contacts('fayland@163.com', 'pass');
my $errstr = $wc->errstr;
is($errstr, 'Wrong Username or Password', 'get error with wrong password');
is(scalar @contacts, 0, 'empty contact list');

{
    @contacts = $wc->get_contacts($ENV{TEST_163}, $ENV{TEST_163_PASS});
    $errstr = $wc->errstr;
    is($errstr, undef, 'no error with password');
    cmp_ok(scalar @contacts, '>', 0, 'get contact list');
    diag(Dumper(\@contacts));
}

1;