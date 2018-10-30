Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14B0C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980BC2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wRIaA2Yx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980BC2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbeJ3V7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:59:47 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:56352 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbeJ3V7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:59:47 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 80682992;
        Tue, 30 Oct 2018 14:06:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1540904782;
        bh=6HuerUdipknqN1v3KCRRQo6yKMoxxz6IWRe6jlejfuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wRIaA2YxeDm8zoYamFJ/TgSQPP7vVBMLJ3n4Ty6gfoYlNqQ2G3yc0mwVK8MeKWZ//
         Alqscb7HjRLP4JZJoAqCzRMdMtwEkziIXk3HJ7WBs8Xr8oOwHt8HFBOZpUbQbHWqPP
         SIARvF8r/xe9IE59qTqIYolgrQENa5zgRCV3VvPk=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Yong Deng <yong.deng@magewell.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Todor Tomov <todor.tomov@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v12 1/2] dt-bindings: media: Add Allwinner V3s Camera Sensor Interface (CSI)
Date:   Tue, 30 Oct 2018 15:06:24 +0200
Message-ID: <308184907.pMD7ZDI2dr@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1540887143-27904-1-git-send-email-yong.deng@magewell.com>
References: <1540887143-27904-1-git-send-email-yong.deng@magewell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yong,

Thank you for the patch.

On Tuesday, 30 October 2018 10:12:23 EET Yong Deng wrote:
> Add binding documentation for Allwinner V3s CSI.
> 
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Yong Deng <yong.deng@magewell.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../devicetree/bindings/media/sun6i-csi.txt        | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/sun6i-csi.txt
> 
> diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt
> b/Documentation/devicetree/bindings/media/sun6i-csi.txt new file mode
> 100644
> index 000000000000..443e18c181b3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> @@ -0,0 +1,56 @@
> +Allwinner V3s Camera Sensor Interface
> +-------------------------------------
> +
> +Allwinner V3s SoC features a CSI module(CSI1) with parallel interface.
> +
> +Required properties:
> +  - compatible: value must be "allwinner,sun8i-v3s-csi"
> +  - reg: base address and size of the memory-mapped region.
> +  - interrupts: interrupt associated to this IP
> +  - clocks: phandles to the clocks feeding the CSI
> +    * bus: the CSI interface clock
> +    * mod: the CSI module clock
> +    * ram: the CSI DRAM clock
> +  - clock-names: the clock names mentioned above
> +  - resets: phandles to the reset line driving the CSI
> +
> +The CSI node should contain one 'port' child node with one child 'endpoint'
> +node, according to the bindings defined in
> +Documentation/devicetree/bindings/media/video-interfaces.txt.
> +
> +Endpoint node properties for CSI
> +---------------------------------
> +See the video-interfaces.txt for a detailed description of these
> properties. +- remote-endpoint	: (required) a phandle to the bus receiver's
> endpoint +			   node
> +- bus-width:		: (required) must be 8, 10, 12 or 16
> +- pclk-sample		: (optional) (default: sample on falling edge)
> +- hsync-active		: (required; parallel-only)
> +- vsync-active		: (required; parallel-only)
> +
> +Example:
> +
> +csi1: csi@1cb4000 {
> +	compatible = "allwinner,sun8i-v3s-csi";
> +	reg = <0x01cb4000 0x1000>;
> +	interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> +	clocks = <&ccu CLK_BUS_CSI>,
> +		 <&ccu CLK_CSI1_SCLK>,
> +		 <&ccu CLK_DRAM_CSI>;
> +	clock-names = "bus", "mod", "ram";
> +	resets = <&ccu RST_BUS_CSI>;
> +
> +	port {
> +		/* Parallel bus endpoint */
> +		csi1_ep: endpoint {
> +			remote-endpoint = <&adv7611_ep>;
> +			bus-width = <16>;
> +
> +			/* If hsync-active/vsync-active are missing,
> +			   embedded BT.656 sync is used */
> +			hsync-active = <0>; /* Active low */
> +			vsync-active = <0>; /* Active low */
> +			pclk-sample = <1>;  /* Rising */
> +		};
> +	};
> +};


-- 
Regards,

Laurent Pinchart



