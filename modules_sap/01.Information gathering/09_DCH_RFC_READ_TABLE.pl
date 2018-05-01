#!/usr/bin/perl
# Module Tabel Read (RFC_READ_TABLE)

# CONFIG
######################
my $desc ="Read columns from table (RFC_READ_TABLE) \n\t Usage: black.pl .. .. -m id_module <table> <column1> [column2] ... [columnN]\n\t <table> - table name\n\t <column1> [column2] ... [columnN] - columns to read (<column1> - min) \n"; 
our $funcName="rfc_read_table_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub rfc_read_table_Func()
{

	my $XML='<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
	<SOAP-ENV:Body>
		<m:RFC_READ_TABLE xmlns:m="urn:sap-com:document:sap:rfc:functions">
			<DATA>
				<item>
					<WA></WA>
				</item>
			</DATA>
			<DELIMITER> </DELIMITER>
			<FIELDS>
				%FIELDS% 
			</FIELDS>
			<NO_DATA> </NO_DATA>
			<QUERY_TABLE>%TABLE_NAME%</QUERY_TABLE>
		</m:RFC_READ_TABLE>
	</SOAP-ENV:Body>
	</SOAP-ENV:Envelope>
	';
	
	my @cols;
	
	if ($ARGV[$m_arg_i+1]){
		$table=$ARGV[$m_arg_i+1];
		print $table." - table \n\n";
	} else {
		print "Error. Please, enter table name\n";
		exit;
	}
	
	if (!$ARGV[$m_arg_i+2]){
		print "Error. Please, enter column name\n";
		exit;
	}
	
	for (my $i=$m_arg_i+2;$i<=$#ARGV;$i++){
		print $ARGV[$i]." - col \n\n";
		push(@cols, $ARGV[$i]);	
		}
		
	my $fields;	
	
	for (my $i=0;$i<=$#cols;$i++){
		
		$fields=$fields."<item><FIELDNAME>$cols[$i]</FIELDNAME></item>\n";
	}

	
	
	$XML=~s/%TABLE_NAME%/$table/s;
	$XML=~s/%FIELDS%/$fields/s;
	
	#print "$XML\r\n";
	my @answers=send_soap($XML,1);

	my $answer=join('', @answers);

	print "$answer\r\n";

}