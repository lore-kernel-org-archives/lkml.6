Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AG47ELv6CTj/Hj7xaIh5yBeqw0EW7mj18Kg+mWuIXZL92XBlPa5K8DwiGRmPiIHGmhY9sdqR5HbC
ARC-Seal: i=1; a=rsa-sha256; t=1521135311; cv=none;
        d=google.com; s=arc-20160816;
        b=NRWwOONc2j9XX3KfqUWlT/GToxIAwVM98qSixyBuJsv/Ict8Ic6Wdr4JBZdnezNufa
         gAmO6+fKRN4ydO9FL7UFw0jFX48SuVKusF0SXyLgpt6iJY+1LLRnGE+7z/cfy5ZWnfRp
         4qz8j6zB61shCXJiEc2ToTvSUzHV8nlgi70/66NaeAp+wZeO3d8C4ScQxGLPTP7z826+
         l/gDYPJM3qkg/oeJtTbEXipbps8t4OLUD98N3+R7K5kh/I7Uj0VwK4VCv/1UtpfWZ3hw
         sMwZnQPBnlvOlfTlMjGw3+Xztc+6HEOHXir+uKwW41uWlx/OTe+MR4DtO+c5gTk+hQGI
         MrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=Pb/QJtZ+WlF8yULW/UllEKrM9kYVlLdT/HoChQ6dekE=;
        b=UE088+mPqTn95ID6yG9PIuJKR1hxRNBXJdQb0muy+/YqMvqasHo1JTykI/hD+3ott8
         kQ2MjJl5NkHWfKYff4f3rx6C4jty2ymVtWfVLjCfi1zfZLTrH9USChAUXklRM17n2Q+y
         3vUvHhqa9cd/5HkSHi2NPUoiVoMOpd/EEJVmFLwA41FoZ7i9VBt/AMeEEkNcJudHUYTZ
         KYuQPZpOI3APfzueXpESI//8VX6AwTNzOb4EBWC3HPykxQtOQbIRx/JNAQJAC6CEvuNV
         Ae1M/p+QBMS3PEDaB8KR6P2PNoRjbLa0yAWlTDt+6IsYA9ZlYdwlt+YPyNhQOdYVOho/
         nivg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.194 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.194 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::,RULES_HIT:41:355:379:541:599:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1981:2194:2197:2199:2200:2393:2525:2553:2560:2563:2682:2685:2828:2859:2892:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6117:6119:6299:7903:9025:9163:10004:10400:10848:11232:11658:11914:12043:12050:12740:12760:12895:13439:14093:14097:14180:14181:14659:14721:21080:21221:21433:21451:21627:30022:30054:30075:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:21,LUA_SUMMARY:none
X-HE-Tag: rifle25_2ced8131acb48
X-Filterd-Recvd-Size: 3583
Message-ID: <1521135307.22221.42.camel@perches.com>
Subject: Re: [patch 0/4] genirq: Clean up license information
From: Joe Perches <joe@perches.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>,  Ingo Molnar <mingo@kernel.org>, Marc
 Zyngier <marc.zyngier@arm.com>, Kate Stewart
 <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 15 Mar 2018 10:35:07 -0700
In-Reply-To: <20180315172343.GA28917@kroah.com>
References: <20180314211515.429128440@linutronix.de>
	 <1521126018.22221.8.camel@perches.com> <20180315172343.GA28917@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594949825957172254?=
X-GMAIL-MSGID: =?utf-8?q?1595025979753383615?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-15 at 18:23 +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 15, 2018 at 08:00:18AM -0700, Joe Perches wrote:
> > On Wed, 2018-03-14 at 22:15 +0100, Thomas Gleixner wrote:
> > > The following patch series cleans up the licensing information in the
> > > generic irq subsystem.
> > > 
> > >   * Replace boiler plate language and sloppy references with SPDX
> > > 
> > >   * Add missing SPDX identifiers to files with no license reference
> > > 
> > >   * Use the proper tag format
> > > 
> > > While at it clean up the top of file comments by removing pointless
> > > references to the filename itself and condense the information where
> > > appropriate.
> > 
> > Hello.
> > 
> > What do you think of the proposal to convert all the tags
> > to the "-or-later" and "-only" variants that the
> > https://spdx.org/licenses/ uses today?
> 
> Ick ick ick ick.  Let's stick with what we have today, if we do decide
> to do this type of foolishness,

Why would it be foolish to have the kernel
match the spdx license text?

> we can do it all in one simple script to
> email to Linus to run on his tree.

I sent that script Feb 8.

Here it is again:
---
#!/bin/bash

license_script=$(mktemp -t convert-SPDX-licenses.XXXXXXXXX.pl)
cat <<'EOF' >> $license_script

our $balanced_parens = qr/(\((?:[^\(\)]++|(?-1))*\))/;

sub deparenthesize {
	my ($string) = @_;

	return "" if (!defined($string));

	while ($string =~ /^\s*\(.*\)\s*$/) {
		$string =~ s@^\s*\(\s*@@;
		$string =~ s@\s*\)\s*$@@;
	}

	return $string;
}

for my $filename (@ARGV) {
	my $FILE;

	if ($filename eq '-') {
		open($FILE, '<&STDIN');
	} else {
		open($FILE, '<', "$filename") ||
			die "$P: $filename: open failed - $!\n";
	}
	undef $/;
	my $file = <$FILE>;
	close $FILE;

	my $spdx = "SPDX-License-Identifier:";

	$file =~ s/\b$spdx[ \t]*((?:\([ \t]*)*)GPL(\d\.\d)/$spdx \1GPL-\2/g;
	$file =~ s/\b$spdx[ \t]*((?:\([ \t]*)*)(L?GPL-\d\.\d)\+/$spdx \1\2-or-later/g;
	$file =~ s/\b$spdx[ \t]*((?:\([ \t]*)*)(L?GPL-\d\.\d)(?!-or-later|-only)/$spdx \1\2-only/g;

	while ($file =~ s/\b$spdx[ \t]($balanced_parens)(?![ \t]*AND|[ \t]*OR)/$spdx . ' ' . deparenthesize($1)/ex) {
		;
	}

	if ($filename eq '-') {
		open($FILE, '>&STDOUT');
	} else {
		open($FILE, '>', "$filename") ||
			die "$P: $filename: open failed - $!\n";
	}
	print $FILE $file;
	close $FILE;
}
EOF

git grep --name-only "$spdx" | \
    grep -vP "^(?:LICENSES/|Documentation/process/license-rules\.rst)" | \
    xargs perl $license_script

rm -f $license_script
