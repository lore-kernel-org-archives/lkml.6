Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A812C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173362081B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732383AbfBLVOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:14:51 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:52499 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfBLVOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:14:51 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 2DA7E1BF20F;
        Tue, 12 Feb 2019 21:14:48 +0000 (UTC)
Date:   Tue, 12 Feb 2019 22:14:47 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Subject: Re: linux-next: manual merge of the rtc tree with the clk tree
Message-ID: <20190212211447.GB10129@piout.net>
References: <20190211161731.56897159@canb.auug.org.au>
 <155000535897.115909.9366893166102514791@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155000535897.115909.9366893166102514791@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen and Stephen,

On 12/02/2019 13:02:38-0800, Stephen Boyd wrote:
> Quoting Stephen Rothwell (2019-02-10 21:17:31)
> > Hi all,
> > 
> > Today's linux-next merge of the rtc tree got a conflict in:
> > 
> >   drivers/clk/at91/sama5d2.c
> > 
> > between commit:
> > 
> >   77977b800451 ("clk: at91: enable AUDIOPLL as source for PCKx on SAMA5D2")
> > 
> > from the clk tree and commit:
> > 
> >   34d2ff2a6019 ("clk: at91: fix masterck name")
> > 
> > from the rtc tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> > 
> 
> Thanks. Looks good to me.

Actually, that was my mistake and I removed it from the RTC tree. I'm
really intending for "clk: at91: fix masterck name" to go through the
clk tree. I simply forgot to remove the patch from this branch after
testing it...

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
