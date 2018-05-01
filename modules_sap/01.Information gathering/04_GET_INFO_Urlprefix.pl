#!/usr/bin/perl
# Module Urlprefix

# CONFIG
######################
my $desc ="Urlprefix: get URLs from Urlprefix (icr_urlprefix service) for URL Scanner (through urls_temp.txt)\n"; 
our $funcName="get_urls_urlprefix_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub get_urls_urlprefix_Func()
{
	
	my $XML='';
	
	my $answers=send_soap($XML,1,'/sap/public/icf_info/icr_urlprefix');
	
	#print $#answers."\n";
	
	open(FILE,"> urls_temp.txt") or print "Couldn't create urls_temp.txt";
	
	print "URLs founded:\n";
	
	#print $answers;
	 @ans=split('\n',$answers);
	 foreach $answer (@ans){
		 #print $answer.'-\n';
		 if($answer=~/PREFIX=(%2F.*%2F)/i){
			
			 print decodeURL($1)."\n";
			 print FILE decodeURL($1)."\n";
			 }
		 }
	
	#print $answer;
	
	close (FILE);
	print "\n\n";

}