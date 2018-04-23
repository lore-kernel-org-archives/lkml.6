Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AIpwx4+fyYHr4IGvQDX+Km2FTkdqCR6OXvGwDob1uApuYa2IzWU7/ixmgD5mg2G/1UXI8VIpN+BU
ARC-Seal: i=1; a=rsa-sha256; t=1524469037; cv=none;
        d=google.com; s=arc-20160816;
        b=Ej6/VaVNZ5fpkfHbGAQf8kKIOwY+69ADJ3CkzpOHGi+6tNjB8XglP0mvA6xMyRLtet
         uO7L4FxV1pAQNKrPtloDjpz8VhnzvV/4hvbjo87Q6FkLDdno9nsvgstXbsY/DQx/to2l
         Ap+5C85PavXt9dXHPDvysxUzRxn02OPbeO8IqDmguBdVZtLsASkCHZI/9JFEA5wXgyCv
         bB4cO3rP4iX/xxVoUCD9dl0umYzGGL5cHTEASAYx1KeyfV3lHzYu0e0rsgrawXW4RZDl
         L/RBAnfVi/OOhD22KvUhN3g17XSyvVTb76Q4RHsi82sIMUm/gSUC5W5tV1dMIGJD00mI
         u/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=xwKC8M0UEulOJrVy+WRje/C907EFrXNxD0kmHZky6b0=;
        b=voe5qhbj+FmXknnkVokO7NQsPJx6KzpXZ32DSP99F3Bssp/46Xx/Mvq40Fi+40WdBP
         hp2BUeB8+bKah5rW4ld+PsT/C8uiJTP8H7yock6pMK2OPv9LE5sQke8czEk8Wm03CeOs
         Ly4Ji12oHepREaGPggm3lx5eNjv9+yEv1ZEXABG8FTwXRy3GljEDDqlVJVaWTqHroFgP
         gbs2nAtoeOo2REux0zOYBgj2/dRhufj//7mTi9gx/PJi4GetRtoCz2KgVBNXcLcMDwdz
         G9WQjvit7/i5uSQP6nTcKD9iW7caO8zFNAw+R6PHrVoZajDa97ybqejUZAuUeOJYsjja
         W9XQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Date: Mon, 23 Apr 2018 09:37:14 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Matthew Wilcox <mawilcox@microsoft.com>,
    LKML <linux-kernel@vger.kernel.org>,
    Philippe Ombredanne <pombredanne@nexb.com>,
    Kate Stewart <kstewart@linuxfoundation.org>,
    Jonathan Corbet <corbet@lwn.net>
Subject: Re: [patch 8/9] LICENSES: Add CC-BY-SA-4.0 license text
In-Reply-To: <20180423065449.GE4208@kroah.com>
Message-ID: <alpine.DEB.2.21.1804230936290.6136@nanos.tec.linutronix.de>
References: <20180422220208.772527041@linutronix.de> <20180422220833.423253901@linutronix.de> <20180423065449.GE4208@kroah.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598486100220980492?=
X-GMAIL-MSGID: =?utf-8?q?1598521645239304327?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 23 Apr 2018, Greg Kroah-Hartman wrote:
> On Mon, Apr 23, 2018 at 12:02:16AM +0200, Thomas Gleixner wrote:
> > Add the full text of the CC-BY-SA-4.0 license to the kernel tree.  It was
> > copied directly from:
> >     
> >    https://spdx.org/licenses/CC-BY-SA-4.0.html#licenseText
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> As we only have 1 user of this, do we really need it?
> 
> Willy, it's your file, Documentation/core-api/idr.rst that is needing
> this addition to the LICENSES directory.  While I'm all for CC licenses
> for Documentation, we don't seem to be very consistent with them.
> Should this be the "default" license we choose for documentation for now
> on?

I'm all for it. If we can agree than this should move to preferred/ and not
to other/

Thanks,

	tglx
