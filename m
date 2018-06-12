Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DFF2CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFE4208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFE4208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934571AbeFLVyS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:54:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42996 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933793AbeFLVyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:54:17 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fSrEx-0005C3-Dg; Tue, 12 Jun 2018 23:54:11 +0200
Date:   Tue, 12 Jun 2018 23:54:11 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas =?utf-8?Q?Gr=C3=BCnbacher?= 
        <andreas.gruenbacher@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, quilt-dev@nongnu.org
Subject: Re: [PATCH 0/3] sched/swait: Convert to full exclusive mode
Message-ID: <20180612215411.wcma6o7zd6cbytkk@linutronix.de>
References: <20180612083449.100099222@infradead.org>
 <CA+55aFzLNFO1za9-Lb=jxO_F9NS0jZyti+we=ycr5NTpgzdEbw@mail.gmail.com>
 <CAHpGcMJSb4pqWF7X3K7yrk+N=FwcSrbjWm9xvprpaLRGgdE24A@mail.gmail.com>
 <CA+55aFx81igOjFZcvO03mvDFd3=pxsq2QuNrWrPW+4pvJy780A@mail.gmail.com>
 <alpine.DEB.2.21.1806122134410.1592@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806122134410.1592@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-12 21:43:48 [+0200], Thomas Gleixner wrote:
> > Also, note that I'm not at all sure that it's _just_ the
> > 
> >     Content-Disposition: inline
> > 
> > that triggers this. There might be something else in those emails that
> > triggers it but that's the thing that stands out.
> 
> It is. There is nothing else in the headers which could cause that. quilt
> mail format is pretty simplistic.

mutt sets this and the tip-bot, too. The difference is that quilt also
sets the filename parameter. Do the mutt or tip-bot mails look flowed?

> Thanks,
> 
> 	tglx

Sebastian
