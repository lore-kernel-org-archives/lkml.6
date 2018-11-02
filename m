Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7090AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D622081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 17:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D622081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeKCCxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 22:53:21 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44439 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeKCCxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 22:53:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B97D9207CF; Fri,  2 Nov 2018 18:45:20 +0100 (CET)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6DF8420736;
        Fri,  2 Nov 2018 18:45:20 +0100 (CET)
Date:   Fri, 2 Nov 2018 18:45:18 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, wsa@the-dreams.de,
        Vitor.Soares@synopsys.com, pgaj@cadence.com, rafalc@cadence.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Addition of the I3C subsystem in 4.20 (5.0)?
Message-ID: <20181102184518.60531378@bbrezillon>
In-Reply-To: <CAHk-=wg3r8QmJGKep9PK-8o3HM1-4aJJqQKsGaZJAk93Ad1pNw@mail.gmail.com>
References: <20181101063523.26bdbe28@bbrezillon>
        <CAHk-=wg3r8QmJGKep9PK-8o3HM1-4aJJqQKsGaZJAk93Ad1pNw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On Thu, 1 Nov 2018 09:27:20 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Oct 31, 2018 at 10:35 PM Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> >
> > Greg, I didn't get your feedback on v10 of the i3c patchset [1] where I
> > was asking if you'd agree to have this framework merged in 4.20 (I know
> > you were busy with the 4.19 release and after that the Kernel Summit, so
> > that's not a surprise), so I'm sending this PR. It's really not an attempt
> > to bypass you, more like a ping that, if positively acknowledged, might
> > lead to inclusion of the I3C framework in 4.20 (5.0?) :-).
> 
> Regardless of any other issues, this is now too late in the merge
> window for me to accept.
> 
> Yes, the merge window is two weeks, but that's not because people
> should send me pull requests for two weeks. A large part of it is that
> it takes time to merge stuff, and I want to have time in the later
> part of the merge window for things I have to look at and ponder.

Ok, I didn't know that.

> 
> So that's why I want new stuff to be ready *before* the merge window,
> and I want to see the actual pull requests early. The two weeks is not
> for development and to let people delay things a bit, it's to make it
> possible to synchronize and to work out issues.

Noted, and sorry for the inconvenience.

Regards,

Boris
