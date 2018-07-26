Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97435C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BF520673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 23:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55BF520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbeG0Azw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 20:55:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49072 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731343AbeG0Azw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 20:55:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A31E5207F4; Fri, 27 Jul 2018 01:36:45 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id DA95520618;
        Fri, 27 Jul 2018 01:36:34 +0200 (CEST)
Date:   Fri, 27 Jul 2018 01:36:34 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
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
Message-ID: <20180727013634.74f87455@xps13>
In-Reply-To: <20180725192805.GF3539@piout.net>
References: <20180725145628.6625-1-miquel.raynal@bootlin.com>
        <20180725203823.19a56d23@bbrezillon>
        <20180725192805.GF3539@piout.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Alexandre Belloni <alexandre.belloni@bootlin.com> wrote on Wed, 25 Jul
2018 21:28:05 +0200:

> On 25/07/2018 20:38:23+0200, Boris Brezillon wrote:
> > On Wed, 25 Jul 2018 16:56:28 +0200
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >   
> > > Mails to wenyou.yang@microchip.com are not deliverable.
> > > Drop him as Microchip/Atmel NAND controller driver maintainer.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  MAINTAINERS | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 07d1576fc766..1e7bbd5843f1 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -9345,7 +9345,6 @@ F:	drivers/media/platform/atmel/atmel-isc-regs.h
> > >  F:	devicetree/bindings/media/atmel-isc.txt
> > >  
> > >  MICROCHIP / ATMEL NAND DRIVER
> > > -M:	Wenyou Yang <wenyou.yang@microchip.com>
> > >  M:	Josh Wu <rainyfeeling@outlook.com>  
> > 
> > Hm, actually you can remove the entry completely. I doubt Josh will
> > keep maintaining this driver since he's no longer working at Microchip.
> >   
> 
> I think Nicolas' plan is to replace Wenyou so the entry may stay

Patch applied to nand/next to avoid receiving delivery errors.

We'll wait for Nicolas' input to replace Josh.

Thanks,
Miquèl
