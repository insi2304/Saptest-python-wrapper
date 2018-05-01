#!/usr/bin/perl
# Module BUILD_INFO_JSP

# CONFIG
######################
my $desc ="BUILD_INFO_JSP: get system information from /rep/build_info.jsp\n"; 
our $funcName="build_info_jsp_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub build_info_jsp_Func()
{

	my $XML='';
	my @answers=send_soap($XML,1,"/rep/build_info.jsp", "GET",2);
	my $answer=join('', @answers);
	 
	#cut html
	my @info_strs=split('<td class="borderCopy1" width=120>',$answer);
	shift @info_strs;
	pop @info_strs;
	foreach $str(@info_strs){
		$str=~s|<\/td>||g;
		$str=~s|<tr>||;
		$str=~s|</tr>||;
		$str=~s|<td class="borderCopy1">||;
		$str=~s|\s+| |g;
		print "$str\n";
		}

	# if($answer=~/.*width\=120\()\<\/td\>/i){
		# print;	

	# }
	
	print "\n\n";

}