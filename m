Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AB8C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 013EA20863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfBAFLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:11:30 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40043 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725681AbfBAFLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:11:30 -0500
X-UUID: 166374edc88d4f38a7e11f7ac0f58334-20190201
X-UUID: 166374edc88d4f38a7e11f7ac0f58334-20190201
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 83050204; Fri, 01 Feb 2019 13:11:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 13:11:07 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 13:11:06 +0800
Message-ID: <1548997866.26127.4.camel@mtksdaap41>
Subject: Re: [PATCH v6 6/6] arm64: dts: Add Mediatek SoC MT8183 and
 evaluation board dts and Makefile
From:   Erin Lo <erin.lo@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, Ben Ho <Ben.Ho@mediatek.com>,
        "Mars Cheng" <mars.cheng@mediatek.com>,
        Mengqi Zhang <Mengqi.Zhang@mediatek.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
        Seiya Wang <seiya.wang@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eddie Huang" <eddie.huang@mediatek.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Zhiyong Tao <Zhiyong.Tao@mediatek.com>
Date:   Fri, 1 Feb 2019 13:11:06 +0800
In-Reply-To: <1548992018.11367.8.camel@mtksdaap41>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
         <1548317240-44682-7-git-send-email-erin.lo@mediatek.com>
         <20190130162204.GA1521@bogus> <1548902050.23230.4.camel@mtksdaap41>
         <CAL_JsqL1vQCgbb2yLL2E4KTDZve1vus5bDX75HGiOu14X26q7w@mail.gmail.com>
         <1548992018.11367.8.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add back more people since mail server issue

On Fri, 2019-02-01 at 11:33 +0800, Erin Lo wrote:
> On Thu, 2019-01-31 at 15:10 -0600, Rob Herring wrote:
> > On Wed, Jan 30, 2019 at 8:34 PM Erin Lo <erin.lo@mediatek.com> wrote:
> > >
> > > On Wed, 2019-01-30 at 10:22 -0600, Rob Herring wrote:
> > > > On Thu, Jan 24, 2019 at 04:07:20PM +0800, Erin Lo wrote:
> > > > > From: Ben Ho <Ben.Ho@mediatek.com>
> > > > >
> > > > > Add basic chip support for Mediatek 8183, include
> > > > > pinctrl file, uart node with correct uart clocks, pwrap device
> > > > >
> > > > > Add clock controller nodes, include topckgen, infracfg,
> > > > > apmixedsys and subsystem.
> > > > >
> > > > > Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
> > > > > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > > > > Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> > > > > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > > > > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > > > > Signed-off-by: Mengqi Zhang <Mengqi.Zhang@mediatek.com>
> > > > > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > > > > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > > > > ---
> > > >
> > > >
> > > > > +   sysirq: intpol-controller@c530a80 {
> > > >
> > > > interrupt-controller@...
> > >
> > > I will modify it in next version.
> > > >
> > > >
> > > > Place all the MMIO peripherals under one or more simple-bus nodes.
> > > >
> > > > Rob
> > > >
> > >
> > > Do you mean need to add simple-bus like this?
> > 
> > Yes.
> 
> We remove soc because Matthias suggested it in former MTK SoC maybe in
> 2015 year.
> 
> We will add it back by your comment.
> 
> Thank you. 
> 
> Best Regards,
> Erin

Hi, Matthias,
Do you have any comment here?
Thanks

Best Regards,
Erin
> > 
> > >
> > > +   soc: soc {
> > > +                #address-cells = <0x1>;
> > > +                #size-cells = <0x1>;
> > > +                ranges = <0 0 0 0xffffffff>;
> > > +                compatible = "simple-bus";
> > >
> > >                 soc_data: soc_data@08000000 {
> > >                         compatible = "mediatek,mt8183-efuse",
> > >                                      "mediatek,efuse";
> > >                         reg = <0 0x08000000 0 0x0010>;
> > >                         #address-cells = <1>;
> > >                         #size-cells = <1>;
> > >                         status = "disabled";
> > >                 };
> > >
> > >                 gic: interrupt-controller@0c000000 {
> > >                         compatible = "arm,gic-v3";
> > >                         #interrupt-cells = <4>;
> > >
> > > Best Regards,
> > > Erin
> > >
> > > > _______________________________________________
> > > > Linux-mediatek mailing list
> > > > Linux-mediatek@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> > >
> > >
> > >
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


