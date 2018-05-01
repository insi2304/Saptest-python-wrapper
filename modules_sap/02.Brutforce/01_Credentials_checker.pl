#!/usr/bin/perl
# Module RFC_PING

# CONFIG
######################
my $desc ="Default credentials checker via RFC_PING (file - auths.txt)\n"; 
our $funcName="def_cred_rfc_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub def_cred_rfc_Func()
{

	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
		<SOAP-ENV:Body>
			<m:RFC_PING xmlns:m="urn:sap-com:document:sap:rfc:functions"/>
		</SOAP-ENV:Body>
	</SOAP-ENV:Envelope>';
	

	
	open(FILE,"auths.txt") or die "Couldn't open auths.txt";
	while(<FILE>){
		chomp;
		push(@auths, $_); 
		}
	close (FILE);
	
	foreach $auth_str(@auths){
		#print $auth_str;
		($cur_login,$cur_password,$cur_client_str)=split(':',$auth_str);
		@cur_clients=split(',',$cur_client_str);
		foreach $cur_client(@cur_clients){
			
			if ($cur_client=~'xxx'){$cur_client=$arg_sap_client;}
			

			my @answers=send_soap($XML,1,0,0,0,0,$cur_login, $cur_password,$cur_client,2);
			my $answer=join('', @answers);
			
			print "Checking cred - ";
			my $temp=join(":",$cur_login, $cur_password,$cur_client);
			chomp ($temp);
			print $temp;
			
			if($answer =~/Response/s){
				$answer=~/HTTP\/1.1\s(.*)/i;
				$code_ans=$1;
				
				if ($code_ans=~200){
					print " - Good. ($code_ans) \n\n ";
					}
				else {print " - Wrong! ($code_ans) \n\n ";}
				
				}
			else {print "RFC Service is not alive. You can't check credentials via RFC\n";}
			}
		}
	


	#print $answer;


	print "\n\n";

}