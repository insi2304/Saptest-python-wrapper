#!/usr/bin/perl
# Module URL Scanner

# CONFIG
######################
my $desc ="URL Scanner: check URLs for accessibility (from file = ps_urls_default.txt)"; 
our $funcName="ps_url_scan_Funcs";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub ps_url_scan_Funcs()
{
	my $answers, $header;
	print "URLs:\n";
	open(FILE,"ps_urls_default.txt") or die "Couldn't open ps_urls_default.txt";
	while(<FILE>){
		chomp;
		
		my $answers=send_soap($XML,1,$_,"GET");
		$answers=~/\s(.*)/i;
		$header= $1;
		#substr($header, 0, 1, "");
		print $_." - ".$header."\n";
		}
	close (FILE);
	print "\n\n";

}