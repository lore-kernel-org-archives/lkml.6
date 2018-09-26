Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BE5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA31206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA31206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeIZSnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:43:08 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44814 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbeIZSnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:43:08 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AAB51208B1; Wed, 26 Sep 2018 14:30:18 +0200 (CEST)
Received: from localhost (guest-nat.fw1.untrust.par1.mozilla.net [185.155.181.200])
        by mail.bootlin.com (Postfix) with ESMTPSA id 60258203DA;
        Wed, 26 Sep 2018 14:30:08 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        maxime.chevallier@bootlin.com, nadavh@marvell.com,
        thomas.petazzoni@bootlin.com, miquel.raynal@bootlin.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: marvell: armada-cp110: describe more PPv2 interrupts
References: <20180924090002.27939-1-antoine.tenart@bootlin.com>
        <20180924090002.27939-2-antoine.tenart@bootlin.com>
Date:   Wed, 26 Sep 2018 14:30:09 +0200
In-Reply-To: <20180924090002.27939-2-antoine.tenart@bootlin.com> (Antoine
        Tenart's message of "Mon, 24 Sep 2018 11:00:02 +0200")
Message-ID: <87bm8ke90u.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antoine,
 
 On lun., sept. 24 2018, Antoine Tenart <antoine.tenart@bootlin.com> wrote:

> This patch describes 3 additional interrupts per PPv2 port. Those
> interrupts will be used later in future versions of the Marvell PPv2
> driver, and now the device tree description matches the hardware
> capabilities.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 21 ++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> index 6a13690cf1e4..26d6e602d1ec 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> @@ -52,9 +52,14 @@
>  					<ICU_GRP_NSR 47 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 51 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 55 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 59 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 63 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 67 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 71 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 129 IRQ_TYPE_LEVEL_HIGH>;
>  				interrupt-names = "hif0", "hif1", "hif2",
> -					"hif3", "hif4", "link";
> +					"hif3", "hif4", "hif5", "hif6", "hif7",
> +					"hif8", "link";
>  				port-id = <0>;
>  				gop-port-id = <0>;
>  				status = "disabled";
> @@ -66,9 +71,14 @@
>  					<ICU_GRP_NSR 48 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 52 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 56 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 60 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 64 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 68 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 72 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 128 IRQ_TYPE_LEVEL_HIGH>;
>  				interrupt-names = "hif0", "hif1", "hif2",
> -					"hif3", "hif4", "link";
> +					"hif3", "hif4", "hif5", "hif6", "hif7",
> +					"hif8", "link";
>  				port-id = <1>;
>  				gop-port-id = <2>;
>  				status = "disabled";
> @@ -80,9 +90,14 @@
>  					<ICU_GRP_NSR 49 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 53 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 57 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 61 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 65 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 69 IRQ_TYPE_LEVEL_HIGH>,
> +					<ICU_GRP_NSR 73 IRQ_TYPE_LEVEL_HIGH>,
>  					<ICU_GRP_NSR 127 IRQ_TYPE_LEVEL_HIGH>;
>  				interrupt-names = "hif0", "hif1", "hif2",
> -					"hif3", "hif4", "link";
> +					"hif3", "hif4", "hif5", "hif6", "hif7",
> +					"hif8", "link";
>  				port-id = <2>;
>  				gop-port-id = <3>;
>  				status = "disabled";
> -- 
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
