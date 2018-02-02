Return-Path: <joe@perches.com>
X-Google-Smtp-Source: AH8x224xUSRKhJWJ0AhBIf48rzhg6I82RY7+swfB7idy/f0h22hk47Ru2dmgzPiSoDc1EyHG2cD6
ARC-Seal: i=1; a=rsa-sha256; t=1517604939; cv=none;
        d=google.com; s=arc-20160816;
        b=FxKUMwH6bHj/fQ46myQvYdEZl7iJy/beG+D4hQoQK9/V6kDkLQ3rc/lxk8upl+ax4P
         A36zIpI2bqrdCEcOV0JaSNa4/5DFc403rFlPJTlS6DOVQG3feNok5SoZFFrCFrdXJB0X
         JOG69CHae0Rcu8CfLCjuhtNs+uUUSd2tRpoZpQjTkIxaf2ALG2VXD27Cj0+uE8Q9RxuT
         fKwmjHPCUVxi3SbdybYbDt51+v4ymU1QFMNdFtjCRLi9s+4VQPJrkXAIkxZDS7hWcJL4
         wpX0kXsMoQxNOZ9f8U6ux4eLb8hKPRajrqlcivvM3l+8vby6dPrUFuVqk5R8I2/AsKd+
         Jz/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=Bie8WMA+jsECM6hQ89umLJTNE2Typ1MujrxyzVFjNxs=;
        b=RlTs614zCtK2JrdXjcOgTZfQQK1RS5H68AdY8eUUfaF9PCAKQra872/6nNGhZpNh4r
         jFbTFUMFLUXy7vUYLywzfgW79m2Jn3uIVkzXici5IC0nx2GHxb+OPlt4qqHHIaXqO2Hs
         GlwwqRIxhwfOv1Pu5Xpz6uxz0mjhk6+1aFMlWx1s7E2OS8i6J1mjYVgN9V3zF6S1wqhI
         iwmdKa4O4Dpl5TBMqvmD4PPsBnO4XK9I3TFL+V+9FEtjf/iKpGKAcwpYs5A3NsRAzmeN
         OlPs5mJLuIVvcqaA+PGSRxLv9SSmLLGwJQPetBt7oEWpSVMOxRQIpR6+NiyMdoQ5hQ5G
         jfpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 216.40.44.88 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 216.40.44.88 is neither permitted nor denied by best guess record for domain of joe@perches.com) smtp.mailfrom=joe@perches.com
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:599:800:960:967:968:973:982:988:989:1042:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:1981:2194:2199:2393:2525:2553:2561:2564:2682:2685:2691:2693:2828:2859:2895:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:5007:6117:6119:7901:7903:8784:8985:9010:9025:10004:10848:11232:11658:11914:12043:12740:12760:12895:13149:13161:13184:13229:13230:13439:14181:14659:14721:21080:21220:21451:21611:21627:30030:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: chin93_885f942fced07
X-Filterd-Recvd-Size: 5949
Message-ID: <1517604935.7489.153.camel@perches.com>
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
From: Joe Perches <joe@perches.com>
To: Kate Stewart <kstewart@linuxfoundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: Rob Herring <robh@kernel.org>, Igor Stoppa <igor.stoppa@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  Andy Whitcroft <apw@canonical.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner
 <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Jonathan
 Corbet <corbet@lwn.net>
Date: Fri, 02 Feb 2018 12:55:35 -0800
In-Reply-To: <CAG_66ZT6R2Ki3AnH6RWRXpd8d64NDR2y-0BwyqJRpQD4hD01oQ@mail.gmail.com>
References: <20180202154026.15298-1-robh@kernel.org>
	 <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
	 <CAL_JsqK+1Z_vuFE_po1VCxkSc112OFmgCiwM7F1S0mH6gw3KHQ@mail.gmail.com>
	 <1517598363.7489.126.camel@perches.com>
	 <CAG_66ZT6R2Ki3AnH6RWRXpd8d64NDR2y-0BwyqJRpQD4hD01oQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591324117074684838?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-02-02 at 14:18 -0600, Kate Stewart wrote:
