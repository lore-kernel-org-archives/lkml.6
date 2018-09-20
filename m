Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8958DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3880621532
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3880621532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388482AbeIUCnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 22:43:32 -0400
Received: from muru.com ([72.249.23.125]:56658 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727680AbeIUCnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 22:43:31 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 933AA8105;
        Thu, 20 Sep 2018 21:02:23 +0000 (UTC)
Date:   Thu, 20 Sep 2018 13:58:05 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] ARM: OMAP1: ams-delta: Complete driver gpiod
 migration
Message-ID: <20180920205805.GQ5662@atomide.com>
References: <20180717231448.14958-1-jmkrzyszt@gmail.com>
 <20180909225605.16463-1-jmkrzyszt@gmail.com>
 <1794253.R1RrZXVNCJ@z50>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1794253.R1RrZXVNCJ@z50>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Janusz Krzysztofik <jmkrzyszt@gmail.com> [180919 18:13]:
> On Monday, September 10, 2018 12:56:02 AM CEST Janusz Krzysztofik wrote:
> > 
> > This is a follow up of initial submission of a series consisted of 
> > 6 changes, 3 of which have been already applied or reworkeed.
> > 
> > 
> > Janusz Krzysztofik (3):
> >       video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup table
> >       mtd: rawnand: ams-delta: use GPIO lookup table
> 
> Hi Tony,
> 
> Please ignore this patch. It may no longer be possible to merged it cleanly 
> with nand/next tree. I'll exclude it from the series, rebase on top of nand/
> next and submit via linux-mtd.

OK sounds good to me.

> That shouldn't affect the two remaining patches of the series which should 
> still apply and merge cleanly, but I can resend them renumbered if you wish.

Up to the mtd and fb folks as far as I'm concerned :)

Regards,

Tony
