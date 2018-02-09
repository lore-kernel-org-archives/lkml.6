Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AH8x224BbyS5sQ2bjGO7i9kwF5t/p11AUwV9DRpQRcOdOv6h7JAhwiexPKD5YfGsOzO3MXR/sZGB
ARC-Seal: i=1; a=rsa-sha256; t=1518136560; cv=none;
        d=google.com; s=arc-20160816;
        b=LbcvXnP62ebMcOLRIBdWltbxbV+MzntrlzWdm0C6lIq5J2RBmcTR7fGmkRPiInhlwC
         KKX4cCC5ynQiiYf4mqRpFHZvIOr+XJAtgtMLPZaF/6z/XglHJ/QnsncAxzyyHJwyHG06
         YNc7BdWBngmnBUMYloOB0eeoh5mBppQsQHr5pS029CYzvYQr1wPWW8ygyr73WrUHwKhB
         9oXo+pQql6cXvDhSroHAfNv1sEH/cO848tINxbwp6bWNDb06je6ONXujOBeOMEX6HNir
         VN7xH3AsUKmkW4+bd6ciZISSsL7ljy8JpJpy+X8fQDXo7pF+MLHcA0IQ67EPMulz2Z6b
         ubFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=RfrAK3ziUb2iGmPPONnjFstjcit6sKhAFIC+i4SkiJU=;
        b=sw7oT2ZLTe50uVYspBX3nDhQrd6Z7ij7y96YgNB4jKxIYoBC9NT+UHL9iCVvw799mH
         gudvHdaq5o9QE1/wzSx96nQSIhpJMkrSeC6fC38Vu03ihI8SbBY0KLwdo18/wX4dEfnn
         ZzMGegSIOWY7Urs7jiah0RyCIzXzMTXtKP7n+2P+P8Gb2uVezLSumLhJCKgj9Y/NPUby
         sa34lJQDk4YEZvWOCPi73l+JMq6AFGPvckDskH7nneTK9tWyPe3YCNuAD5XwAILT1WR2
         hBLw8Gys4tnxvHw87WUTWuITPFCtXPpt4ypiQr1btdM6kwamWoHGNOTUXVo5C35svT/U
         YXpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.92 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.92 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3355:3622:3653:3865:3866:3867:3868:3870:3873:4250:4321:5007:6117:7550:7875:7901:7903:7974:10004:10400:10848:11026:11232:11473:11658:11914:12043:12291:12438:12555:12740:12760:12895:13439:14181:14659:14721:21080:21220:21325:21433:21451:21611:21627:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: test70_5130b15dd3e2a
X-Filterd-Recvd-Size: 3801
Message-ID: <1518136556.1815.10.camel@perches.com>
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
From: Joe Perches <joe@perches.com>
To: Rob Herring <robh@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner
 <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 08 Feb 2018 16:35:56 -0800
In-Reply-To: <1517606282.7489.165.camel@perches.com>
References: <20180202154026.15298-1-robh@kernel.org>
	 <1517606282.7489.165.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591881561766624791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-02 at 13:18 -0800, Joe Perches wrote:
> On Fri, 2018-02-02 at 09:40 -0600, Rob Herring wrote:
> > Add SPDX license tag check based on the rules defined in
> > Documentation/process/license-rules.rst. To summarize, SPDX license tags
> > should be on the 1st line (or 2nd line in scripts) using the appropriate
> > comment style for the file type.
> > 
> > Cc: Andy Whitcroft <apw@canonical.com>
> > Cc: Joe Perches <joe@perches.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Philippe Ombredanne <pombredanne@nexb.com>
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Andrew, would you pick this up please?

> > ---
> > v6:
> > - Dropped script extension check and only look for #!/... on 1st line. A 
> >   text executable file was not reliable either.
> > - Support .awk and .tc which may or may not have a #!/.
> > - Fixed a typo in script "#!" regex and also match on first /.
> > - Add Greg's ack.
> > 
> >  scripts/checkpatch.pl | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index ba03f17ff662..6db245e5f93b 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -2225,6 +2225,8 @@ sub process {
> >  
> >  	my $camelcase_file_seeded = 0;
> >  
> > +	my $checklicenseline = 1;
> > +
> >  	sanitise_line_reset();
> >  	my $line;
> >  	foreach my $rawline (@rawlines) {
> > @@ -2416,6 +2418,7 @@ sub process {
> >  			} else {
> >  				$check = $check_orig;
> >  			}
> > +			$checklicenseline = 1;
> >  			next;
> >  		}
> >  
> > @@ -2866,6 +2869,30 @@ sub process {
> >  			}
> >  		}
> >  
> > +# check for using SPDX license tag at beginning of files
> > +		if ($realline == $checklicenseline) {
> > +			if ($rawline =~ /^[ \+]\s*\#\!\s*\//) {
> > +				$checklicenseline = 2;
> > +			} elsif ($rawline =~ /^\+/) {
> > +				my $comment = "";
> > +				if ($realfile =~ /\.(h|s|S)$/) {
> > +					$comment = '/*';
> > +				} elsif ($realfile =~ /\.(c|dts|dtsi)$/) {
> > +					$comment = '//';
> > +				} elsif (($checklicenseline == 2) || $realfile =~ /\.(sh|pl|py|awk|tc)$/) {
> > +					$comment = '#';
> > +				} elsif ($realfile =~ /\.rst$/) {
> > +					$comment = '..';
> > +				}
> > +
> > +				if ($comment !~ /^$/ &&
> > +				    $rawline !~ /^\+\Q$comment\E SPDX-License-Identifier: /) {
> > +					WARN("SPDX_LICENSE_TAG",
> > +					     "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
> > +				}
> > +			}
> > +		}
> > +
> >  # check we are in a valid source file if not then ignore this hunk
> >  		next if ($realfile !~ /\.(h|c|s|S|sh|dtsi|dts)$/);
> >  
