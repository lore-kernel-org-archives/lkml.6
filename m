Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF93C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD4C20645
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfAHSOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:14:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50246 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfAHSOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:14:17 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5D58C2078F; Tue,  8 Jan 2019 19:14:15 +0100 (CET)
Received: from localhost (alyon-652-1-61-72.w109-213.abo.wanadoo.fr [109.213.84.72])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2A37C2074F;
        Tue,  8 Jan 2019 19:14:15 +0100 (CET)
Date:   Tue, 8 Jan 2019 19:14:15 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Tudor.Ambarus@microchip.com
Cc:     Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Claudiu.Beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-mtd@lists.infradead.org,
        broonie@kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: at91: at91-sama5d27_som1: add QSPI1 + SPI
 NOR memory nodes
Message-ID: <20190108181415.GE10218@piout.net>
References: <20181212163057.22183-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212163057.22183-1-tudor.ambarus@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2018 16:31:08+0000, Tudor.Ambarus@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>
> 
> Configure the QSPI1 controller pin muxing and declare the
> jedec,spi-nor memory (SST26VF064).
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> [tudor.ambarus@microchip.com: add spi-rx/tx-bus-width, drop partitions,
> reword commit.]
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sama5d27_som1.dtsi | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
