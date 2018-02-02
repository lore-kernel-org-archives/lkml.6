Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AH8x227Eu3/Jg6QIdz8JlnI6Ig0CErMSPOpQg8FgbwzmumZtuftQKpO/8QBwFCGyTHrZFD9827rT
ARC-Seal: i=1; a=rsa-sha256; t=1517598366; cv=none;
        d=google.com; s=arc-20160816;
        b=OlppfuhPAJ/L0OUiOskT/P3ebdorVdaZsEStoXUZ6vYOewKV8he4Yc8pah3WQKhoSk
         ShL+J6kuPY/ZBZaYCfaDQYh0ZjpiRhE4JK2+jaSp3EWgOCoM91VurzHa+IfUfIIudrWO
         w3lbjMdqkeXIpvUMT6XkYxKy8ozxljydmAILUDM71sOrnZTinq1lYreDZjBQ2YFdaclh
         0CfsXUNtd5zHTuQR9KtrCkjArcLcQlBY4QMtD1tZwf/ggVayEXKmMTU8bV061s3o9hAz
         2YzdS/mmXnrp/EABIWrsZUukf5m5enDv7Tdf6NqLaCiNjbqZOaYpPZdqqojCt8atW3nr
         LD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=bkKANAv/HFG/98uqz0Z0ltYzcOtlgJvdw+flMEy+rMs=;
        b=nx2TXn+FXHonpQt68SEjqaPvwznDEaQ/0fhHKSwql8qo3sYoG95XAppXUqnCOIl7wL
         v4O5B8pCQeXVBO42TisKjVkoZxSk9AhMPkn0E9w8zTVLnl09w/tGbBQEgE/k4FfBPS34
         G56xO5vaqltMBREW5gzR5w6YwlSUQ1yJ/+LOcvtxdQWw53z8R4G/0hUTz1/R57YMjvcr
         XGU+Qx/SIVLw0Wny9PKtIbEjcjB2oSlIbr5SPW93ouHvL+dDs+TgYfy5goGuIBxS0I+e
         Dxyj7gsnnfKmXkmBi79P13QSMEtu3hjLl6SzMcqnSRcMcM33z+dCGlHaPP+OPHmI/GI/
         UwLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.45 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.45 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:5007:6117:6119:7901:7903:8784:10004:10400:10848:11232:11658:11914:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21220:21451:21611:21627:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: pump26_351392d3ee34b
X-Filterd-Recvd-Size: 2381
Message-ID: <1517598363.7489.126.camel@perches.com>
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
From: Joe Perches <joe@perches.com>
To: Rob Herring <robh@kernel.org>, Igor Stoppa <igor.stoppa@huawei.com>,
	Kate Stewart <kstewart@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy
 Whitcroft <apw@canonical.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>, Jonathan Corbet <corbet@lwn.net>
Date: Fri, 02 Feb 2018 11:06:03 -0800
In-Reply-To: <CAL_JsqK+1Z_vuFE_po1VCxkSc112OFmgCiwM7F1S0mH6gw3KHQ@mail.gmail.com>
References: <20180202154026.15298-1-robh@kernel.org>
	 <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
	 <CAL_JsqK+1Z_vuFE_po1VCxkSc112OFmgCiwM7F1S0mH6gw3KHQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591317225222632802?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-02 at 12:27 -0600, Rob Herring wrote:
> On Fri, Feb 2, 2018 at 9:49 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> > On 02/02/18 17:40, Rob Herring wrote:
> > > Add SPDX license tag check based on the rules defined in
> > 
> > Shouldn't it also check that the license is compatible?
> > 
> 
> Perhaps we shouldn't try to script legal advice.

True.

I believe what was meant was that the
entry was a valid SPDX License entry
that already exists as a specific file
in the LICENSES/ path.

So that entry must be some combination of:

$ git ls-files LICENSES/ | cut -f3- -d'/' | sort
BSD-2-Clause
BSD-3-Clause
BSD-3-Clause-Clear
GPL-1.0
GPL-2.0
LGPL-2.0
LGPL-2.1
Linux-syscall-note
MIT
MPL-1.1

>From my perspective, it'd be better if the
various + uses had their own individual
license files in the LICENSES/ path.

Right now, there are many missing licenses
that are already used by various existing
SPDX-License-Identifier: entries.


APACHE-2.0
BSD
CDDL
CDDL-1.0
ISC
GPL-1.0+
GPL-2.0+
LGPL-2.1+
OpenSSL

There are odd entries like:

GPL-2.0-only

Parentheses around AND/OR aren't consistent.
