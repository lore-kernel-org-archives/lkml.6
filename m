Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E508C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 02:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7392086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 02:13:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7392086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbeKSMfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 07:35:15 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:33576 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726861AbeKSMfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 07:35:15 -0500
X-UUID: 5b64fd3af3f843a8a87d757951c2d0b1-20181119
X-UUID: 5b64fd3af3f843a8a87d757951c2d0b1-20181119
Received: from mtkcas34.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <biao.huang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 151653256; Mon, 19 Nov 2018 10:12:50 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 19 Nov
 2018 10:12:49 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 19 Nov 2018 10:12:48 +0800
Message-ID: <1542593568.24219.5.camel@mhfsdcap03>
Subject: Re: [v3, PATCH 2/2] dt-binding: mediatek-dwmac: add binding
 document for MediaTek MT2712 DWMAC
From:   biao huang <biao.huang@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Nelson Chang =?UTF-8?Q?=28=E5=BC=B5=E5=AE=B6=E7=A5=A5=29?= 
        <nelson.chang@mediatek.com>, "andrew@lunn.ch" <andrew@lunn.ch>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Liguo Zhang =?UTF-8?Q?=28=E5=BC=A0=E7=AB=8B=E5=9B=BD=29?= 
        <Liguo.Zhang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Honghui Zhang =?UTF-8?Q?=28=E5=BC=A0=E6=B4=AA=E8=BE=89=29?= 
        <Honghui.Zhang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 19 Nov 2018 10:12:48 +0800
In-Reply-To: <CAGp9LzrHm-ympV2zAKZKcEfA25aJp8BSS+=01B6G=sP_HiSSdA@mail.gmail.com>
References: <1542359926-28800-1-git-send-email-biao.huang@mediatek.com>
         <1542359926-28800-2-git-send-email-biao.huang@mediatek.com>
         <CAGp9LzrHm-ympV2zAKZKcEfA25aJp8BSS+=01B6G=sP_HiSSdA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sean,

	Thanks for your detailed comments~

On Sat, 2018-11-17 at 08:21 +0800, Sean Wang wrote:
> On Fri, Nov 16, 2018 at 1:19 AM Biao Huang <biao.huang@mediatek.com> wrote:
> >
> > The commit adds the device tree binding documentation for the MediaTek DWMAC
> > found on MediaTek MT2712.
> >
> > Change-Id: I3728666bf65927164bd82fa8dddb90df8270bd44
> 
> Drop change-id
sorry, I forgot it. will remove in next version.
> 
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
> > +- interrupt-names: Should contain a list of interrupt names corresponding to
> > +       the interrupts in the interrupts property, if available.
> > +       Should be "macirq" for the main MAC IRQ
> > +- clocks: Must contain a phandle for each entry in clock-names.
> > +- clock-names: The name of the clock listed in the clocks property. These are
> > +       "axi", "apb", "mac_ext", "mac_parent", "ptp_ref", "ptp_parent", "ptp_top"
> > +       for MT2712 SoC
> 
> About not including these parent clocks to the controller, you can
> refer to assigned-clocks, assigned-clock-parents, assigned-clock-rates
> noted in Documentation/devicetree/bindings/clock/clock-bindings.txt to
> determine what speed these MUXs should be run at and see [1] as the
> example how applied in dts.
> 
> [1]
> https://elixir.bootlin.com/linux/latest/source/arch/arm/boot/dts/mt7623.dtsi#L660
> 
Got it, I'll remove parent info to dts.
> > +- mac-address: See ethernet.txt in the same directory
> > +- phy-mode: See ethernet.txt in the same directory
> > +
> > +Optional properties:
> > +- tx-delay: TX clock delay macro value. Range is 0~31. Default is 0.
> > +       It should be defined for rgmii/rgmii-rxid/mii interface.
> > +- rx-delay: RX clock delay macro value. Range is 0~31. Default is 0.
> > +       It should be defined for rgmii/rgmii-txid/mii/rmii interface.
> > +- fine-tune: This property will select coarse-tune delay or fine delay
> > +       for rgmii interface.
> what is the property's type?
> 
ok, property type info will be added in next version.
> > +       If fine-tune delay is enabled, tx-delay/rx-delay is 170+/-50ps
> > +       per stage.
> > +       Else coarse-tune delay is enabled, tx-delay/rx-delay is 0.55+/-0.2ns
> > +       per stage.
> > +       This property do not apply to non-rgmii PHYs.
> > +       Only coarse-tune delay is supported for mii/rmii PHYs.
> > +- rmii-rxc: Reference clock of rmii is from external PHYs,
> what is the property's type?
> 
got it.
> > +       and it can be connected to TXC or RXC pin on MT2712 SoC.
> > +       If ref_clk <--> TXC, disable it.
> > +       Else ref_clk <--> RXC, enable it.
> > +- txc-inverse: Inverse tx clock for mii/rgmii.
> what is the property's type?
> 
> > +       Inverse tx clock inside MAC relative to reference clock for rmii,
> > +       and it rarely happen.
> > +- rxc-inverse: Inverse rx clock for mii/rgmii interfaces.
> what is the property's type?
> 
got it.
> > +       Inverse reference clock for rmii.
> 
> If these optional properties look like generic enough, it would be
> good that place them to stmmac.txt. Otherwise, they should be added
> "mediatek," as the prefix string for these vendor-specific things.
> 
it's mediatek-specific, and the prefix string will be added in next
version.
> > +
> > +Example:
> > +       eth: ethernet@1101c000 {
> > +               compatible = "mediatek,mt2712-gmac";
> > +               reg = <0 0x1101c000 0 0x1300>;
> > +               interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_LOW>;
> > +               interrupt-names = "macirq";
> > +               phy-mode ="rgmii-id";
> > +               mac-address = [00 55 7b b5 7d f7];
> > +               clock-names = "axi",
> > +                             "apb",
> > +                             "mac_ext",
> > +                             "mac_parent",
> > +                             "ptp_ref",
> > +                             "ptp_parent",
> > +                             "ptp_top";
> > +               clocks = <&pericfg CLK_PERI_GMAC>,
> > +                        <&pericfg CLK_PERI_GMAC_PCLK>,
> > +                        <&topckgen CLK_TOP_ETHER_125M_SEL>,
> > +                        <&topckgen CLK_TOP_ETHERPLL_125M>,
> > +                        <&topckgen CLK_TOP_ETHER_50M_SEL>,
> > +                        <&topckgen CLK_TOP_APLL1_D3>,
> > +                        <&topckgen CLK_TOP_APLL1>;
> > +               snps,txpbl = <32>;
> > +               snps,rxpbl = <32>;
> > +               snps,reset-gpio = <&pio 87 GPIO_ACTIVE_LOW>;
> > +               snps,reset-active-low;
> > +               tx-delay = <9>;
> > +               rx-delay = <9>;
> > +               fine-tune;
> > +               rmii-rxc;
> > +               txc-inverse;
> > +               rxc-inverse;
> > +       };
> > --
> > 1.7.9.5
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek


