use strict;
use warnings;

use File::Spec;

my $destination = shift @ARGV;
my $maql_file = shift @ARGV;
my $manifest_file = shift @ARGV;
my $csv_file = shift @ARGV;

my $number = shift @ARGV;

my $maql_file_out = File::Spec->catfile($destination, 'maql.txt');
my $manifest_file_out = File::Spec->catfile($destination, 'upload_info.json');

open maql_file, "<$maql_file";
my $MAQL = '';

while( my $line = <maql_file> ) {
	$MAQL .= $line;
}
close maql_file;
open maql_out, ">$maql_file_out";

foreach (1..$number) {
	my $sub_maql = $MAQL;
	$sub_maql =~ s/\$(\w+)/$1$_/g;
	print maql_out $sub_maql;
}
close maql_out;

open manifest_file, "<$manifest_file";
my $manifest = '';

while( my $line = <manifest_file> ) {
	$manifest .= "    ".$line;
}
close manifest_file;

open manifest_out, ">$manifest_file_out";
print manifest_out '{
   "dataSetSLIManifestList" : [
';

my @manifest_by_parts;
foreach (1..$number) {
	my $sub_manifest = $manifest;
	$sub_manifest =~ s/\$(\w+)/$1$_/g;
	push @manifest_by_parts, $sub_manifest;
}
print manifest_out join(",", @manifest_by_parts);
print manifest_out ']}';
close manifest_out;

my @csv_fpaths;
foreach (1..$number) {
	my $csv_fpath = "a$_.csv";
	push @csv_fpaths, $csv_fpath;
	open my $csv_intfile, ">".File::Spec->catfile($destination, $csv_fpath);

	open csv_file, "<$csv_file";
	my $csv = '';

	my $head = <csv_file>;
	$head =~ s/\$(\w+)/$1$_/g;
	print $csv_intfile $head;

	while( my $line = <csv_file> ) {
		print $csv_intfile $line;
	};
	close $csv_file;
	close $csv_intfile;
}
close manifest_file;

my $cmd = "cd $destination; zip upload.zip upload_info.json @csv_fpaths";
system($cmd);
