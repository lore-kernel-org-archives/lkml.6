Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A83C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E56D20855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfBHPXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:23:45 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:36407 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfBHPXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:23:45 -0500
X-Originating-IP: 109.213.164.40
Received: from localhost (alyon-652-1-53-40.w109-213.abo.wanadoo.fr [109.213.164.40])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 275A140010;
        Fri,  8 Feb 2019 15:23:42 +0000 (UTC)
Date:   Fri, 8 Feb 2019 16:23:42 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: atmel: add new sam9x60 reset
 controller binding
Message-ID: <20190208152342.GB23062@piout.net>
References: <20190206181221.27914-1-nicolas.ferre@microchip.com>
 <20190206181221.27914-2-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206181221.27914-2-nicolas.ferre@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2019 19:12:20+0100, Nicolas Ferre wrote:
> Update the Reset Controller's binding to add new SoC compatibility string.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> v2: split series and collect tag
> 
>  Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> index dd7864f2bb2b..dfc91bc02b97 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
> @@ -22,6 +22,7 @@ Its subnodes can be:
>  RSTC Reset Controller required properties:
>  - compatible: Should be "atmel,<chip>-rstc".
>    <chip> can be "at91sam9260", "at91sam9g45", "sama5d3" or "samx7"
> +  it also can be "microchip,sam9x60-rstc"
>  - reg: Should contain registers location and length
>  - clocks: phandle to input clock.
>  
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
