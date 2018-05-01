#!/usr/bin/perl
# Module GetEnvironment

# CONFIG
######################
my $desc ="GetInstanceProperties: Get instance properties information through gSOAP\n"; 
our $funcName="GetInstanceProperties_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub GetInstanceProperties_Func()
{

	my $XML='<?xml version="1.0" encoding="UTF-8" ?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema"><SOAP-ENV:Body><ns1:GetInstanceProperties xmlns:ns1="urn:SAPControl"></ns1:GetInstanceProperties></SOAP-ENV:Body></SOAP-ENV:Envelope>
';

	my @answers=send_soap($XML,1,"/");

	my $answer=join('', @answers);

	print $answer;

	print "\n\n";

}