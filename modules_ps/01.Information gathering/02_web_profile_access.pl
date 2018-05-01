#!/usr/bin/perl
# Module RFC_PING

# CONFIG
######################
my $desc ="Check Web Profile Configuration accessability"; 
our $funcName="web_profile_access_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub web_profile_access_Func()
{
	my $XML='1';	

	my @answers=send_soap($XML,0,"/psp/$ps_site_name/?cmd=debugCache",);

	my $answer=join('', @answers);
	
	if($answer =~/feature/s){
		print "Web Profile is switched off\n";				
		}

	elsif($answer =~/auditPWD/s){
		print "Web Profile is ON!\n";				
		}


	else {print @answers;}

	print "\n\n";

}


	
	
