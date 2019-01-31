Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E133BC282D8
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDEB020B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 02:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbfAaCe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 21:34:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:5712 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725535AbfAaCe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 21:34:26 -0500
X-UUID: 244e67036a0c411e91eb3ee24e8c2c18-20190131
X-UUID: 244e67036a0c411e91eb3ee24e8c2c18-20190131
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 773714994; Thu, 31 Jan 2019 10:34:12 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 31 Jan 2019 10:34:10 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 10:34:10 +0800
Message-ID: <1548902050.23230.4.camel@mtksdaap41>
Subject: Re: [PATCH v6 6/6] arm64: dts: Add Mediatek SoC MT8183 and
 evaluation board dts and Makefile
From:   Erin Lo <erin.lo@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, Ben Ho <Ben.Ho@mediatek.com>,
        <mars.cheng@mediatek.com>,
        Mengqi Zhang <Mengqi.Zhang@mediatek.com>,
        <linux-clk@vger.kernel.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        "Seiya Wang" <seiya.wang@mediatek.com>,
        <linux-serial@vger.kernel.org>, <yingjoe.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <eddie.huang@mediatek.com>, <linux-arm-kernel@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Date:   Thu, 31 Jan 2019 10:34:10 +0800
In-Reply-To: <20190130162204.GA1521@bogus>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
         <1548317240-44682-7-git-send-email-erin.lo@mediatek.com>
         <20190130162204.GA1521@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 14330CE4A278BEFC08A742B7265A20949BB9CE8105936BB5CFA505010BB319132000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-01-30 at 10:22 -0600, Rob Herring wrote:
> On Thu, Jan 24, 2019 at 04:07:20PM +0800, Erin Lo wrote:
> > From: Ben Ho <Ben.Ho@mediatek.com>
> > 
> > Add basic chip support for Mediatek 8183, include
> > pinctrl file, uart node with correct uart clocks, pwrap device
> > 
> > Add clock controller nodes, include topckgen, infracfg,
> > apmixedsys and subsystem.
> > 
> > Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > Signed-off-by: Mengqi Zhang <Mengqi.Zhang@mediatek.com>
> > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> 
> 
> > +	sysirq: intpol-controller@c530a80 {
> 
> interrupt-controller@...

I will modify it in next version.
> 
> 
> Place all the MMIO peripherals under one or more simple-bus nodes.
> 
> Rob
> 

Do you mean need to add simple-bus like this?

+   soc: soc {
+                #address-cells = <0x1>;
+                #size-cells = <0x1>;
+                ranges = <0 0 0 0xffffffff>;
+                compatible = "simple-bus";

	        soc_data: soc_data@08000000 {
	                compatible = "mediatek,mt8183-efuse",
	                             "mediatek,efuse";
	                reg = <0 0x08000000 0 0x0010>;
	                #address-cells = <1>;
	                #size-cells = <1>;
	                status = "disabled";
	        };

	        gic: interrupt-controller@0c000000 {
	                compatible = "arm,gic-v3";
	                #interrupt-cells = <4>;
	
Best Regards,
Erin

> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


