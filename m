Return-Path: <pombredanne@nexb.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518100944; cv=none;
        d=google.com; s=arc-20160816;
        b=rcLhWb1hwAZuUWpMK+7U+YQNiQD4RqU/M7I04uBis7po32LTOFBhTEHy1MGqH75VBt
         b+w9iyfDzNWF3V8Xl3LEJVO9HodM0OFmTjJ+IBOEVT8mziVsfZ/XZTPPafieumj2W85/
         bEquhCGrxnB6468pL2OTuCGCbNHaYWzQUls3FsvHpE/v13xXLWpJ3RbpHdPKHeqKtwrt
         6gczXImqIXFweTCtqd7Sw5eWNR3yu4FfzCwTBNYIfzE9OPfc9CFLiXP6c2pQrhFyzOmk
         uYxLau8LF+BJpncL1dgJuvkJcWBb5xUluwu1pzv1c5/gtZviWBvP9RCCdqDCCWJ9TY3O
         YY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=+EJXgoBND0uK44zAg2B95QT61nwFlX+WBM24zEeMCiU=;
        b=Za5q/q62ccoLdIU3SeEd1zKPJ+MA8zTE0i/g7aRy8B9uBsp7VVkvLOh5wGU5vZNBEj
         /OLanL34vOopp1tF7NEBWjaHjR4RgC4U/N0sa5HMWUBDW3dsjyIL6j+DD/2E32pkcr42
         BUl+DgiDHMIcmTvuDlRmKbEN2onlvHbTpCNmuzKKMjKHQkdKVaRaLMQbmGHfrPjQd/IV
         WKN68OT/V+QM8RhhooBSU8v/2ijVrBfWdtv8siDrx29yTB31thTbEqL3q+W6uhQZ73P9
         mJ+SJOedvFp812iuG3qe45o+TJLHrw1NlXSLsh5V3z1GNRuaIIyUwCENkX6eyy2b3kci
         qkGA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=lMKAtiDe;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=lMKAtiDe;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
X-Google-Smtp-Source: AH8x226oR7fA/51OkP8+/qr1ev1NujmByQb6HGBQfiuQVsU13wpfIimAWxVSMvEBy3QMKnaLqn2j8i24BN76K3PSw8o=
MIME-Version: 1.0
In-Reply-To: <CAG_66ZT6R2Ki3AnH6RWRXpd8d64NDR2y-0BwyqJRpQD4hD01oQ@mail.gmail.com>
References: <20180202154026.15298-1-robh@kernel.org> <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
 <CAL_JsqK+1Z_vuFE_po1VCxkSc112OFmgCiwM7F1S0mH6gw3KHQ@mail.gmail.com>
 <1517598363.7489.126.camel@perches.com> <CAG_66ZT6R2Ki3AnH6RWRXpd8d64NDR2y-0BwyqJRpQD4hD01oQ@mail.gmail.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 8 Feb 2018 15:41:43 +0100
Message-ID: <CAOFm3uGS-ZY5+dEf+TvBZQ-m9EpA9ZPEuHr1JXkvV+Sk=qri5w@mail.gmail.com>
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
To: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Joe Perches <joe@perches.com>, Rob Herring <robh@kernel.org>,
	Igor Stoppa <igor.stoppa@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591844215661375960?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kate,

On Fri, Feb 2, 2018 at 9:18 PM, Kate Stewart
<kstewart@linuxfoundation.org> wrote:
> This is the new way to represent GPLv2 only, as described above.
> While the GPL-2.0 and GPL-2.0+ notation is still valid,  it is deprecated
> in the latest version, so transitioning existing over time will probably
> be needed.   So I think the list of licenses to be added to
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
> OpenSSL

Yes, this is the new SPDX was (-only) but this is not yet the kernel
way and doc.

IMHO as long as the new SPDX "GPL-2.0-only" are not what is in the
kernel doc they should not be used and banned. Otherwise, we are
looking at creating an infinite source of confusion
therefore we should not add the -only license for now until they
become the kernel ways.
Joe already spotted drifts and I tried to fight these as much as I
could. One id for one license at a time is the only sane way to go.
-- 
Cordially
Philippe Ombredanne
