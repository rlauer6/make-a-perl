#!/usr/bin/perl

use strict;

use warnings;
use Devel::PatchPerl;

my $version = shift;

Devel::PatchPerl->patch_source( $version, "/perl-$version" );

1;
