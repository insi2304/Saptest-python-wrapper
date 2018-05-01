#!/usr/bin/perl


# CONFIG
######################
my $desc ="Default credentials checker for Weblogic Administration Console(file = weblogic_loginpwd.txt) "; 
our $funcName="brut_admcon";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################



sub brut_admcon()
{
	my $XML, $login, $passwd,@auths;	
	open(FILE,"weblogic_loginpwd.txt") or die "Couldn't open weblogic_loginpwd.txt";
	while(<FILE>){
		chomp;
		push(@auths, $_); 
		}
	close (FILE);

	foreach $auth(@auths){
			($login,$passwd) = split(":",$auth);
			$XML = "j_username=$login&j_password=$passwd&j_character_encoding=UTF-8";
			my @answers=send_soap($XML,0,"/console/j_security_check","POST",1, "application/x-www-form-urlencoded");
			my $answer=join('', @answers);
			#print $answer;
			if($answer=~/Location.*\/console\s/){print "$login:$passwd - OK!\n";}
			else{print "$login:$passwd - wrong!\n";}			
		}
}