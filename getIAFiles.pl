#!/usr/bin/perl -w
use strict;
use FileHandle;
use LWP::Simple;
use Switch;

main();

#-----------------------------------------------------------------------------
sub main
{
    
    showUsage()
	if scalar(@ARGV) != 2;
        
    my ($ids, $type) = @ARGV;
    
    my $inputFH = new FileHandle;    
    $inputFH->open($ids);
    
    while(not($inputFH->eof)) {
        my $id = $inputFH->getline;
        chomp $id;
	
	my $ext;
	switch ($type) {
		case 'abbyy' { $ext = '_abbyy.gz' }
		case 'pdf' { $ext = '.pdf' }
		case 'orig' { $ext = '_orig_jp2.tar' }
		case 'jp2' { $ext = '_jp2.zip' }
	}
	
	my $url = 'https://archive.org/download/' . $id . '/' . $id . $ext;
        my $file = $id . $ext;
	
	my $status = getstore($url, $file);
	
	if (is_error($status)) {
		print "ERROR $status while fetching $url\n";
	}
    }
}



#-----------------------------------------------------------------------------
sub showUsage
{
    print "\nUsage:\n\n";
    print "getIAFiles.pl ids filetype\n\n";
    print "Where\nids is file containing IA ids\n\nfiletype can be
    ABBYY Full text -> abbyy
    Single PDF -> pdf
    Single Page Original JP2 -> orig
    Single Page Cropped JP2 -> jp2\n";
    
    exit 1;
}
