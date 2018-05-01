#!/usr/bin/perl

use LWP::UserAgent;
use HTTP::Request;
use MIME::Base64;
use IO::Socket;
use Time::HiRes qw/ time sleep /; #timebased modules (like UDDI)

#
#
#
# ERPSCAN Pentesting tool v 1.0
#
# 
# Idea: Alexandr Polyakov
# Architecture by Alexey Sintsov and Alexey Tyurin 
# Coded by Alexey Tyurin and Alexey Sintsov 
# Module contributors: Alexey Tyurin,  Alexey Sintsov, Dmitry Chastukhin, Dmitry Evdokimov, Alexandr Polyakov
# E-mail: info@erpscan.com
#
# 
#
#        www.erpscan.com
#
#


 

# Check parametrs

$ARGC=@ARGV;
print "\n\nERPSCAN Pentesting tool v1.0\n\nby ERPScan (c) 2013\n\n";

sub decodeURL {
   my $bytes = shift;
   $bytes =~ s/%([0-9a-fA-F]{2})/ pack ("C", hex($1)) /ge; # octets 'C'
   return $bytes;
}

sub usage()
{
	
	print "Usage: black.pl -sap -H target_host -P port -ssl 0/1 -u user -p password -c sap_client -m id_module\n
	-l - list of availible modules
	-h - show this help
	-sap or -ps - choose SAP or PeopleSoft modules use (the first arg only)
	
	Target:
	-H - IP or hostname
	-P - port
	-ssl - use SSL (https -1 , http - 0) 
	
	Authentication:
	-u - user 
	-p - password
		OR
	--cookie - by SSO cookie (MYSAPSSO2) (SAP only)
	
	-c - client/mandat (SAP only)
	
	-s - a name of portal site (PeopleSoft only)
	
	-d - show debug information
	
	-m id_module - module number from the list with the specific arguments
	
	Example:\n\tblack.pl -sap -H 192.168.0.1 -P 8000 -ssl 0 -u SAP* -p PASS -c 000 -m 1\n
	black.pl -ps -H 192.168.0.2 -P 443 -ssl 1 -s HRDEMO -m 2\n\n
	";
	
}
	
# Set globals vars
@modules;
@descriptions;
@functions;

#sap or peoplesoft
$modules_dir;

$i=0;
if($ARGC<1){usage(); exit();}

if(@ARGV[0]=~'-sap'){
	$modules_dir='./modules_sap';
	}
elsif (@ARGV[0]=~'-ps')
	{$modules_dir='./modules_ps';}	
else {usage(); exit();}


# Get modules
my $count=0;


opendir(MODULES,$modules_dir);
while ($tmp_name=readdir(MODULES)){
	if(($tmp_name eq "." )|| ($tmp_name eq "..")) { next; }
	
	opendir(DIR,"$modules_dir/$tmp_name");
	while ($name = readdir(DIR)){
		if(($name eq "." )|| ($name eq "..")) { next; };
		#print "./modules/$tmp_name/".$name."\n";
		push(@modules, "$modules_dir/$tmp_name/".$name);
		do "$modules_dir/$tmp_name/".$name;
		$count++;
		}
	closedir(DIR);	
	}
closedir(MODULES);


foreach $arg(@ARGV){
	#print $arg."\n";
	if($arg=~'-H'){
		$host=$ARGV[$i+1];
		#print $host." h";
		}
	elsif($arg=~'-P'){
		$port=$ARGV[$i+1];
		#print $port." h";
		}
	elsif($arg=~'-ssl'){
		$https=$ARGV[$i+1];
		#print $https." h";
		}
	elsif($arg=~'-u'){
		$login=$ARGV[$i+1];
		#print $login." l";
		}
	elsif($arg=~'-p'){
		$password=$ARGV[$i+1];
		#print $password." p";
		}
	elsif($arg=~'-d'){
		$debug='1';
		#print $debug." d";
		}		
	elsif($arg=~'-c'){
		$arg_sap_client=$ARGV[$i+1];
		#print $sap_client." c";
		}
	elsif($arg=~'-s'){
		$ps_site_name=$ARGV[$i+1];
		#print $ps_site_name." c";
		}
	elsif($arg=~'--cookie'){
		$sso_cookie=$ARGV[$i+1];
		#print $sso_cookie." c";
		}	
	elsif($arg=~'-h'){
		usage();
		exit();
		}	
	elsif($arg=~'-l'){
		for (my $a=0; $a<$count; $a++){
			$nm=$a+1;
			print "$nm: @descriptions[$a]\n";
			}
		exit();
		}	
	elsif($arg=~'-m'){
		$id_m=$ARGV[$i+1];
		$m_arg_i=$i+1;
		#print $m_arg_i." - nomer id";
		}	
		
	$i++;
	} 	

	
