Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC16CC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC8E20645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 16:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC8E20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeIGV1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 17:27:12 -0400
Received: from muru.com ([72.249.23.125]:55444 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbeIGV1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 17:27:12 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4AD1280CF;
        Fri,  7 Sep 2018 16:49:29 +0000 (UTC)
Date:   Fri, 7 Sep 2018 09:45:24 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] mtd: rawnand: ams-delta: Cleanups and
 optimizations
Message-ID: <20180907164524.GH5662@atomide.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
 <20180820213904.13475-1-jmkrzyszt@gmail.com>
 <20180905084757.432e7c19@xps13>
 <1855340.fVHtouTg44@z50>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1855340.fVHtouTg44@z50>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180905 20:56]:
> On Wednesday, September 5, 2018 8:47:57 AM CEST Miquel Raynal wrote:
> > Patch 2/3 does not apply on nand/next. Indeed the driver does not look
> > the same as in the diff.
> 
> That's because I built it on top of my former series from the mid of July, 
> containing "[PATCH v2 2/3 v4] mtd: rawnand: ams-delta: use GPIO lookup table". 
> It was acked by you, Miquel, and supposed to be merged via linux-omap tree.

Hmm I thought the plan was for dependencies to clear and then
merge the rest via various driver trees.. Or at least I don't have
the patch above tagged anywhere for me to merge. Then again, I
try to forget everything posted before -rc1 just to stay sane :)

> > I don't see any changes on my side that could
> > explain this so perhaps you could rebase on top of 4.19-rc2 (or
> > nand/next, as you wish) and resend the series?
> 
> As far as I can see, Tony hasn't applied that series yet, so maybe I can still 
> move that patch out of there and insert it into this series in front of the 
> other 3 patches and resend. That would however make patch 3/3 of that old 
> series depend on this one.
> 
> Tony, what do you think?

Yes please resend based on v4.19-rc1 or MTD next. If there
are still pending dependencies, please let us know and we can
set up an immutable branch against v4.19-rc1 with those for
MTD and me to merge in as needed.

Regards,

Tony
