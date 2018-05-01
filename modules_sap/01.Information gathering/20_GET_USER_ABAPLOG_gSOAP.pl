#!/usr/bin/perl
# Module ABAPReadSyslog's users

# CONFIG
######################
my $desc ="ABAPReadSyslog's users: Get user list from ABAP syslog through gSOAP\n"; 
our $funcName="ABAPReadSyslog_users_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub ABAPReadSyslog_users_Func()
{

	my $XML='<?xml version="1.0" encoding="UTF-8" ?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema"><SOAP-ENV:Body><ns1:ABAPReadSyslog xmlns:ns1="urn:SAPControl"></ns1:ABAPReadSyslog></SOAP-ENV:Body></SOAP-ENV:Envelope>
';

	my @extracted_users;
	my @answers=send_soap($XML,1,"/");
	my $get_sess, $same;
	my $answer=join('', @answers);
	@items=split("<User>",$answer);
	
	
	
	foreach $item(@items){
		#print $item;
		if($item=~/^(.+)<\/User>/){
				#print "$1\n";
				$same=0;
				foreach(@extracted_users){
					if ($1 =~ $_ or $1=~/ +/){$same=1; last;}
					}
				if ($same == 0) {push(@extracted_users,$1);}
				
				$get_sess++;
			}
	}
	print "Exatracted users:\n";
	foreach(@extracted_users){
		print $_."\n";
		}
		
	if(!$get_sess){print $answer;}

	print "\n\n";

}