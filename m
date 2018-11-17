Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FA2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95A02080F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 14:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95A02080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeKRBNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 20:13:10 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41562 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRBNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 20:13:09 -0500
Received: by mail-ot1-f68.google.com with SMTP id u16so23685647otk.8;
        Sat, 17 Nov 2018 06:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MaovVDU9suPGhRw9MjYAV8PfTX89FW9K+ma72kiSakQ=;
        b=nml5i8q0WJsFLwmClBlCUB+TYRY3PDdTbOQOoOp1xF30HkFP8XeEqy41oMTIywnEAn
         JZ4R9eJlF+qoM9mZMR12pMlkCxhR4XFXxQIvw2JW7NyBewj4F8ULDVxmjjsLx5hzo3H4
         CiPdTVlviIho8ZuunRBxxR4Uvx5yA2UL5XHsEz+EkD97YcgU1uvPgrG+ZL1tjfUbiDat
         +JkG+4n2jRw+IHbci6/cKOHhbDPL5WAk7VQ0Hb1/zQA+SBQcvLuc24rfyasGOygLv5wp
         dUJhgflxiMnhFmaMq5ARWuvORAm0YY+ho2Wz8YEHA23fhxZuN++jqaJU+lcCnJTWhsNn
         DN1Q==
X-Gm-Message-State: AGRZ1gLTlecBsZgy2F/eJrZZpeVNs90S9/atSrNH0GQDUuGqXt9PHDVK
        WrtlTMWN7ahvmWXCQBLiPg==
X-Google-Smtp-Source: AJdET5eQEwxbTKnj1HyY1sWLtqabJOA5qufvVLBaMgBfK0lSPOSdHdq1CUYvrWBHz8bxh7BGSCFI7g==
X-Received: by 2002:a9d:4682:: with SMTP id z2mr8825693ote.104.1542466573814;
        Sat, 17 Nov 2018 06:56:13 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id d71sm1201221oic.7.2018.11.17.06.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 06:56:12 -0800 (PST)
Date:   Sat, 17 Nov 2018 08:56:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     davem@davemloft.net, honghui.zhang@mediatek.com,
        yt.shen@mediatek.com, liguo.zhang@mediatek.com,
        mark.rutland@arm.com, nelson.chang@mediatek.com,
        matthias.bgg@gmail.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, joabreu@synopsys.com,
        andrew@lunn.ch
Subject: Re: [v3, PATCH 2/2] dt-binding: mediatek-dwmac: add binding document
 for MediaTek MT2712 DWMAC
Message-ID: <20181117145611.GA26013@bogus>
References: <1542359926-28800-1-git-send-email-biao.huang@mediatek.com>
 <1542359926-28800-2-git-send-email-biao.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542359926-28800-2-git-send-email-biao.huang@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 05:18:46PM +0800, Biao Huang wrote:
> The commit adds the device tree binding documentation for the MediaTek DWMAC
> found on MediaTek MT2712.
> 
> Change-Id: I3728666bf65927164bd82fa8dddb90df8270bd44
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> ---
>  .../devicetree/bindings/net/mediatek-dwmac.txt     |   77 ++++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.txt b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> new file mode 100644
> index 0000000..7fd56e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> @@ -0,0 +1,77 @@
> +MediaTek DWMAC glue layer controller
> +
> +This file documents platform glue layer for stmmac.
> +Please see stmmac.txt for the other unchanged properties.
> +
> +The device node has following properties.
> +
> +Required properties:
> +- compatible:  Should be "mediatek,mt2712-gmac" for MT2712 SoC
> +- reg:  Address and length of the register set for the device
> +- interrupts:  Should contain the MAC interrupts

How many?

> +- interrupt-names: Should contain a list of interrupt names corresponding to
> +	the interrupts in the interrupts property, if available.
> +	Should be "macirq" for the main MAC IRQ
> +- clocks: Must contain a phandle for each entry in clock-names.
> +- clock-names: The name of the clock listed in the clocks property. These are
> +	"axi", "apb", "mac_ext", "mac_parent", "ptp_ref", "ptp_parent", "ptp_top"
> +	for MT2712 SoC

Clocks should represent the physical clocks connected to a block. Parent 
clocks are not in that category.

> +- mac-address: See ethernet.txt in the same directory
> +- phy-mode: See ethernet.txt in the same directory
> +
> +Optional properties:
> +- tx-delay: TX clock delay macro value. Range is 0~31. Default is 0.
> +	It should be defined for rgmii/rgmii-rxid/mii interface.
> +- rx-delay: RX clock delay macro value. Range is 0~31. Default is 0.
> +	It should be defined for rgmii/rgmii-txid/mii/rmii interface.
> +- fine-tune: This property will select coarse-tune delay or fine delay
> +	for rgmii interface.
> +	If fine-tune delay is enabled, tx-delay/rx-delay is 170+/-50ps
> +	per stage.
> +	Else coarse-tune delay is enabled, tx-delay/rx-delay is 0.55+/-0.2ns
> +	per stage.
> +	This property do not apply to non-rgmii PHYs.
> +	Only coarse-tune delay is supported for mii/rmii PHYs.

Perhaps the delays should be in ps and the driver can figure out 
fine-tune or not based on the value.

> +- rmii-rxc: Reference clock of rmii is from external PHYs,
> +	and it can be connected to TXC or RXC pin on MT2712 SoC.
> +	If ref_clk <--> TXC, disable it.
> +	Else ref_clk <--> RXC, enable it.
> +- txc-inverse: Inverse tx clock for mii/rgmii.
> +	Inverse tx clock inside MAC relative to reference clock for rmii,
> +	and it rarely happen.
> +- rxc-inverse: Inverse rx clock for mii/rgmii interfaces.
> +	Inverse reference clock for rmii.

These should all have vendor prefixes. 'snps' if these are all standard 
GMAC controls or 'mediatek' if Mediatek specific.

> +
> +Example:
> +	eth: ethernet@1101c000 {
> +		compatible = "mediatek,mt2712-gmac";
> +		reg = <0 0x1101c000 0 0x1300>;
> +		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "macirq";
> +		phy-mode ="rgmii-id";
> +		mac-address = [00 55 7b b5 7d f7];
> +		clock-names = "axi",
> +			      "apb",
> +			      "mac_ext",
> +			      "mac_parent",
> +			      "ptp_ref",
> +			      "ptp_parent",
> +			      "ptp_top";
> +		clocks = <&pericfg CLK_PERI_GMAC>,
> +			 <&pericfg CLK_PERI_GMAC_PCLK>,
> +			 <&topckgen CLK_TOP_ETHER_125M_SEL>,
> +			 <&topckgen CLK_TOP_ETHERPLL_125M>,
> +			 <&topckgen CLK_TOP_ETHER_50M_SEL>,
> +			 <&topckgen CLK_TOP_APLL1_D3>,
> +			 <&topckgen CLK_TOP_APLL1>;
> +		snps,txpbl = <32>;
> +		snps,rxpbl = <32>;
> +		snps,reset-gpio = <&pio 87 GPIO_ACTIVE_LOW>;
> +		snps,reset-active-low;
> +		tx-delay = <9>;
> +		rx-delay = <9>;
> +		fine-tune;
> +		rmii-rxc;
> +		txc-inverse;
> +		rxc-inverse;
> +	};
> -- 
> 1.7.9.5
> 
