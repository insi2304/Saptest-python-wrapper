#!/usr/bin/perl
# Module JSESSIONfrmLOg

# CONFIG
######################
my $desc ="JSESSIONfrmLOG: Get JSESSIONS from LOG files through gSOAP\n\t Usage: black.pl .. .. $argv[5] [count]  \n\t count - count of enteries for parsing, default is -100\n"; 
our $funcName="JSESSIONfrmLOG_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub JSESSIONfrmLOG_Func()
{
	my $path, $count;
	
	my $XML='<?xml version="1.0" encoding="UTF-8" ?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema"><SOAP-ENV:Header><sapsess:Session xmlns:sapsess="http://www.sap.com/webas/630/soap/features/session/"><enableSession>true</enableSession></sapsess:Session></SOAP-ENV:Header><SOAP-ENV:Body><ns1:ReadLogFile xmlns:ns1="urn:SAPControl"><filename>j2ee/cluster/server0/log/system/userinterface.log</filename><filter></filter><language></language><maxentries>%COUNT%</maxentries><statecookie>EOF</statecookie></ns1:ReadLogFile></SOAP-ENV:Body></SOAP-ENV:Envelope>
';

	if ($ARGV[$m_arg_i+1]){
		$count=$ARGV[$m_arg_i+1];
		$XML=~s/%COUNT%/$count/s;
	} else {
		$XML=~s/%COUNT%//s;
	}
	my @answers=send_soap($XML,1,"/");
	my $get_sess;
	my $answer=join('', @answers);
	@items=split("<item>",$answer);
	foreach $item(@items){
		#print $item;
		if($item=~/Computed locale for session ClientSession\((.*End)/g){
			print "$1\n";
			$get_sess++;
			}
	}
	if(!$get_sess){print $answer;}

	print "\n\n";

}