Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx48ofGsvqje2CCw+U+rvfQOlusirtYax8BSipMf2NxIIizBA4oMQLUaaR8HaaSEU5IXPX6b+
ARC-Seal: i=1; a=rsa-sha256; t=1524556888; cv=none;
        d=google.com; s=arc-20160816;
        b=E077NcRejyr9WuKxzdXUax0LUm1iEwRyEbidd6PIwA2xVhXcA0ykNjrOI4dibVa6mJ
         T4sGGF6OGgSSrLfwO00Kxj873YMtXaRiAQPZadGhH8ObS5qMfeauOW6Y+gdoSHBK4Q2K
         tDSdHM/zLXQ+dqgS+rTjcRNaEMGtnCshoF0S2PSR//C+4f+PFDVfwvVmPGRJFubhYhlY
         HjCOKJq7lIhtTPZEGW7dyDrbYj0TGN7d38Wob5ZJOUbDVqpI1aZW8an44oPCLuBw+88v
         6DMcfE+pXYtJfdTpdDKH3m6dMk9Z2avgiMhjP6N3NnbebWfOo4k8jqhEkDTS8klj5bi/
         SHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=TxVf5mpwU3x4tCvhc0lLx0Kw7hI702prvtXFWna24U0=;
        b=plVP/QWxQ8A2rU719t+vfCz+GOO83rR0PFwMumpOLedJZpsIPFnJcz24J9zctQ6kX/
         /Ym7ajGAbmak3fw/7EiKWiyY6+MKh9/qbIpCI96eopvpzvgL+H+S8X7blhNO9/y/9xwJ
         rEEy0G7bA30j4/N6L1vnm8NKXIQX48AHEzxDpfzc7R4ErfrvdV3SheIYovWYIvpsleMP
         PrAC+kKKtvM656t2Fsb+TEysQStGRfYCJnTA/rH1FXgu6HzS3D8O6gySTejpJ0iF+UCb
         twLFvQ9ouBwKd5YAAhgJRf2OsB/oDAjhsrzeOYoY4mNkNjWK09JTLa7A2YbL2N+3yFZj
         XDsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Tue, 24 Apr 2018 10:01:22 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    LKML <linux-kernel@vger.kernel.org>,
    Philippe Ombredanne <pombredanne@nexb.com>,
    Kate Stewart <kstewart@linuxfoundation.org>,
    Jonathan Corbet <corbet@lwn.net>, Hans Verkuil <hans.verkuil@cisco.com>
Subject: Re: [patch 4/9] LICENSES/GPL2.0: Add GPL-2.0-only/or-later as valid
 identifiers
In-Reply-To: <20180423071453.25deeb48@vento.lan>
Message-ID: <alpine.DEB.2.21.1804240953460.5261@nanos.tec.linutronix.de>
References: <20180422220208.772527041@linutronix.de> <20180422220833.078058446@linutronix.de> <20180423065229.GD4208@kroah.com> <20180423071453.25deeb48@vento.lan>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486097354490733?=
X-GMAIL-MSGID: =?utf-8?q?1598613763779053867?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 23 Apr 2018, Mauro Carvalho Chehab wrote:
> Em Mon, 23 Apr 2018 08:52:29 +0200
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:
> 
> > On Mon, Apr 23, 2018 at 12:02:12AM +0200, Thomas Gleixner wrote:
> > > Quite some files have been flagged with the new GPL-2.0-only and
> > > GPL-2.0-or-later identifiers which replace the original GPL-2.0 and
> > > GPL-2.0+ identifiers in the SPDX license identifier specification, but the
> > > identifiers are not mentioned as valid in the GPL-2.0 license file.
> > > 
> > > Add them to make everything consistent again.
> > > 
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Hans Verkuil <hans.verkuil@cisco.com>
> > > Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>  
> > 
> > As much as I dislike the "new" identifiers, I guess trying to hold them
> > back is a pointless exercise :(
> 
> Well, it is part of the SPDX spec, so it should be valid, no matter
> of personal tastes.
> 
> I'd say that we should clearly point what SPDX version is preferred at:
> 	Documentation/process/license-rules.rst
> 
> And, if we adopt version 3.0, change the described license tags
> accordingly, as the tags showed there are for some pre-version 3.0
> SPDX version (but the file doesn't mention if it follows SPDX version
> 1.0, 1.1, 1.2, 2.0 or 2.1).

We need to grab the new version anyway due to the new Linux-OpenIB
license ID.

And we can document that the new -only and -or-later versions are
preferred, but should we really patch thousands of files just to update the
IDs?

I don't think so, SPDX better get their act together and mark them as
equivalent.

Thanks,

	tglx
