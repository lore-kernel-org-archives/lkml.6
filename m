Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2165EC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3D42590D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3D42590D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933884AbeFYMb0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:31:26 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46418 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933288AbeFYMbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:31:23 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9C9A420719; Mon, 25 Jun 2018 14:31:21 +0200 (CEST)
Received: from xps13 (AAubervilliers-681-1-87-188.w90-88.abo.wanadoo.fr [90.88.29.188])
        by mail.bootlin.com (Postfix) with ESMTPSA id 42088203D9;
        Mon, 25 Jun 2018 14:31:21 +0200 (CEST)
Date:   Mon, 25 Jun 2018 14:31:21 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Peter Rosin <peda@axentia.se>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wenyou Yang <wenyou.yang@microchip.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
Message-ID: <20180625143121.0104a671@xps13>
In-Reply-To: <20180618103908.17a04679@bbrezillon>
References: <20180329131054.22506-1-peda@axentia.se>
 <20180618103908.17a04679@bbrezillon>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, 18 Jun 2018 10:39:08 +0200, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:

> On Thu, 29 Mar 2018 15:10:54 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
> > On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
> > flash accesses have a tendency to cause display disturbances. Add a
> > module param to disable DMA from the NAND controller, since that fixes
> > the display problem for me.
> > 
> > Signed-off-by: Peter Rosin <peda@axentia.se>  
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> 
> Miquel, can you queue this one to nand/next.
> 

Applied to nand/next with the prefix changed to "mtd: rawnand: atmel:".

Thanks,
Miquèl
