Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AA3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81A120656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388727AbfAOSPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 13:15:23 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:47516 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731103AbfAOSPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 13:15:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BC29E609184F;
        Tue, 15 Jan 2019 19:15:20 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Mnvm_0SL_pbg; Tue, 15 Jan 2019 19:15:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 416356091846;
        Tue, 15 Jan 2019 19:15:20 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GlPebqkx72QV; Tue, 15 Jan 2019 19:15:20 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id BA6F7608A396;
        Tue, 15 Jan 2019 19:15:19 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Tudor.Ambarus@microchip.com
Cc:     marek.vasut@gmail.com, boris.brezillon@bootlin.co,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add myself as SPI NOR co-maintainer
Date:   Tue, 15 Jan 2019 19:15:19 +0100
Message-ID: <8417216.IRI4OqamiK@blindfold>
In-Reply-To: <20190115165740.32450-1-tudor.ambarus@microchip.com>
References: <20190115165740.32450-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 15. Januar 2019, 17:57:52 CET schrieb Tudor.Ambarus@microchip.com:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> I have been reviewing and contributing to the SPI NOR subsystem
> for the last few months and I'm willing to continue doing so.
> Volunteer as a maintainer for the SPI NOR part of the MTD subsystem.
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

Nice to have you on board! :-)

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard



