#!/usr/bin/perl
# Module ReadLogFile

# CONFIG
######################
my $desc ="ReadLogFile: Get LOG files through gSOAP\n\t Usage: black.pl .. .. $argv[5] <filename> [count]  \n\t filename - path to a file like this: start.log\n"; 
our $funcName="ReadLogFile_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub ReadLogFile_Func()
{
	my $path, $count;
	my $XML='
<?xml version="1.0" encoding="UTF-8" ?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema"><SOAP-ENV:Header><sapsess:Session xmlns:sapsess="http://www.sap.com/webas/630/soap/features/session/"><enableSession>true</enableSession></sapsess:Session></SOAP-ENV:Header><SOAP-ENV:Body><ns1:ReadLogFile xmlns:ns1="urn:SAPControl"><filename>%PATH%</filename><filter></filter><language></language><maxentries>%COUNT%</maxentries><statecookie>EOF</statecookie></ns1:ReadLogFile></SOAP-ENV:Body></SOAP-ENV:Envelope>
';

	if ($ARGV[$m_arg_i+1]){
		$path=$ARGV[$m_arg_i+1];
		print $path." - path \n\n";
	} else {
		print "Error. Please, enter file name\n";
		exit;
	}

	if ($ARGV[$m_arg_i+2]){
		$count=$ARGV[$m_arg_i+2];
		$XML=~s/%COUNT%/$count/s;
	} else {
		$XML=~s/%COUNT%//s;
	}
	
	$XML=~s/%PATH%/$path/s;
	
	my @answers=send_soap($XML,1,"/");

	my $answer=join('', @answers);

	print $answer;

	print "\n\n";

}