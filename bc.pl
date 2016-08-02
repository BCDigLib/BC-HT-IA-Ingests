#!C:/Perl/bin/perl -w
use strict;

use IO::File;
use utf8;


my %hathi;
my $outputfile = "bc".$ARGV[0];
my $hathi_files = shift(@ARGV);


my $fh = IO::File->new($outputfile, 'w')
	or die "unable to open output file for writing: $!";
binmode($fh, ':utf8');

hathi();

$fh->close();


####################
sub hathi
{
	open (HATHI_FILE, $hathi_files);
	
	$fh->print("vol_id\taccess\trights\tHTrecNo\tenum_chron\tsource\talma\toclc\tisbn\tissn\tlccn\ttitle\timprint\trights_det_reason\tlast_update\tgov_doc\tpub_date\tpub_place\tlang\tfmt\n");	

	while (<HATHI_FILE>) 
	{ 
		my $out_line=$_;
		my @hathi_row = split('\t');

		if ($hathi_row[0] =~ m/^bc/i)
		{
			$fh->print($out_line);
			
			
		}

	}


close (HATHI_FILE);
}
=pod

use: bc.pl hathi_full_20130201.txt

The full HathiTrust text files are too large to open with a desktop application.  This script takes a Hathi text file writes the rows that represent Boston College volumes to a new text file.  

Rows representing Boston College volumes are identified by the presence of the Boston College NUC code (MChB)

betsy.post@bc.edu August 1, 2016

=cut