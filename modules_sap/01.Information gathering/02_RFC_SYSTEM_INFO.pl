#!/usr/bin/perl
# Module RFC_SYSTEM_INFO

# CONFIG
######################
my $desc ="RFC_SYSTEM_INFO: get system information\n"; 
our $funcName="rfc_system_info_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub rfc_system_info_Func()
{

	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
	<SOAP-ENV:Body>
		<m:RFC_SYSTEM_INFO xmlns:m="urn:sap-com:document:sap:rfc:functions"/>
	</SOAP-ENV:Body>
</SOAP-ENV:Envelope>';

	my @answers=send_soap($XML,1);

	my $answer=join('', @answers);

	print $answer;

	print "\n\n";

}