Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED572C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C505721841
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 16:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeLRQJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 11:09:58 -0500
Received: from mail.bootlin.com ([62.4.15.54]:36697 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbeLRQJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 11:09:58 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 190E220BE1; Tue, 18 Dec 2018 17:09:56 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id DEBE32072C;
        Tue, 18 Dec 2018 17:09:45 +0100 (CET)
Date:   Tue, 18 Dec 2018 17:09:45 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] MAINTAINERS: Add a maintainer for MSCC MIPS
 SoCs
Message-ID: <20181218160945.GF19816@piout.net>
References: <20181218160750.6766-1-alexandre.belloni@bootlin.com>
 <20181218160750.6766-2-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218160750.6766-2-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this, it was meant for the MIPS maintainers.

On 18/12/2018 17:07:47+0100, Alexandre Belloni wrote:
> Microsemi has been bought by Microchip and Microchip is supporting those
> SoCs.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f4855974f325..50223cba6ddb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9801,8 +9801,9 @@ F:	drivers/dma/at_xdmac.c
>  
>  MICROSEMI MIPS SOCS
>  M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
> +M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
>  L:	linux-mips@linux-mips.org
> -S:	Maintained
> +S:	Supported
>  F:	arch/mips/generic/board-ocelot.c
>  F:	arch/mips/configs/generic/board-ocelot.config
>  F:	arch/mips/boot/dts/mscc/
> -- 
> 2.20.0
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
