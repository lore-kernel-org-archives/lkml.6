Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A224C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 02:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62DE2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 02:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E62DE2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeKSNNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 08:13:53 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:20533 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725888AbeKSNNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 08:13:53 -0500
X-UUID: 745472719935414289b674bc8a7262d0-20181119
X-UUID: 745472719935414289b674bc8a7262d0-20181119
Received: from mtkcas35.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 662449553; Mon, 19 Nov 2018 10:51:38 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 19 Nov
 2018 10:51:36 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 19 Nov 2018 10:51:35 +0800
Message-ID: <1542595895.24219.28.camel@mhfsdcap03>
Subject: Re: [v3, PATCH 2/2] dt-binding: mediatek-dwmac: add binding
 document for MediaTek MT2712 DWMAC
From:   biao huang <biao.huang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        Honghui Zhang =?UTF-8?Q?=28=E5=BC=A0=E6=B4=AA=E8=BE=89=29?= 
        <Honghui.Zhang@mediatek.com>,
        YT Shen =?UTF-8?Q?=28=E6=B2=88=E5=B2=B3=E9=9C=86=29?= 
        <Yt.Shen@mediatek.com>,
        Liguo Zhang =?UTF-8?Q?=28=E5=BC=A0=E7=AB=8B=E5=9B=BD=29?= 
        <Liguo.Zhang@mediatek.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Nelson Chang =?UTF-8?Q?=28=3F=3F=E5=AE=B6=E7=A5=A5=29?= 
        <nelson.chang@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>
Date:   Mon, 19 Nov 2018 10:51:35 +0800
In-Reply-To: <20181117145611.GA26013@bogus>
References: <1542359926-28800-1-git-send-email-biao.huang@mediatek.com>
         <1542359926-28800-2-git-send-email-biao.huang@mediatek.com>
         <20181117145611.GA26013@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,
	Thanks for your comments.
On Sat, 2018-11-17 at 22:56 +0800, Rob Herring wrote:
> On Fri, Nov 16, 2018 at 05:18:46PM +0800, Biao Huang wrote:
> > The commit adds the device tree binding documentation for the MediaTek DWMAC
> > found on MediaTek MT2712.
> > 
> > Change-Id: I3728666bf65927164bd82fa8dddb90df8270bd44
> > Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> > ---
> >  .../devicetree/bindings/net/mediatek-dwmac.txt     |   77 ++++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.txt b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> > new file mode 100644
> > index 0000000..7fd56e0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.txt
> > @@ -0,0 +1,77 @@
> > +MediaTek DWMAC glue layer controller
> > +
> > +This file documents platform glue layer for stmmac.
> > +Please see stmmac.txt for the other unchanged properties.
> > +
> > +The device node has following properties.
> > +
> > +Required properties:
> > +- compatible:  Should be "mediatek,mt2712-gmac" for MT2712 SoC
> > +- reg:  Address and length of the register set for the device
> > +- interrupts:  Should contain the MAC interrupts
> 
> How many?
> 
the common stmmac driver will parse interrupt-name "macirq",
so even only one interrupt is used in mediatek dwmac design,
the interrupt-names is still remained in device tree.
> > +- interrupt-names: Should contain a list of interrupt names corresponding to
> > +	the interrupts in the interrupts property, if available.
> > +	Should be "macirq" for the main MAC IRQ
> > +- clocks: Must contain a phandle for each entry in clock-names.
> > +- clock-names: The name of the clock listed in the clocks property. These are
> > +	"axi", "apb", "mac_ext", "mac_parent", "ptp_ref", "ptp_parent", "ptp_top"
> > +	for MT2712 SoC
> 
> Clocks should represent the physical clocks connected to a block. Parent 
> clocks are not in that category.
> 
Got it. assigned-clocks/assigned-clocks-parents properties can handle
it.
> > +- mac-address: See ethernet.txt in the same directory
> > +- phy-mode: See ethernet.txt in the same directory
> > +
> > +Optional properties:
> > +- tx-delay: TX clock delay macro value. Range is 0~31. Default is 0.
> > +	It should be defined for rgmii/rgmii-rxid/mii interface.
> > +- rx-delay: RX clock delay macro value. Range is 0~31. Default is 0.
> > +	It should be defined for rgmii/rgmii-txid/mii/rmii interface.
> > +- fine-tune: This property will select coarse-tune delay or fine delay
> > +	for rgmii interface.
> > +	If fine-tune delay is enabled, tx-delay/rx-delay is 170+/-50ps
> > +	per stage.
> > +	Else coarse-tune delay is enabled, tx-delay/rx-delay is 0.55+/-0.2ns
> > +	per stage.
> > +	This property do not apply to non-rgmii PHYs.
> > +	Only coarse-tune delay is supported for mii/rmii PHYs.
> 
> Perhaps the delays should be in ps and the driver can figure out 
> fine-tune or not based on the value.
> 
the delay time in mediatek dwmac design is not so accurate, 
the current mt2712 and the following ICs will not use the same delay
design, but will use stages to indicate different delay time.
so, maybe "mediatek,tx-delay" represent the delay stage is a good
choice.
> > +- rmii-rxc: Reference clock of rmii is from external PHYs,
> > +	and it can be connected to TXC or RXC pin on MT2712 SoC.
> > +	If ref_clk <--> TXC, disable it.
> > +	Else ref_clk <--> RXC, enable it.
> > +- txc-inverse: Inverse tx clock for mii/rgmii.
> > +	Inverse tx clock inside MAC relative to reference clock for rmii,
> > +	and it rarely happen.
> > +- rxc-inverse: Inverse rx clock for mii/rgmii interfaces.
> > +	Inverse reference clock for rmii.
> 
> These should all have vendor prefixes. 'snps' if these are all standard 
> GMAC controls or 'mediatek' if Mediatek specific.
> 
Got it, will be modified in next version.
> > +
> > +Example:
> > +	eth: ethernet@1101c000 {
> > +		compatible = "mediatek,mt2712-gmac";
> > +		reg = <0 0x1101c000 0 0x1300>;
> > +		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
> > +		interrupt-names = "macirq";
> > +		phy-mode ="rgmii-id";
> > +		mac-address = [00 55 7b b5 7d f7];
> > +		clock-names = "axi",
> > +			      "apb",
> > +			      "mac_ext",
> > +			      "mac_parent",
> > +			      "ptp_ref",
> > +			      "ptp_parent",
> > +			      "ptp_top";
> > +		clocks = <&pericfg CLK_PERI_GMAC>,
> > +			 <&pericfg CLK_PERI_GMAC_PCLK>,
> > +			 <&topckgen CLK_TOP_ETHER_125M_SEL>,
> > +			 <&topckgen CLK_TOP_ETHERPLL_125M>,
> > +			 <&topckgen CLK_TOP_ETHER_50M_SEL>,
> > +			 <&topckgen CLK_TOP_APLL1_D3>,
> > +			 <&topckgen CLK_TOP_APLL1>;
> > +		snps,txpbl = <32>;
> > +		snps,rxpbl = <32>;
> > +		snps,reset-gpio = <&pio 87 GPIO_ACTIVE_LOW>;
> > +		snps,reset-active-low;
> > +		tx-delay = <9>;
> > +		rx-delay = <9>;
> > +		fine-tune;
> > +		rmii-rxc;
> > +		txc-inverse;
> > +		rxc-inverse;
> > +	};
> > -- 
> > 1.7.9.5
> > 


