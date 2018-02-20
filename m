Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeBTKRd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:17:33 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:47090 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeBTKRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:17:32 -0500
X-Google-Smtp-Source: AH8x227eKsqp9QeQYlvllFZPf/oKAzkYOHS5z60mXA8lRygpEg3CTR9skgTR/eLmc+tykmeWDVUXcA==
Date: Tue, 20 Feb 2018 11:17:27 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jan Beulich <JBeulich@suse.com>
Cc: mingo@elte.hu, tglx@linutronix.de,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Subject: Re: [PATCH RESEND] x86: consider effective protection attributes in
 W+X check
Message-ID: <20180220101727.c4akak6cgoqbgn2y@gmail.com>
References: <5A8BDF3602000078001A96CD@prv-mh.provo.novell.com>
 <20180220081042.wgriecqneizg3df7@gmail.com>
 <5A8BE8C602000078001A9729@prv-mh.provo.novell.com>
 <20180220083731.kzkctvwvtc4qhrdi@gmail.com>
 <5A8BEDBE02000078001A9763@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A8BEDBE02000078001A9763@prv-mh.provo.novell.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Beulich <JBeulich@suse.com> wrote:

> >>> On 20.02.18 at 09:37, <mingo@kernel.org> wrote:
> 
> > * Jan Beulich <JBeulich@suse.com> wrote:
> > 
> >> I'll see what I can do; it's a pity that the change here, which had
> >> been sent weeks ago and is a bug fix, hadn't gone in before that
> >> other change (being more an improvement than a bug fix).
> > 
> > When was it submitted, got a link or Message-ID of the previous submission?
> 
> On Dec 12th (https://patchwork.kernel.org/patch/10106593/).

Indeed! There was a bit of a back and forth in the submission, with v2 and v3 
patches sent for the #1 patch, which combined with the whole Meltdown/PTI mess 
that was in overdrive during the holliday season just made us miss this...

Next time anything like this happens just ping the original thread and I'll pick 
it up. (But a resend is fine too, of course.)

I assume the Xen fix got merged meanwhile?

Thanks,

	Ingo