> On Fri, Feb 2, 2018 at 1:06 PM, Joe Perches <joe@perches.com> wrote:
> 
> > On Fri, 2018-02-02 at 12:27 -0600, Rob Herring wrote:
> > > On Fri, Feb 2, 2018 at 9:49 AM, Igor Stoppa <igor.stoppa@huawei.com>
> > 
> > wrote:
> > > > On 02/02/18 17:40, Rob Herring wrote:
> > > > > Add SPDX license tag check based on the rules defined in
> > > > 
> > > > Shouldn't it also check that the license is compatible?
> > > > 
> > > 
> > > Perhaps we shouldn't try to script legal advice.
> > 
> > True.
> > 
> > I believe what was meant was that the
> > entry was a valid SPDX License entry
> > that already exists as a specific file
> > in the LICENSES/ path.
> > 
> > So that entry must be some combination of:
> > 
> > $ git ls-files LICENSES/ | cut -f3- -d'/' | sort
> > BSD-2-Clause
> > BSD-3-Clause
> > BSD-3-Clause-Clear
> > GPL-1.0
> > GPL-2.0
> > LGPL-2.0
> > LGPL-2.1
> > Linux-syscall-note
> > MIT
> > MPL-1.1
> > 
> > From my perspective, it'd be better if the
> > various + uses had their own individual
> > license files in the LICENSES/ path.
> > 
> 
> At the end of december, the SPDX license list[1] was rev'd to
> Version: 3.0 28 December 2017.   At the request of
> FSF, the GNU license family would not use the "+" notation,

That's rather more sensible to me.

This should probably be updated in linux-next in
the near future rather than later.

> and would bias towards using "-only" and "-or-later", explicitly.
> So adding both variants to the LICENSES/ path aligns with
> this forward direction.

It's probably better to remove the + variants.

> > Right now, there are many missing licenses
> > that are already used by various existing
> > SPDX-License-Identifier: entries.
> > 
> > 
> > APACHE-2.0
> > BSD
> > CDDL

CDDL does not exist standalone and was caused by my
defective eyeballs when scanning the SPDX list via:

$ git grep -w "SPDX-License-Identifier:" | \
  cut -f3- -d":" | \
  sed -r -e 's/^\s+//' -e 's/\*\/\s*//' -e 's/\s+$//' | \
  sort | uniq -c | sort -rn

> > CDDL-1.0
> > ISC
> > GPL-1.0+
> > GPL-2.0+
> > LGPL-2.1+
> > OpenSSL
> > 
> > There are odd entries like:
> > 
> > GPL-2.0-only
> > 
> 
> This is the new way to represent GPLv2 only, as described above.
> While the GPL-2.0 and GPL-2.0+ notation is still valid,  it is deprecated
> in the latest version, so transitioning existing over time will probably
> be needed.

Probably better to remove and replace the old notation
instead of doing it piecemeal.

When the appropriate LICENSE file changes exist, a
generic substitution could work well.

$ git grep --name-only "SPDX-License-Identifier:" | \
  grep -vP "^(?:LICENSES/|Documentation/process/license-rules\.rst)" | \
  xargs perl -p -i -e 's/SPDX-License-Identifier:\s*(L?GPL-\d\.\d)\+/SPDX-License-Identifier: \1-or-later/;s/SPDX-License-Identifier:\s*(L?GPL-\d\.\d)(?!-or-later)/SPDX-License-Identifier: \1-only/'

> So I think the list of licenses to be added to
> LICENSES/ path is:
> 
> APACHE-2.0
> BSD
> CDDL
> CDDL-1.0
> ISC
> GPL-1.0-only
> GPL-1.0-or-later (note: actually same contents as one GPL-1.0-only)
> GPL-2.0-only
> GPL-2.0-or-later (same contents as GPL-2.0-only)
> LGPL-2.0-only
> LGPL-2.0-or-later (same contents as LGPL-2.0-only)
> LGPL-2.1-only
> LGPL-2.1-or-later (same contents as LGPL-2.1-only)

If LGPL-n.m -only and -or-later are the same,
there's probably no need for duplicate LICENSE
files and just making sure LGPL-n.m without any
other wording is exclusively used is proper.

> OpenSSL
> 
> Having files with the same contents, but different names is
> irritating, but I can't see a another way of complying with REUSE
> guidelines.   Any better suggestions?

What and where are the REUSE guidelines?

https://reuse.software/dev/
doesn't show me much.

> 
> 
> > Parentheses around AND/OR aren't consistent.
> > 
> 
> The SPDX specification has an appendix that calls for "(",")"
> around every license expresssion.   After discussion with some
> developers it was decided to be ok to relax that, and only add them
> when they were essential to clarify the logic.   The next rev of the
> SPDX specification will have this clarified as well.   I think we caught
> most of the changes in the kernel documentation patches for describing
> this,  but if you have specific cases to be reviewed,  happy to have
> a look.
> 
> Thanks, Kate
> 
> 
> [1] https://spdx.org/licenses/
