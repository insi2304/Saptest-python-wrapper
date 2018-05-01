#!/usr/bin/perl
# Module HTTP Version 

# CONFIG
######################
my $desc ="Version via HTTP: get version information from http, jsp pages\n\n"; 
our $funcName="version_via_http_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub version_via_http_Func()
{
	my $XML='';
	
	@URLs = (
		'/rep/build_info.jsp',
		'/rep/build_info.html',
		'/run/build_info.jsp',
		'/run/build_info.html',
		'/rwb/version.html'
	); 
	
	foreach $url (@URLs){
		print $url;
	    my $answers=send_soap($XML,1,"$url");
		
		#print $answers;
		@ans=split('\n',$answers);
		if(@ans[0]!~/HTTP\/1.1 200 OK/i){
			print " - @ans[0]\n";
			next;
			}
		elsif($url=~"/rwb/version.html") {
				print "\n".$answers;	
				 
			}
		else{
			print "\n";
			foreach $answer (@ans){
				if($answer=~/<td\sclass=\"borderCopy1\".*>(.*)<\/td>/i){
					print $1."\n";
					}
				 }
				last;
			}
		print "\n";
		

		} 

	print "\n\n";

}