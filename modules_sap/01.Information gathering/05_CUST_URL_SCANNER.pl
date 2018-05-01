#!/usr/bin/perl
# Module URL Scanner

# CONFIG
######################
my $desc ="URL Scanner3: check URLs for accessibility from your file\n\t Usage: black.pl .. .. $argv[5] <filename>  \n\t filename - path to a file like this: urls.txt\n"; 
our $funcName="url_scanner_Func3";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub url_scanner_Func3()
{
	my $XML='';
	if ($ARGV[$m_arg_i+1]){
		$path=$ARGV[$m_arg_i+1];
		print $path." - file \n\n";
	} else {
		print "Error. Please, enter file name\n";
		exit;
	}
	print "URLs:\n";
	open(FILE,"$path") or die "Couldn't open $path";
	while(<FILE>){
		chomp;
		print $_." - ";
		my $answers=send_soap($XML,1,$_);
		$answers=~/\s(.*)/i;
		$ans=$1;
		chomp($ans);
		print $ans."\n\n";
		}
	
	close (FILE);
	print "\n\n";

}