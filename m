Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AH8x227AQxsVqrPX/eahW2/2/lfLBrNFvFw3ARpznsLUbu/vwb9XPHH4DPEmYUqHY1haw/W7CpFC
ARC-Seal: i=1; a=rsa-sha256; t=1518801212; cv=none;
        d=google.com; s=arc-20160816;
        b=fYFXiwGmuPgik7x393RMhLu1A080JcpFwYPfEC16gwqKBq2CVvjxaW4sV/ZKEkJHfO
         G4g0I1YpOqbmjsj+Bw+5b01BxxebC6c3g/d0KDe/cdihZN5AjJidY6C1n0qoNLTP7nea
         gIzLg7TQwVlIN9SF8pbOJw3EvScQNRBcGX+Fj655YyFykjl+hfocErjKL23Vw2Yt2XPW
         DqLRUY4gxgnSsu/w7lV7DQCn3sySsxnlU39ZI4/sCRlNFJ94jjfostKE+PQyyHdEnCV+
         lrzGNthZDctHxVRFXUuQ9025d9c4FIosrB9HUIjx0vyUEhr/P9R2I4n/aXQiMgRjbFQS
         1CZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=lW34xxgzYAhfR9iG1ZzdS+79i9ZvKXaVHHqs38Pk300=;
        b=Z4Ql3fKehZFhH+HQyuoFh4nPfw6B3stkWuL78WAxon/XeBFEnzNBQUpuiv8gaUvTQl
         A4D8WJDM1yTokG36vk6RCqGEC+YsP9px9JXzl1ZFSLpuOIsLplxMWdBYCqKfvChcHfF3
         6ZJ+iGr1F2GkvlU78wMt8+2kkBTOMluTaYM1jGGD3ClGjjKcNbQvh/gaekkGhTQ04w2x
         tAxM7U/PDEBYRFe3+8Nm6WVuSsatqzQAVunElhc3c3NSzYmJk+7e+qNQXbpFoodemdq2
         /k0NHSazTIBBD9lOG0SaXHZTupdw3oSUjlcUdRElGhRZa9Z0gNunzrNBonfE3+vvwkik
         cwxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.196 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.196 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:2:41:355:379:541:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1535:1593:1594:1605:1730:1747:1777:1792:2197:2198:2199:2200:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4049:4118:4250:4321:5007:6119:6120:7514:7875:7903:8957:9592:10004:10848:11026:11232:11658:11914:12043:12291:12295:12296:12438:12555:12683:12740:12760:12895:12986:13439:14659:21080:21221:21324:21433:21451:21505:21611:21627:21740:30012:30029:30054:30070:30080:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: trade14_1e7ed771ec52a
X-Filterd-Recvd-Size: 7206
Message-ID: <1518801207.13169.15.camel@perches.com>
Subject: [RFC patch] checkpatch: test identifier lengths
From: Joe Perches <joe@perches.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Yash Omer
 <yashomer0007@gmail.com>,  Andrew Morton <akpm@linux-foundation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
	driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
	Larry.Finger@lwfinger.net
Date: Fri, 16 Feb 2018 09:13:27 -0800
In-Reply-To: <20180216125519.odsteynuaielxpet@mwanda>
References: <20180216113634.12848-1-yashomer0007@gmail.com>
	 <20180216125519.odsteynuaielxpet@mwanda>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592578499665778653?=
X-GMAIL-MSGID: =?utf-8?q?1592578499665778653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-16 at 15:55 +0300, Dan Carpenter wrote:
> On Fri, Feb 16, 2018 at 05:06:34PM +0530, Yash Omer wrote:
> > This patch fix line should not end with open parenthesis found by checkpatch.plscript.
> > 
> > Signed-off-by: Yash Omer <yashomer0007@gmail.com>
> > ---
> >  drivers/staging/nvec/nvec.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> > index 52054a528723..39fb737543b5 100644
> > --- a/drivers/staging/nvec/nvec.c
> > +++ b/drivers/staging/nvec/nvec.c
> > @@ -383,8 +383,8 @@ static void nvec_request_master(struct work_struct *work)
> >  		msg = list_first_entry(&nvec->tx_data, struct nvec_msg, node);
> >  		spin_unlock_irqrestore(&nvec->tx_lock, flags);
> >  		nvec_gpio_set_value(nvec, 0);
> > -		err = wait_for_completion_interruptible_timeout(
> > -				&nvec->ec_transfer, msecs_to_jiffies(5000));
> > +		err = wait_for_completion_interruptible_timeout
> > +			(&nvec->ec_transfer, msecs_to_jiffies(5000));
> 
> The original code is basically fine...  It's OK to ignore checkpatch in
> this situation.

Right.

Please remember checkpatch is basically stupid as it is
a trivial pattern matcher.

It is very hard to use 80 column line lengths with very
long identifiers.

Any time identifiers are very long (here 40+ characters),
checkpatch long line and line format messages should be
taken with extremely large grains of salt.

Dan/Andrew, what do you think of adding some --strict only
'very_long_identifier' message to checkpatch?

Something like the below: (perhaps using 25 chars lengths?)

This also excludes any long identifier found in include/...
like the camelcase tests.

