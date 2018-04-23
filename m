Return-Path: <mchehab@s-opensource.com>
X-Google-Smtp-Source: AIpwx48zMiIALqYVP3S6PU2eFWUECt++7cd1HJAfvuLg4XI+kozex7Gm7UbvSKrgcLQwSThFhGjX
ARC-Seal: i=1; a=rsa-sha256; t=1524478506; cv=none;
        d=google.com; s=arc-20160816;
        b=hdWnMc+UBcq2hp9PiunQVonvJwsFjmPToYGWsE7gE4QKKogzkSSCNgpUBvxEbBYCiG
         KtL9LWWUqjVUJrc4lM7Dyu1ONTt6a6N2e5I3V1btAPM4bkXpv/v0GPODlNYBnKmrxMyn
         7Be6F3AK6J+qbzxTeyAcQpjpO4xdkppe0zBhYmsAIDFJBnkw83Q5nXyg5bElQBuUeJBj
         s/IXQL7ji1ZOZo1Hfmx4Z0RxuguXlwUgH1zYEMR6wKChZVmpA+HtAHDNukaDiICWz6+l
         wgWuJsCGuTukrPcB5mzJLXxZaKSDZgbnmRGRqCtVwUj5NHjXkPngZYfZtlVk/BGsQtc6
         x6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=TuDi6I/YO6KoRttYaHsBqR66KtbTO/cFg4EFDNCgn3E=;
        b=ozM8MEKpk8L7UJakKj/9JCkx9epWtvTFidS1ivA84fgxCI79G+fGGJXJ5Ihf/UHAg9
         IUP3IRTgOtzyQicjjkON3naCGYSN8NYpbY4fs75qNUWyJFlDzbXkY78EysaKcLNk0cLT
         ThPZIZVkcFrzrmJ0yqk84xBASnDjOgZK1+tjINtbbXsnGtZ6594P+BEYpQWBScGhVgR2
         bZAIM9gu8qNfMy+pwy5jDjtHvx+17IzJ6hq+hzhFylt1Jn4o/prHlqYHZ9D9THdMgU8x
         a13D7OJLhxehv8XIGZD/xSfTg1LpdN3CL338wdNXj9lYKJRFmei13GcFwOtpErLEkybr
         15RA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@s-opensource.com) smtp.mailfrom=mchehab@s-opensource.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 64.30.133.232 is neither permitted nor denied by best guess record for domain of mchehab@s-opensource.com) smtp.mailfrom=mchehab@s-opensource.com
Date: Mon, 23 Apr 2018 07:14:53 -0300
From: Mauro Carvalho Chehab <mchehab@s-opensource.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>, Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, Jonathan Corbet
 <corbet@lwn.net>, Hans Verkuil <hans.verkuil@cisco.com>
Subject: Re: [patch 4/9] LICENSES/GPL2.0: Add GPL-2.0-only/or-later as valid
 identifiers
Message-ID: <20180423071453.25deeb48@vento.lan>
In-Reply-To: <20180423065229.GD4208@kroah.com>
References: <20180422220208.772527041@linutronix.de>
	<20180422220833.078058446@linutronix.de>
	<20180423065229.GD4208@kroah.com>
Organization: Samsung
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486097354490733?=
X-GMAIL-MSGID: =?utf-8?q?1598531574543609603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Mon, 23 Apr 2018 08:52:29 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Mon, Apr 23, 2018 at 12:02:12AM +0200, Thomas Gleixner wrote:
> > Quite some files have been flagged with the new GPL-2.0-only and
> > GPL-2.0-or-later identifiers which replace the original GPL-2.0 and
> > GPL-2.0+ identifiers in the SPDX license identifier specification, but the
> > identifiers are not mentioned as valid in the GPL-2.0 license file.
> > 
> > Add them to make everything consistent again.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Hans Verkuil <hans.verkuil@cisco.com>
> > Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>  
> 
> As much as I dislike the "new" identifiers, I guess trying to hold them
> back is a pointless exercise :(

Well, it is part of the SPDX spec, so it should be valid, no matter
of personal tastes.

I'd say that we should clearly point what SPDX version is preferred at:
	Documentation/process/license-rules.rst

And, if we adopt version 3.0, change the described license tags
accordingly, as the tags showed there are for some pre-version 3.0
SPDX version (but the file doesn't mention if it follows SPDX version
1.0, 1.1, 1.2, 2.0 or 2.1).

Anyway, for this specific patch:

Reviewed-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>


Thanks,
Mauro
