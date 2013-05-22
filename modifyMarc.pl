#!C:/Perl/bin/perl -w
use strict;
use IO::File;
use utf8;
use Encode;
use Data::Dumper;
use File::Slurp;

##
# Slurp in identifier file
#
my $identifier_file = read_file(shift(@ARGV));

##
# Open file for output
#
my $outputfile = "hathiSubmission".$ARGV[0];

my $fh = IO::File->new($outputfile, 'w')
	or die "unable to open output file for writing: $!";
binmode($fh, ':utf8');

##
#change PERL default record delimiter
#
$/="\n\n";                                              

##
#create a hash of MARC records; sys no is key
#
my %records_hash;
while (<>) #here, ARGV is the MARC file
{ 		
	chomp;
	$_ = decode_utf8( $_ );
	$_ =~/=001  (\d*)\n/;   ##get sys no from MARC record
	my $sysno=$1;
	#print "$1\n";
	$records_hash{$sysno}=$_;
}

#print Dumper(\%records_hash);

##
# process identifiers add 955 field to records
#
my @identifier_file= split('\n', $identifier_file);			

foreach (@identifier_file)
{
	my @identifier=split('\t',$_);
	$fh->print("$records_hash{$identifier[0]}");

	if ($identifier[4])
	{
	$fh->print("\n=955  \\\\\$b$identifier[2]\$q$identifier[1]\$v$identifier[4]\n=856  \\\\\$u http://www.archive.org/details/$identifier[1]\n\n"); 
	}
	else
	{
	$fh->print("$_\n=955  \\\\\$b$identifier[2]\$q$identifier[1]\n=856  \\\\\$u http://www.archive.org/details/$identifier[1]\n\n")
	}

}
#Close output file
$fh->close();

=pod

use: modifyMarc.pl hathiData.txt records.mrk

hathiData.txt is a tab-delimited file downloaded from the Internet Archive containing the following in each row: ALMA sys no, book id, ark id, url, volume, title.

records.mrk



 
Outputs a file with 'url' prefixed to the name of the original .mrk file.

mckelvee@bc.edu May 21, 2013


=cut