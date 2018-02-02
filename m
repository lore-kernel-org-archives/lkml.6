Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AH8x225QCu2m9OfiJto3NsLqJ+CTO9pCTx3zoZr7jHxDbAxr/nxMbKrHIXam1GxpqPjHDe8bELO0
ARC-Seal: i=1; a=rsa-sha256; t=1517605806; cv=none;
        d=google.com; s=arc-20160816;
        b=Mc8A/sH3VZEZJ8cFEORQ/5hCOxbzSce8f4c7yzMaqbPMdCJ9RLSODsTGthrbb8urdu
         jDsYMQAjvdjGCtfSIW23zxaZ9dIvsvzPgI/jHgMxw0GNpGDsBJZdXFnH6MfQlOolOpTB
         Kl6Hck4sAnr6fQAL1tDscVJlUZFZpJFukpoJ0H718WXdZJuCnaWzOi2UVADEDuaCb2Vr
         IB6ZDOEbCzQX245GEh7nXdV051ori9nkUxvegAUcvgs2JHgK/6uvFevu5a0N6QdCK0BA
         DQk817C7VicdatqUe69Q7abMDNke73DGMh9UShBzNC/Ix9xRzD9jgMSEaSe1wAYDzRd3
         AQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=9SNldGCdQMVw7EJvrRjdZxWvH8q5PdIOUzPkDrJZ9cU=;
        b=S5NsBf16cX/eCLnrN7j4zFgyYffPJEiYGpdHCEHwTmTDgGGXPm0TIBixUb0jK1vMOE
         sqF4AbXJpFKDDpOg4ndr0YwSN66p2fMgb6ctChMIKq34uEFiBpSQEOX8ek0qtED2Z0No
         YJ+cD3BdhMkDNJl71wz3XdHa37APwIyrmPb2j/94rSOywsxtiO2hnzH08pToUp7XvE4q
         rjGmnQP5yya91HEYtToUT6NXl5lwEMWJADHQZzMcbODHwmZn2pGFq1lbAuBn0O5VhU1C
         wueFdKuHrOuPqe54rP6sxlSvpMNBn5m7izrCYAZaR+19zxbgJHfKoKAXx0RdQyiW/57X
         kAjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.50 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.50 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2110:2194:2199:2393:2553:2559:2562:2687:2691:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:5007:6117:6119:7901:7903:9108:10004:10400:10848:11232:11658:11914:12043:12740:12760:12895:13069:13161:13184:13229:13311:13357:13439:14096:14097:14181:14659:14721:14819:21080:21433:21451:21611:21627:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: crook70_7501941044434
X-Filterd-Recvd-Size: 2820
Message-ID: <1517605802.7489.164.camel@perches.com>
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
From: Joe Perches <joe@perches.com>
To: Rob Herring <robh@kernel.org>
Cc: Igor Stoppa <igor.stoppa@huawei.com>, Kate Stewart
 <kstewart@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy
 Whitcroft <apw@canonical.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
 Philippe Ombredanne <pombredanne@nexb.com>, Jonathan Corbet <corbet@lwn.net>
Date: Fri, 02 Feb 2018 13:10:02 -0800
In-Reply-To: <CAL_JsqJDgNrpfhg_5bL0VywJ9zFLbO+aCJsCKow9YPSJnB8huw@mail.gmail.com>
References: <20180202154026.15298-1-robh@kernel.org>
	 <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
	 <CAL_JsqK+1Z_vuFE_po1VCxkSc112OFmgCiwM7F1S0mH6gw3KHQ@mail.gmail.com>
	 <1517598363.7489.126.camel@perches.com>
	 <CAL_JsqJDgNrpfhg_5bL0VywJ9zFLbO+aCJsCKow9YPSJnB8huw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591325026043899947?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-02 at 14:57 -0600, Rob Herring wrote:
> On Fri, Feb 2, 2018 at 1:06 PM, Joe Perches <joe@perches.com> wrote:
[]
> > Right now, there are many missing licenses
> > that are already used by various existing
> > SPDX-License-Identifier: entries.
> > 
> > APACHE-2.0
> 
> Given that Apache 2.0 is not compatible with GPL 2, that would pretty
> much mean anything with Apache license is dual licensed and it would
> be the other license that applies. Do we really want/need license
> texts for all the other possible licenses that don't apply to kernel
> files?

There are 2 uses of SPDX.*Apache in staging.

drivers/staging/android/ashmem.h:// SPDX-License-Identifier: (GPL-2.0 OR Apache-2.0)
drivers/staging/android/uapi/ashmem.h:// SPDX-License-Identifier: (GPL-2.0 OR Apache-2.0)

I believe each specific license text should be
available in either the actual source file with
the Apache license or in a specific LICENSES/
file in the kernel tree.

> If so, 
> this should all just be scripted to sync LICENSES/ with
> found SPDX tags in the kernel.

Right.  That's probably best.

> ISC and OpenSSL are only in license-rules.rst as examples. We should
> just fix those examples to something else.

Sounds good to me.

I should have excluded Documentation/process/license-rules.rst
from the SPDX matches.

Are significant portions of that document generic across
multiple projects or is it entirely specific to linux?

cheers, Joe