---
 scripts/checkpatch.pl | 102 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d4040322ae1..3659ed0988c4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -59,6 +59,7 @@ my $conststructsfile = "$D/const_structs.checkpatch";
 my $typedefsfile = "";
 my $color = "auto";
 my $allow_c99_comments = 1;
+my $long_identifier_len = 25;
 
 sub help {
 	my ($exitcode) = @_;
@@ -541,12 +542,13 @@ our @typeListWithAttr = (
 	qr{struct\s+$InitAttribute\s+$Ident},
 	qr{union\s+$InitAttribute\s+$Ident},
 );
-
 our @modifierList = (
 	qr{fastcall},
 );
 our @modifierListFile = ();
 
+our %long_identifiers = ();
+
 our @mode_permission_funcs = (
 	["module_param", 3],
 	["module_param_(?:array|named|string)", 4],
@@ -834,6 +836,29 @@ sub seed_camelcase_file {
 	}
 }
 
+sub seed_long_identifier_file {
+	my ($file) = @_;
+
+	return if (!(-f $file));
+
+	local $/;
+
+	open(my $include_file, '<', "$file")
+	    or warn "$P: Can't read '$file' $!\n";
+	my $text = <$include_file>;
+	close($include_file);
+
+	my @lines = split('\n', $text);
+
+	foreach my $line (@lines) {
+		while ($line =~ /($Ident)/g) {
+			my $ident = $1;
+			next if (length($ident) <= $long_identifier_len);
+			$long_identifiers{$ident} = 1;
+		}
+	}
+}
+
 sub is_maintained_obsolete {
 	my ($filename) = @_;
 
@@ -902,6 +927,64 @@ sub seed_camelcase_includes {
 	}
 }
 
+my $long_identifiers_seeded = 0;
+sub seed_long_identifiers {
+	return if ($long_identifiers_seeded);
+
+	my $files;
+	my $long_identifier_cache = "";
+	my @include_files = ();
+
+	$long_identifiers_seeded = 1;
+
+	if (-e ".git") {
+		my $git_last_include_commit = `git log --no-merges --pretty=format:"%h%n" -1 -- include`;
+		chomp $git_last_include_commit;
+		$long_identifier_cache = ".checkpatch-long_identifier.git.$git_last_include_commit";
+	} else {
+		my $last_mod_date = 0;
+		$files = `find $root/include -name "*.h"`;
+		@include_files = split('\n', $files);
+		foreach my $file (@include_files) {
+			my $date = POSIX::strftime("%Y%m%d%H%M",
+						   localtime((stat $file)[9]));
+			$last_mod_date = $date if ($last_mod_date < $date);
+		}
+		$long_identifier_cache = ".checkpatch-long_identifier.date.$last_mod_date";
+	}
+
+	if ($long_identifier_cache ne "" && -f $long_identifier_cache) {
+		open(my $long_identifier_file, '<', "$long_identifier_cache")
+		    or warn "$P: Can't read '$long_identifier_cache' $!\n";
+		while (<$long_identifier_file>) {
+			chomp;
+			$long_identifiers{$_} = 1;
+		}
+		close($long_identifier_file);
+
+		return;
+	}
+
+	if (-e ".git") {
+		$files = `git ls-files "include/*.h"`;
+		@include_files = split('\n', $files);
+	}
+
+	foreach my $file (@include_files) {
+		seed_long_identifier_file($file);
+	}
+
+	if ($long_identifier_cache ne "") {
+		unlink glob ".checkpatch-long_identifier.*";
+		open(my $long_identifier_file, '>', "$long_identifier_cache")
+		    or warn "$P: Can't write '$long_identifier_cache' $!\n";
+		foreach (sort { lc($a) cmp lc($b) } keys(%long_identifiers)) {
+			print $long_identifier_file ("$_\n");
+		}
+		close($long_identifier_file);
+	}
+}
+
 sub git_commit_info {
 	my ($commit, $id, $desc) = @_;
 
@@ -1017,6 +1100,7 @@ for my $filename (@ARGV) {
 	@modifierListFile = ();
 	@typeListFile = ();
 	build_types();
+	seed_long_identifiers();
 }
 
 if (!$quiet) {
@@ -2256,6 +2340,7 @@ sub process {
 	my $setup_docs = 0;
 
 	my $camelcase_file_seeded = 0;
+	my $long_identifier_file_seeded = 0;
 
 	sanitise_line_reset();
 	my $line;
@@ -3554,6 +3639,21 @@ sub process {
 #ignore lines not being added
 		next if ($line =~ /^[^\+]/);
 
+# check for new long identifiers
+		while ($sline =~ /($Ident)/g) {
+			my $ident = $1;
+			if ($check && show_type("LONG_IDENTIFIER") &&
+			    $ident !~ /^X+$/ &&		#not a string
+			    length($ident) > $long_identifier_len) {
+				seed_long_identifiers();
+				if (!defined($long_identifiers{$ident})) {
+					CHK("LONG_IDENTIFIER",
+					    "long identifier '$ident' - consider shortening\n" . $herecurr);
+					$long_identifiers{$ident} = 1;
+				}
+			}
+		}
+
 # check for dereferences that span multiple lines
 		if ($prevline =~ /^\+.*$Lval\s*(?:\.|->)\s*$/ &&
 		    $line =~ /^\+\s*(?!\#\s*(?!define\s+|if))\s*$Lval/) {
