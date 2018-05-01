#!/usr/bin/perl
# Module T3 checker

# CONFIG
######################
my $desc ="T3 protocol checker/admin port finder: Check a port for T3 protocol supporting (doesn't support ssl)\n"; 
our $funcName="t3_check_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub t3_check_Func()
{
	my @data=("74:33:20:31:31:2e:33:2e::36:0a:41:53:3a:32:35:35:0a:48:4c:3a:31:31:0a:0a");
	

	@answers=send_bin(1,1,@data);
	my $answer=join('', @answers);
	
	print $answer;
	if ($answer=~/HELO/ ){print "\nT3 found\n";}
	print "\n\n";
}