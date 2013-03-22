#!C:/Perl/bin/perl -w
use strict;
use IO::File;
use utf8;
use Encode;

use File::Slurp;

##slurp in identifier file
my $identifier_file = read_file(shift(@ARGV));
my @identifier_file= split('\n', $identifier_file);

#change PERL default record delimiter
$/="\n\n";                                              

#Open file for output
my $outputfile = "hathiSubmission".$ARGV[0];



my $fh = IO::File->new($outputfile, 'w')
	or die "unable to open output file for writing: $!";
binmode($fh, ':utf8');






while (<>) #here, ARGV is the MARC file
{ 		
	chomp;
	$_ = decode_utf8( $_ );
	$_ =~/BCL01\d{12}(\d{9})\n/;   ##get sys no from MARC record
	my $sysno=$1;

	$_ =~s/=035  9.*\n//g;
	$_ =~s/=035  \\\\\$a\(GRSN.*\n//g;

	my $identifier_line=shift(@identifier_file);
	my @identifier=split('\t',$identifier_line);
	#print "$identifier[0]\n";
	
	
#	print "system number from Marc record is $sysno\n";

	#if ($_ !~ m/=901/)
	#{

		if ($identifier[4])

		{
		$fh->print("$_\n=955  \\\\\$b$identifier[2]\$q$identifier[1]\$v$identifier[4]\n=856  \\\\\$u http://www.archive.org/details/$identifier[1]\n\n"); 
		}

		else{$fh->print("$_\n=955  \\\\\$b$identifier[2]\$q$identifier[1]\n=856  \\\\\$u http://www.archive.org/details/$identifier[1]\n\n")
		}
	#}

}				

#Close output file
$fh->close();
=pod

use: ia.pl picklist.xls records.mrk

Takes an Internet Archive EXCEL pick list and adds urls to aleph records in .mrk format. 
The following line of the script must be adjusted if picklist column names vary: my ($shipment , $physical_item, $identifier, $sysno, $barcode, $vol, $year, $title, $author, $callno, $notes) = @$row;
Handling rejected items on picklists is out of scope of the script.
 
Outputs a file with 'url' prefixed to the name of the original .mrk file.

mckelvee@bc.edu October 1, 2009

Updates + Notes 20091227 
1.) revised to work with Wonderfetch format; deals with empty rows in wonderfetch
2.) now looks for first worksheet in excel workbook, rather than a sheet named "Sheet1"
3.)detects current working directory and expects to find excel sheet there
4.) change call number suffix to eb
5.) The script should be handling unicode diacritics, but it isn't so we are outputting MARC 8 and running the script on that.  The problem may be that our opac using combining rather than combined unicode diacritics.  

Updated December 31, 2011 -- deals with duplicate records. 

Didn't
2.) 300 |a 1 online resource with page numbers in parens -- http://www.loc.gov/catdir/pcc/sca/FinalVendorGuide.pdf


=cut