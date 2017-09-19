#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use DateTime;
#===============================================================================
my $names;
foreach my $fname (qw/firstnames surnames/) {
	open(my $f_names,"<","$fname.txt");
	my @names = <$f_names>;
	$names->{$fname} = [ map { chomp $_; $_ } @names ];
	close($f_names);
}

my @surnames = @{$names->{surnames}};
my @names = @{$names->{firstnames}};

sub date_gen {
	my $scale = shift;

	my $now = DateTime->now;

	my $start_of_last_year = DateTime->new( year => $now->year);
	$now->subtract( days => int( rand($scale) ) );
	return '"'.$now->ymd('-').'"';
}

sub gen_name {
	my $names = shift;

	return (
		$names[int(rand(scalar @names))],
		$surnames[int(rand(scalar @surnames))]
	);
}

my $size = $ARGV[1];
my $start = $ARGV[0];
print join(",", qw/
	tab_inv_item.col_quantity
	tab_inv_item.col_total
	tab_inv.col_total
	tab_inv.col_name
	tab_inv.dt_invoice
	tab_pers.col_bn
	tab_pers.col_fn
	tab_pers.col_sn/),$/;
foreach ($start..$size) {
	print join(",", int(rand(30)), $_, int(rand(100)), "inv_".(int(rand(($size-$start)*2)+$start)), date_gen(90), $_, gen_name($names)), $/;
}

