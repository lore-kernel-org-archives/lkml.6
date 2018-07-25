Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA11C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812CD20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812CD20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbeGYRYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:24:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42053 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbeGYRYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:24:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F1AB02093C; Wed, 25 Jul 2018 18:12:20 +0200 (CEST)
Received: from localhost (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id A741C2073D;
        Wed, 25 Jul 2018 18:12:10 +0200 (CEST)
Date:   Wed, 25 Jul 2018 18:12:11 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Josh Wu <rainyfeeling@outlook.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: drop Wenyou Yang from Atmel NAND driver
 support
Message-ID: <20180725161211.GE3539@piout.net>
References: <20180725145628.6625-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725145628.6625-1-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2018 16:56:28+0200, Miquel Raynal wrote:
> Mails to wenyou.yang@microchip.com are not deliverable.
> Drop him as Microchip/Atmel NAND controller driver maintainer.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 07d1576fc766..1e7bbd5843f1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9345,7 +9345,6 @@ F:	drivers/media/platform/atmel/atmel-isc-regs.h
>  F:	devicetree/bindings/media/atmel-isc.txt
>  
>  MICROCHIP / ATMEL NAND DRIVER
> -M:	Wenyou Yang <wenyou.yang@microchip.com>
>  M:	Josh Wu <rainyfeeling@outlook.com>
>  L:	linux-mtd@lists.infradead.org
>  S:	Supported
> -- 
> 2.14.1
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
