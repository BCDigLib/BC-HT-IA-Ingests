#!C:/Perl/bin/perl -w
use strict;

use IO::File;
use utf8;
require LWP::UserAgent;
use LWP::Simple;


#Open file for output

my $meta_file = IO::File->new('ia-metadata.xml', 'w')
	or die "unable to open output file for writing: $!";
binmode($meta_file, ':utf8');

while (<>)
	{
		chomp;
		print $_;
		my $id=$_;
		my $loc;


		my $ua = LWP::UserAgent->new;
		$ua->timeout(10);
		$ua->env_proxy;

		my $request  = HTTP::Request->new( GET => 'http://www.archive.org/download/'.$id.'/' );
		my $response = $ua->request($request);
		if ( $response->is_success and $response->previous ) {
  			  print $request->url, ' redirected to ', $response->request->uri, "\n";			
		}
		my $meta=get($response->request->uri.$id.'_meta.xml');

		print "$meta\n";
		$meta_file -> print($meta);

	}                                    

$meta_file->close();
=pod

use: get-ia-metadata.pl identifiers.txt

Takes a text file of Internet Archive book ids and writes the xml metadata to a file.

=cut