#!/usr/bin/perl
# Module GetVersionInfo

# CONFIG
######################
my $desc ="GetVersionInfo: Get version information through gSOAP\n"; 
our $funcName="GetVersionInfo_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub GetVersionInfo_Func()
{

	my $XML='<?xml version="1.0" encoding="UTF-8" ?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema"><SOAP-ENV:Header><sapsess:Session xmlns:sapsess="http://www.sap.com/webas/630/soap/features/session/"><enableSession>true</enableSession></sapsess:Session></SOAP-ENV:Header><SOAP-ENV:Body><ns1:GetVersionInfo xmlns:ns1="urn:SAPControl"></ns1:GetVersionInfo></SOAP-ENV:Body></SOAP-ENV:Envelope>
';

	my @answers=send_soap($XML,1,"/");

	my $answer=join('', @answers);

	print $answer;

	print "\n\n";

}