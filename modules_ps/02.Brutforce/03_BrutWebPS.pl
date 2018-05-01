#!/usr/bin/perl

# CONFIG
######################
my $desc ="Default credentials checker for PeopleSoft portal (file = ps_loginpwdWebPS.txt) "; 
our $funcName="def_cred_ps_portal_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################



sub def_cred_ps_portal_Func()
{
	my $XML;	
	open(FILE,"ps_loginpwdWebPS.txt") or die "Couldn't open ps_loginpwdWebPS.txt";
	while(<FILE>){
		chomp;
		push(@auths, $_); 
		}
	close (FILE);

	foreach $auth(@auths){
			($login,$passwd) = split(":",$auth);
			$XML = "timezoneOffset=-240&userid=$login&pwd=$passwd";
			my @answers=send_soap($XML,0,"/psp/$ps_site_name/?cmd=login&languageCd=ENG","POST",1, "application/x-www-form-urlencoded");
			my $answer=join('', @answers);
			
			if($answer=~/Location.*\/EMPLOYEE/){print "$login:$passwd - OK!\n";}
			else{print "$login:$passwd - wrong !\n";}
		}
}