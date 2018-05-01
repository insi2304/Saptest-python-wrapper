use MIME::Base64 ();
use Crypt::CBC ();
use Crypt::DES_EDE3 ();
use Digest::MD5;

sub readKeyFromFile{
	%hash=();
	for($i=1; $i<=$_[0]; $i++)
	{
		read(FILE_KEY, $buf, 60);
		($major, $minor, $rKey_tmp)= unpack("x7B32x6B32x7A32", $buf);
		#$major+=0;
		#$minor+=0;
		$major = unpack("N", pack("B32", substr("0" x 32 . $major, -32)));
		$minor = unpack("N", pack("B32", substr("0" x 32 . $minor, -32)));
		$hash{"{V".$major.'.'.$minor.'}'} = $rKey_tmp;
	}
}
sub getLastKey{
	open FILE_KEY, $_[0];
	read(FILE_KEY, $buf, 10);
	$count_key = unpack("x6B32", $buf)+0;
	$major_last=1;
	$minor_last=1;
	%hash=();
	for($i=1; $i<=$count_key; $i++)
	{
		read(FILE_KEY, $buf, 60);
		($major, $minor, $rKey_tmp)= unpack("x7B32x6B32x7A32", $buf);
		$major = unpack("N", pack("B32", substr("0" x 32 . $major, -32)));
		$minor = unpack("N", pack("B32", substr("0" x 32 . $minor, -32)));
		if($major > $major_last){$major_last = $major;}
		if($minor > $minor_last){$minor_last = $minor;}
		$hash{"{V".$major.'.'.$minor.'}'} = $rKey_tmp;
	}
	return $hash{"{V".$major_last.'.'.$minor_last.'}'};
}
sub usage{
	print("\nUsage:\n");
    print("	PSCipher.pl -encryptByDefault <ClearText>\n");
    print("or\n");
    print("	PSCipher.pl -encrypt <ClearText> <pathname_key>\n");
    print("     (to encrypt the clear text)\n");
    print("or\n");
    print("	PSCipher.pl -decrypt <CipherText> [<pathname_key>]\n");
    print("     (to decrypt the cipher text)\n");
}
sub encodePassword{
	if(defined($password = $_[1]) && defined($pathname_key = $_[2]))
	{
		print("Clear text: ", $password, "\n");
		$rKey = getLastKey($pathname_key);
		$encKey = MIME::Base64::decode($rKey);
		$cipher = Crypt::CBC->new(-literal_key => 1,
									-key => $encKey,
									-cipher => "Crypt::DES_EDE3",
									-iv => "CDGJJPTY",
									-header => 'none'
									);
		$ebytes = $cipher->encrypt($password);
		$encPwd = MIME::Base64::encode($ebytes);
		$resPwd = "{V".$major_last.'.'.$minor.'}'.$encPwd;
		print("Encrypted text: ", $resPwd,"\n");
		close OUT;
	}
	else{usage();}		
}
sub PBKDF1{
	$origSalt = "\x01\x02\x03\x04\x05\x06\x07\x08";
	$origPwd = "not_so_secrect";
	$md5 = Digest::MD5->new;
	$md5->add($origPwd.$origSalt);
	$DK = $md5->digest;
	($K, $IV) = unpack("A8A8", $DK);
	return ($K, $IV);
}
sub getKeyFromCipherText{
	getLastKey($_[1]);
	$password = $_[0];
	if(($tmp = unpack("A2",$password)) eq "{V")
	{
		$version = substr($password, 0, index($password, "}")+1);
		if(defined($h = $hash{$version})){return ($h, substr($password, index($password, "}")+1));}
	}
	return;
}
sub decodePassword{
	if(defined($encPwd = $_[1]))
	{
		print("Encrypted text: ", $encPwd, "\n");
		if(defined($pathname_key = $_[2]))
		{
			($rKey, $encPwd) = getKeyFromCipherText($encPwd, $pathname_key);
			if(!defined($rKey))
			{
				print("Not found key\n");
				return;
			}
			$encKey = MIME::Base64::decode($rKey);
			$Pwd = MIME::Base64::decode($encPwd);
			$cipher = Crypt::CBC->new(-literal_key => 1,
										-key => $encKey,
										-cipher => "Crypt::DES_EDE3",
										-iv => "CDGJJPTY",
										-header => 'none',
										);
			$password = $cipher->decrypt($Pwd);
		}
		else
		{
			($K, $IV) = PBKDF1();
			$cipher = Crypt::CBC->new(-literal_key => 1,
										-key => $K,
										-cipher => "Crypt::DES",
										-iv => $IV,
										-header => 'none'
										);
			$Pwd = MIME::Base64::decode($encPwd);
			$password = $cipher->decrypt($Pwd);
		}
		print("Decrypted text: ", $password, "\n");
	}
	else{usage();}		
}
sub encodePasswordByDefaultKey{
	if(defined($password = $_[0]))
	{
		print("Clear text: ", $password, "\n");
		($K, $IV) = PBKDF1();
		$cipher = Crypt::CBC->new(-literal_key => 1,
										-key => $K,
										-cipher => "Crypt::DES",
										-iv => $IV,
										-header => 'none'
										);
		$enc = $cipher->encrypt($password);
		$encPwd = MIME::Base64::encode($enc);
		print("Encrypted text: ", $encPwd, "\n");
	}
	else{usage();}
}

$mode = lc(@ARGV[0]);
if($mode eq "-encrypt"){encodePassword(@ARGV);}
elsif($mode eq "-decrypt"){decodePassword(@ARGV);}
elsif($mode eq "-encryptbydefault"){encodePasswordByDefaultKey(@ARGV[1]);}
else{usage();}