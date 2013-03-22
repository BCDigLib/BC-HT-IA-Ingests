#!C:/Perl/bin/perl -w
use strict;

use IO::File;
use utf8;

my $outputfile = "report".$ARGV[0];

print $outputfile;

my $fh = IO::File->new($outputfile, 'w')
	or die "unable to open output file for writing: $!";
binmode($fh, ':utf8');


#Call Main
main();

#Close output file
$fh->close();

#########
sub main 
#########
{	
	while (<>) 	
	{ #here, ARGV is the Hathi Text File file

		if ($_ =~ m/MChB/ )
			{
				$fh->print("$_");	
			}
	}	
};
=pod

use: ht-text-file-extract.pl hathi_full_20130201.txt

The full HathiTrust text files are too large to open with a desktop application.  This script takes a Hathi text file writes the rows that represent Boston College volumes to a new text file.  

Rows representing Boston College volumes are identified by the presence of the Boston College NUC code (MChB)

mckelvee@bc.edu February 22, 2013

=cut