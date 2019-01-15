Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E598C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79F520675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547572270;
	bh=a9xy4sByCz1DY5yRD0Vke4DOBofnFf3cX0k66/2eB3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WABFenq6YSMRLFOvDZOq8fIwTAZy9i1cByqAAvrvlXHNl/DypFpc/SnSx9RTEH7v4
	 yGIglnGRuhvlJOvyYwocspylfME0/J+WPHQ4aC932BT+O4VSrPUfM5cYdN2dwzqSee
	 BctOLMUUQoyML532zF04XFtM1sgYLPWLjQYaxBIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732962AbfAORLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:11:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbfAORLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:11:05 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22DFE20645;
        Tue, 15 Jan 2019 17:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547572265;
        bh=a9xy4sByCz1DY5yRD0Vke4DOBofnFf3cX0k66/2eB3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eI8t1/iR5BesOS5qk8s0+BUuicBeNzm8TlhDQkmKd22MSlt8xofTCakttkZq4BR6K
         x/VZosWRHqC4ESwSC5gdzJCm1Go6pMyvifBMLgg/C4oU8nTq7m/ZXgjILo53KFk3HA
         G3T8rngWeK9x2KDYAb5X6toOgUmIcnQh2vrkWpuo=
Date:   Tue, 15 Jan 2019 18:10:55 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <marek.vasut@gmail.com>, <boris.brezillon@bootlin.co>,
        <richard@nod.at>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <miquel.raynal@bootlin.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add myself as SPI NOR co-maintainer
Message-ID: <20190115181038.2a670a4e@bbrezillon>
In-Reply-To: <20190115165740.32450-1-tudor.ambarus@microchip.com>
References: <20190115165740.32450-1-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

On Tue, 15 Jan 2019 16:57:52 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> I have been reviewing and contributing to the SPI NOR subsystem
> for the last few months and I'm willing to continue doing so.
> Volunteer as a maintainer for the SPI NOR part of the MTD subsystem.

I'll wait a bit before applying this patch to let other maintainers ack
or nack it if they want, but I must say that's a huge relief for me to
have a new person handling SPI NOR patches on board.

Thanks a lot for doing that.

Regards,

Boris

> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6682420421c1..7deb0e91e3ed 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14081,6 +14081,7 @@ F:	arch/arm/mach-spear/
>  
>  SPI NOR SUBSYSTEM
>  M:	Marek Vasut <marek.vasut@gmail.com>
> +M:	Tudor Ambarus <tudor.ambarus@microchip.com>
>  L:	linux-mtd@lists.infradead.org
>  W:	http://www.linux-mtd.infradead.org/
>  Q:	http://patchwork.ozlabs.org/project/linux-mtd/list/

