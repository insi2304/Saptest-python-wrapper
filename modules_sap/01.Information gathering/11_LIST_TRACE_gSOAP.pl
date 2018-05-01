#!/usr/bin/perl
# Module ListDeveloperTraces

# CONFIG
######################
my $desc ="ListDeveloperTraces: List Trace files through gSOAP\n"; 
our $funcName="ListDeveloperTraces_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub ListDeveloperTraces_Func()
{

	my $XML='<?xml version="1.0" encoding="utf-8"?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema">
<SOAP-ENV:Header><sapsess:Session xlmns:sapsess="http://www.sap.com/webas/630/soap/features/session/"><enableSession>true</enableSession>
</sapsess:Session>
</SOAP-ENV:Header>
<SOAP-ENV:Body>
<ns1:ListDeveloperTraces xmlns:ns1="urn:SAPControl"></ns1:ListDeveloperTraces>
</SOAP-ENV:Body>
</SOAP-ENV:Envelope>
';

	my @answers=send_soap($XML,1,"/");

	my $answer=join('', @answers);

	print $answer;

	print "\n\n";

}