# HANDLER
###

 if ($id_m&& $id_m<=$count){
	print "\nTarget: $host:$port";
	if($https==1){print " with https";}
	print "\n\n";
	&{@functions[$id_m-1]};
}
else{print "Bad module id - $id_m \n\n";}

###
# &{@functions[($nm-1)]};	


# SEND function 
###
sub send_soap{
	 
	 my @data;
	 my $proto="POST";
	 my $url="/sap/bc/soap/rfc";
	 my $usaera="ERPSCAN Pentesting tool";
	 my $ret_type="";
	 my $err_show="1";
	 my $contype="text/xml; charset=utf-8";
	 
	 my ($xml,$sync,$url2,$proto2,$ret_type2, $contype2, $clogin, $cpassword, $csap_client, $err_show2)=@_;
	
	 
	if($url2){$url=$url2;}
	 
	if($proto2){$proto=$proto2;}
	 
	if($contype2){$contype=$contype2;}
	#type of func return value:
	#3 - full http-response
	#2 - only body
	#1 - only header
	if($ret_type2){$ret_type=$ret_type2;} 
	else {$ret_type=3;}
	
	
	
	#set the client from ARGs
	$sap_client=$arg_sap_client;
	
	if($clogin){$login=$clogin;} 
	if($cpassword){$password=$cpassword;} 
	if($csap_client){$sap_client=$csap_client;} 
	if($err_show2==2){$err_show=$err_show2;} 
	
	my $auth=encode_base64("$login:$password"); 
	
	#Send data to host:port
	###
 	$browser = new LWP::UserAgent;
	$browser->timeout(20);	
	
	$full_url="$host:$port$url";
	if($https==1){$full_url="https://$full_url";}
	else {$full_url="http://$full_url";}
	
	#if($sap_client){$full_url.="?sap-client=$sap_client";}
	#$full_url=join('','http://', $host,":",$port,$url);

	
	print "\n";
	my $header = new HTTP::Headers (
        'Content-Type'   => $contype, 
        'User-Agent'     => $usaera,
		'Cache-Control'  => 'no-cache',
		'Cookie'		 => "sap-client=".$sap_client.';'.$sso_cookies
		);

	if ($password and @ARGV[0]=~'-sap'){
		 $browser->default_header('Authorization'	 => 'Basic '.$auth);
		}

	
	my $req = new HTTP::Request($proto,$full_url,$header,$xml);
	if($debug){	print "SEND:\n".$req->as_string."\n----------\n\n";}
	
	my $res = $browser->request($req);
#	if($debug){	print "GET:\n".$res->as_string."\n----------\n\n";}
	
	#Show auth errors (default - 1)
	if($err_show!=2){
		if($res->decoded_content=~/HTTP\s401\s/s){print "Authorization error.\n"; }
		}
	
	if($ret_type==1){
		return $res->headers_as_string
		}
	elsif ($ret_type==2){
		return $res->decoded_content;
		}
	else{
		return $res->as_string;
		}
		
}

sub send_bin{
	 
	my ($sync,$convert,@bin_data)=@_;
	my $serv_reply, @serv_replys;
	
	#Use packer or not
	if($convert==0){$convert=0;} 
	else {$convert=1;}
	
	#$hexcommand[0]="1f:00:00:00:04:03:02:01:01:00:00:00:bc:02:00:00:00:00:00:00:03:04:48:00:43:00:04:50:00:53:00";
	
	
	$| = 1;

	my ($socket,$client_socket);
	$socket = new IO::Socket::INET (
	PeerHost => $host,
	PeerPort => $port,
	Proto => 'tcp',
	) or die "ERROR in Socket Creation : $!\n";
	undef @serv_replys;
	
	 
	foreach $command(@bin_data) {		
		if ($convert==1) {
			$command =~ s/://g;
			$buffer= pack( 'H*', $command );}
		else{$buffer=$command;}
		
		if($debug){	print "SEND:\n".$buffer."\n----------\n\n";}
		
		print $socket $buffer;
		$serv_reply = <$socket>;
		#$socket->recv($serv_reply,1024);
		push(@serv_replys,$serv_reply);
		if($debug){	print "RECEIVE:\n".$serv_reply."\n----------\n\n";}
		}
		
	$socket->close();
	return @serv_replys;
		
}
