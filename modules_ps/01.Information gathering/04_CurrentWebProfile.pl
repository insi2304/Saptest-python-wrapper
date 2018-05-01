#!/usr/bin/perl
# Module RFC_PING

# CONFIG
######################
my $desc ="View the current web profile (cmd=viewconfig)\n\t Usage: black.pl .. .. -m id_module <pwd> \n\t pwd - auditPWD, default is dayoff\n"; 
our $funcName="ps_curr_web_prf";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################



sub ps_curr_web_prf()
{
	my $XML='';	
	my $passwd;

		if ($ARGV[$m_arg_i+1]){
		$passwd=$ARGV[$m_arg_i+1];
		print $passwd." - password \n\n";
	} else {
		$passwd='dayoff';
	}
	

	my @answers=send_soap($XML,0,"/psp/$ps_site_name/?cmd=viewconfig&pwd=$passwd",'GET',2);

	my $answer=join('', @answers);
	
	print @answers;

	print "\n\n";

}


	
	
