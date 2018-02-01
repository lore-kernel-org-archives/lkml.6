Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AH8x2256kFQwt8dZGQmEn8hUmpQ9WodP+xKcCyW6NoU1UnvjRKn/3+V9lJmU/eNfCJcHvTvwBf/9
ARC-Seal: i=1; a=rsa-sha256; t=1517521747; cv=none;
        d=google.com; s=arc-20160816;
        b=qWB4znUtkSH5acmiO317FFTwsW9JniBesgTbhgjC6NnUNzyKCRpS7CL1hnckV/kjOn
         K2Ub7oGL8BvPvejANP/6zmYVu20zVmTcnhft4IAsJvvlxD7gZPV8r5GRk8y85eAHFqlY
         4eBiFVmHAkz5KOiVys4CaeB3vjog0bUaM98qR6whGhfrh/grEP4sy02ioTjzDMFRAFzz
         YqdRIETlGNxohQmJQv49CFpBh0CFDURQNaNEinT9U4HOpku73ZSKy0PGk4vUb5263nTU
         807G4fxbQKhVqQy9S/lGP8q7ML89rXLP9R9VJxFLB7sXTwNBLg5HMKCxJLaluT5A9BDM
         2aqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=T8nS1wRkARwQDBC/UR8uMRRRV1UEFQ44MROpjG6gclc=;
        b=vFcZEREnnpWXfkaQCQmvG86yTeVKBx6sxs3XyZLoru+koe1+JpeM5sg2zW82CRjNFm
         t8AjN3FIKhSRL8lF84fqLM5yO/Z1w2Ui4q3ifHfHljCdkTgj+gEDVuGyt6rRuBjt0K1K
         L++HraRTPWF3Cd5x2BLO6iAN85w/FX1hP45uv0feVNjoGyaQBqa69h/HMu1GhoXSNfeW
         g5Xibhu/7/BJTGNwwL/2/ZQpRmDXMPbSn5ChxWja/NyODuRDc41AP3iShdBfeW7ap0E5
         ONSnLpyHe4IYD/kkuwTiej4wDtS2s3faT3sVL5Xtp4C7mjmVKIUKk7KfblmSrsFkG7B/
         0ndA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.169 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.169 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2911:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4425:5007:6117:6119:7550:7901:7903:7974:10004:10400:10848:11026:11232:11473:11658:11914:12043:12740:12760:12895:13161:13229:13439:14181:14659:14721:21080:21220:21325:21451:21611:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: actor23_6c90ce5ca2606
X-Filterd-Recvd-Size: 3212
Message-ID: <1517521744.7489.64.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Add SPDX license tag check
From: Joe Perches <joe@perches.com>
To: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, Andrew
 Morton <akpm@linux-foundation.org>
Cc: Andy Whitcroft <apw@canonical.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 01 Feb 2018 13:49:04 -0800
In-Reply-To: <20180201211429.32696-1-robh@kernel.org>
References: <20180201211429.32696-1-robh@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591234706723646014?=
X-GMAIL-MSGID: =?utf-8?q?1591236884059806162?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-02-01 at 15:14 -0600, Rob Herring wrote:
> Add SPDX license tag check based on the rules defined in
> Documentation/process/license-rules.rst. To summarize, SPDX license tags
> should be on the 1st line (or 2nd line in scripts) using the appropriate
> comment style for the file type.
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> I didn't get around to resending once license-rules.rst landed in -next. 
> Hopefully, this can be picked up for 4.16 so folks can start using it. 
> SPDX tags have already become a frequent review comment.

Seems sensible enough now.
Here are some other suggestions.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2866,6 +2869,30 @@ sub process {
>  			}
>  		}
>  
> +# check for using SPDX license tag at beginning of files
> +		if ($realline == $checklicenseline) {
> +			if ($realfile =~ /\.(?:sh|pl|py)/ && $rawline =~ /\[ \+]\s*\!\#/) {

There are many files with a #! shebang that do
not use these filename types.

$ git grep -P --name-only '^\s*\#\!\s*/(?:bin|usr)' | \
  grep -vP
"(?:txt|rst|py|sh|pl)$" | wc -l
158

i.e.: .tc and .awk files and ~100 files without extensions

So I would add awk and tc to the $realfile test and
perhaps extend this check to test if the file is not
binary and executable.

> +				$checklicenseline = 2;
> +			} elsif ($rawline =~ /^\+/) {
> +				my $comment = "";
> +				if ($realfile =~ /\.(h|s|S)$/) {
> +					$comment = '/*';
> +				} elsif ($realfile =~ /\.(c|dts|dtsi)$/) {
> +					$comment = '//';
> +				} elsif ($realfile =~ /\.(sh|pl|py)$/) {
> +					$comment = '#';
> +				} elsif ($realfile =~ /\.rst$/) {
> +					$comment = '..';
> +				}
> +
> +				if ($comment !~ /^$/ &&
> +				    $rawline !~ /^\+\Q$comment\E SPDX-License-Identifier: /) {
> +					WARN("SPDX_LICENSE_TAG",
> +					     "Missing or malformed SPDX-License-Identifier tag in 1st (or 2nd for scripts) line\n" . $herecurr);

Perhaps 'Missing ... in line $checklicense\n"
