#!/usr/bin/perl
# Module RFC_PING

# CONFIG
######################
my $desc ="AuditPWD password checker (file - ps_auditpwd.txt) "; 
our $funcName="auditpwd_pass_checker_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################



sub auditpwd_pass_checker_Func()
{
	my $XML='1';	
	

	open(FILE,"ps_auditpwd.txt") or die "Couldn't open ps_auditpwd.txt";
	while(<FILE>){
		chomp;
		push(@passwds, $_); 
		}
	close (FILE);



	foreach $passwd(@passwds){
		
			my @answers=send_soap($XML,0,"/psp/$ps_site_name/?cmd=viewconfig&pwd=$passwd",);
			my $answer=join('', @answers);
			
			if($answer =~/authorized/s){

					print "$passwd - wrong!  \n ";
					}

			elsif($answer =~/properties/s){
					print "$passwd - OK! \n";				
					}


				else {	print @answers;}
				
				}
			}
		
