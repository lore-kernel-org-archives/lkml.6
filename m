Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2BEC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2999320843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 19:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2999320843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbeGYUlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 16:41:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46632 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729456AbeGYUlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 16:41:14 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 48BF62074F; Wed, 25 Jul 2018 21:28:08 +0200 (CEST)
Received: from localhost (unknown [88.128.82.24])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9F3E420732;
        Wed, 25 Jul 2018 21:28:07 +0200 (CEST)
Date:   Wed, 25 Jul 2018 21:28:05 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: drop Wenyou Yang from Atmel NAND driver
 support
Message-ID: <20180725192805.GF3539@piout.net>
References: <20180725145628.6625-1-miquel.raynal@bootlin.com>
 <20180725203823.19a56d23@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725203823.19a56d23@bbrezillon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2018 20:38:23+0200, Boris Brezillon wrote:
> On Wed, 25 Jul 2018 16:56:28 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Mails to wenyou.yang@microchip.com are not deliverable.
> > Drop him as Microchip/Atmel NAND controller driver maintainer.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  MAINTAINERS | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 07d1576fc766..1e7bbd5843f1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9345,7 +9345,6 @@ F:	drivers/media/platform/atmel/atmel-isc-regs.h
> >  F:	devicetree/bindings/media/atmel-isc.txt
> >  
> >  MICROCHIP / ATMEL NAND DRIVER
> > -M:	Wenyou Yang <wenyou.yang@microchip.com>
> >  M:	Josh Wu <rainyfeeling@outlook.com>
> 
> Hm, actually you can remove the entry completely. I doubt Josh will
> keep maintaining this driver since he's no longer working at Microchip.
> 

I think Nicolas' plan is to replace Wenyou so the entry may stay

> >  L:	linux-mtd@lists.infradead.org
> >  S:	Supported
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
