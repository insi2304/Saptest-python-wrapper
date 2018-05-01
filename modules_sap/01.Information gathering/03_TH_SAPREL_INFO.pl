#!/usr/bin/perl
# Module RFC_TH_SAPREL

# CONFIG
######################
my $desc ="TH_SAPREL: OS, RDBMS, SAP kernel (with the patch level) versions\n"; 
our $funcName="rfc_th_saprel_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub rfc_th_saprel_Func()
{

	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
 <SOAP-ENV:Body>
  <m:TH_SAPREL xmlns:m="urn:sap-com:document:sap:rfc:functions">
  </m:TH_SAPREL>
 </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
';

	my @answers=send_soap($XML,1);

	my $answer=join('', @answers);

	print $answer;

	print "\n\n";

}