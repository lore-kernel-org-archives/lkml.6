Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4545EECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098B020883
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 098B020883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbeGML6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:58:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58319 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbeGML6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:58:42 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 36C2B2074F; Fri, 13 Jul 2018 13:44:22 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0D6C920714;
        Fri, 13 Jul 2018 13:44:22 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net, andrew@lunn.ch,
        jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, oferh@marvell.com,
        igall@marvell.com
Subject: Re: [PATCH 13/14] arm64: dts: marvell: armada-cp110: update the crypto engine compatible
References: <20180628151544.22134-1-antoine.tenart@bootlin.com>
        <20180628151544.22134-14-antoine.tenart@bootlin.com>
Date:   Fri, 13 Jul 2018 13:44:22 +0200
In-Reply-To: <20180628151544.22134-14-antoine.tenart@bootlin.com> (Antoine
        Tenart's message of "Thu, 28 Jun 2018 17:15:43 +0200")
Message-ID: <87muuvbbs9.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antoine,
 
 On jeu., juin 28 2018, Antoine Tenart <antoine.tenart@bootlin.com> wrote:

> New compatibles are now supported by the Inside Secure SafeXcel driver.
> As they are more specific than the old ones, they should be used
> whenever possible. This patch updates the Marvell cp110 device tree
> accordingly.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> index 2bf083272a87..bb2914f90048 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> @@ -427,7 +427,7 @@
>  		};
>  
>  		CP110_LABEL(crypto): crypto@800000 {
> -			compatible = "inside-secure,safexcel-eip197";
> +			compatible = "inside-secure,safexcel-eip197b";
>  			reg = <0x800000 0x200000>;
>  			interrupts = <ICU_GRP_NSR 87 IRQ_TYPE_LEVEL_HIGH>,
>  				<ICU_GRP_NSR 88 IRQ_TYPE_LEVEL_HIGH>,
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
