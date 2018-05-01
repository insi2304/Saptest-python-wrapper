#!/usr/bin/perl
# Module URL Scanner

# CONFIG
######################
my $desc ="URL Scanner: check URLs for accessibility (from urls_default.txt and urls_temp.txt)\n"; 
our $funcName="url_scanner_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub url_scanner_Func()
{
	my $XML='';
	print "URLs:\n";
	open(FILE,"urls_default.txt") or die "Couldn't open urls_default.txt";
	while(<FILE>){
		chomp;
		print $_." - ";
		my $answers=send_soap($XML,1,$_);
		$answers=~/\s(.*)/i;
		print $1."\n\n";
		}
	
	open(FILE,"urls_temp.txt") or die "Couldn't open urls_temp.txt";
	while(<FILE>){
		chomp;
		print $_." - ";
		my $answers=send_soap($XML,1,$_);
		$answers=~/\s(.*)/i;
		print $1."\n\n";
		}	
	#print $answer;
	
	close (FILE);
	print "\n\n";

}