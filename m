Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EB8ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDE620883
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDE620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbeGML66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:58:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58333 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727283AbeGML66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:58:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 664822074F; Fri, 13 Jul 2018 13:44:37 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 3A97120714;
        Fri, 13 Jul 2018 13:44:37 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net, andrew@lunn.ch,
        jason@lakedaemon.net, sebastian.hesselbarth@gmail.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, oferh@marvell.com,
        igall@marvell.com
Subject: Re: [PATCH 14/14] arm64: dts: marvell: armada-37xx: update the crypto engine compatible
References: <20180628151544.22134-1-antoine.tenart@bootlin.com>
        <20180628151544.22134-15-antoine.tenart@bootlin.com>
Date:   Fri, 13 Jul 2018 13:44:34 +0200
In-Reply-To: <20180628151544.22134-15-antoine.tenart@bootlin.com> (Antoine
        Tenart's message of "Thu, 28 Jun 2018 17:15:44 +0200")
Message-ID: <87in5jbbrx.fsf@bootlin.com>
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
> whenever possible. This patch updates the Marvell Armada 37xx device
> tree accordingly.
>
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Applied on mvebu/dt64

Thanks,

Gregory


> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index 3353252d78a0..2d68614aa66c 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -287,7 +287,7 @@
>  			};
>  
>  			crypto: crypto@90000 {
> -				compatible = "inside-secure,safexcel-eip97";
> +				compatible = "inside-secure,safexcel-eip97ies";
>  				reg = <0x90000 0x20000>;
>  				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
