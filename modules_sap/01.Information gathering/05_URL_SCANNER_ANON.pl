#!/usr/bin/perl
# Module URL Scanner

# CONFIG
######################
my $desc ="URL Scanner2: check URLs for accessibility (from urls_anon.txt)\n"; 
our $funcName="url_scanner_Func2";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub url_scanner_Func2()
{
	my $XML='';
	print "URLs:\n";
	open(FILE,"urls_anon.txt") or die "Couldn't open urls_anon.txt";
	while(<FILE>){
		chomp;
		print $_." - ";
		my $answers=send_soap($XML,1,$_);
		$answers=~/\s(.*)/i;
		print $1."\n\n";
		}
	
	close (FILE);
	print "\n\n";

}