Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C471EC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 07:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE0320844
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 07:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfBIHhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 02:37:47 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:20598 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725933AbfBIHhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 02:37:47 -0500
X-UUID: d59b8154488342f88233e1a319356576-20190209
X-UUID: d59b8154488342f88233e1a319356576-20190209
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <erin.lo@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1580361963; Sat, 09 Feb 2019 15:37:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sat, 9 Feb 2019 15:37:30 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sat, 9 Feb 2019 15:37:30 +0800
Message-ID: <1549697850.26316.5.camel@mtksdaap41>
Subject: Re: [PATCH v6 6/6] arm64: dts: Add Mediatek SoC MT8183 and
 evaluation board dts and Makefile
From:   Erin Lo <erin.lo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "Ben Ho" <Ben.Ho@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        "Mengqi Zhang" <Mengqi.Zhang@mediatek.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Eddie Huang <eddie.huang@mediatek.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Zhiyong Tao <Zhiyong.Tao@mediatek.com>
Date:   Sat, 9 Feb 2019 15:37:30 +0800
In-Reply-To: <c872f03c-714a-d99f-d555-e897f80d67be@gmail.com>
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
         <1548317240-44682-7-git-send-email-erin.lo@mediatek.com>
         <20190130162204.GA1521@bogus> <1548902050.23230.4.camel@mtksdaap41>
         <CAL_JsqL1vQCgbb2yLL2E4KTDZve1vus5bDX75HGiOu14X26q7w@mail.gmail.com>
         <1548992018.11367.8.camel@mtksdaap41> <1548997866.26127.4.camel@mtksdaap41>
         <c872f03c-714a-d99f-d555-e897f80d67be@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 939D2B96DD7D2DE4EA4A1C9D639E39BAF78BA30F0AAFF96F170F61F9E407B9AD2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-07 at 16:08 +0100, Matthias Brugger wrote:
> 
> On 01/02/2019 06:11, Erin Lo wrote:
> > Add back more people since mail server issue
> > 
> > On Fri, 2019-02-01 at 11:33 +0800, Erin Lo wrote:
> >> On Thu, 2019-01-31 at 15:10 -0600, Rob Herring wrote:
> >>> On Wed, Jan 30, 2019 at 8:34 PM Erin Lo <erin.lo@mediatek.com> wrote:
> >>>>
> >>>> On Wed, 2019-01-30 at 10:22 -0600, Rob Herring wrote:
> >>>>> On Thu, Jan 24, 2019 at 04:07:20PM +0800, Erin Lo wrote:
> >>>>>> From: Ben Ho <Ben.Ho@mediatek.com>
> >>>>>>
> >>>>>> Add basic chip support for Mediatek 8183, include
> >>>>>> pinctrl file, uart node with correct uart clocks, pwrap device
> >>>>>>
> >>>>>> Add clock controller nodes, include topckgen, infracfg,
> >>>>>> apmixedsys and subsystem.
> >>>>>>
> >>>>>> Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
> >>>>>> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> >>>>>> Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> >>>>>> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> >>>>>> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> >>>>>> Signed-off-by: Mengqi Zhang <Mengqi.Zhang@mediatek.com>
> >>>>>> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> >>>>>> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> >>>>>> ---
> >>>>>
> >>>>>
> >>>>>> +   sysirq: intpol-controller@c530a80 {
> >>>>>
> >>>>> interrupt-controller@...
> >>>>
> >>>> I will modify it in next version.
> >>>>>
> >>>>>
> >>>>> Place all the MMIO peripherals under one or more simple-bus nodes.
> >>>>>
> >>>>> Rob
> >>>>>
> >>>>
> >>>> Do you mean need to add simple-bus like this?
> >>>
> >>> Yes.
> >>
> >> We remove soc because Matthias suggested it in former MTK SoC maybe in
> >> 2015 year.
> >>
> >> We will add it back by your comment.
> >>
> >> Thank you. 
> >>
> >> Best Regards,
> >> Erin
> > 
> > Hi, Matthias,
> > Do you have any comment here?
> 
> Although I wasn't able to find it in the documentation my understanding is, that
> all devices on-chip should be under soc "bus".
> 
> I'm sorry if I created confusion with comments in the past.
> 
> Regards,
> Matthias
> 

OK! we will add soc "bus" back in next version.
Thank you for your comment.

Best Regards,
Erin

> > Thanks
> > 
> > Best Regards,
> > Erin
> >>>
> >>>>
> >>>> +   soc: soc {
> >>>> +                #address-cells = <0x1>;
> >>>> +                #size-cells = <0x1>;
> >>>> +                ranges = <0 0 0 0xffffffff>;
> >>>> +                compatible = "simple-bus";
> >>>>
> >>>>                 soc_data: soc_data@08000000 {
> >>>>                         compatible = "mediatek,mt8183-efuse",
> >>>>                                      "mediatek,efuse";
> >>>>                         reg = <0 0x08000000 0 0x0010>;
> >>>>                         #address-cells = <1>;
> >>>>                         #size-cells = <1>;
> >>>>                         status = "disabled";
> >>>>                 };
> >>>>
> >>>>                 gic: interrupt-controller@0c000000 {
> >>>>                         compatible = "arm,gic-v3";
> >>>>                         #interrupt-cells = <4>;
> >>>>
> >>>> Best Regards,
> >>>> Erin
> >>>>
> >>>>> _______________________________________________
> >>>>> Linux-mediatek mailing list
> >>>>> Linux-mediatek@lists.infradead.org
> >>>>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> >>>>
> >>>>
> >>>>
> >>>> _______________________________________________
> >>>> linux-arm-kernel mailing list
> >>>> linux-arm-kernel@lists.infradead.org
> >>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >>
> > 
> > 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


