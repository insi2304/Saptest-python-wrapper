#!/usr/bin/perl
# Module RFC_PING

# CONFIG
######################
my $desc ="RFC_PING: check alive of rfc service\n"; 
our $funcName="rfc_ping_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub rfc_ping_Func()
{

	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
		<SOAP-ENV:Body>
			<m:RFC_PING xmlns:m="urn:sap-com:document:sap:rfc:functions"/>
		</SOAP-ENV:Body>
	</SOAP-ENV:Envelope>';

	my @answers=send_soap($XML,1);

	my $answer=join('', @answers);
	
	if($answer =~/Response/s){
		print "RFC Service is alive.\n";
		$answer=~/server:\s(.*)/i;
		print "Server version: $1\n";
		$answer=~/HTTP\/1.1\s(.*)/i;
		print "Code: $1\n";
		
		}
	else {print "RFC Service is not alive.\n";}

	#print $answer;


	print "\n\n";

}