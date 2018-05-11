Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeEKJif (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 05:38:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:1853 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752476AbeEKJid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 05:38:33 -0400
X-UUID: 3342a34c9688491e998f225b46b3913d-20180511
Message-ID: <1526031506.24653.5.camel@mtksdaap41>
Subject: Re: [PATCH 0/2] Add basic support for Mediatek MT8183 SoC
From: Erin Lo <erin.lo@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date: Fri, 11 May 2018 17:38:26 +0800
In-Reply-To: <782e13c1-057b-164b-9270-d37c151aa9b4@gmail.com>
References: <1526019083-20237-1-git-send-email-erin.lo@mediatek.com>
         <782e13c1-057b-164b-9270-d37c151aa9b4@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-11 at 10:29 +0200, Matthias Brugger wrote:
> Hi Erin,
> 
> Please include the linux-mediatek and arm-linux-kernel mailinglists in the next
> round.
> 
> Some comments in the patches.
> 
> Regards,
> Matthias

I will add linux-mediatek, linux-arm-kernel, linux-kernel, linux-serial
mailinglists in next round.
Thanks for your reminder.

Regards,
Erin

> 
> On 05/11/2018 08:11 AM, Erin Lo wrote:
> > MT8183 is a SoC based on 64bit ARMv8 architecture.
> > It contains 4 CA53 and 4 CA73 cores.
> > MT8183 share many HW IP with MT65xx series.
> > This patchset was tested on MT8183 evaluation board, and boot to shell ok.
> > 
> > This series contains document bindings, device tree including interrupt, uart.
> > 
> > Ben Ho (1):
> >   arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and
> >     Makefile
> > 
> > Erin Lo (1):
> >   dt-bindings: arm: Add bindings for Mediatek MT8183 SoC Platform
> > 
> >  Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
> >  .../interrupt-controller/mediatek,sysirq.txt       |   1 +
> >  .../devicetree/bindings/serial/mtk-uart.txt        |   1 +
> >  arch/arm64/boot/dts/mediatek/Makefile              |   1 +
> >  arch/arm64/boot/dts/mediatek/mt8183-evb.dts        |  31 ++++
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi           | 178 +++++++++++++++++++++
> >  6 files changed, 216 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
> >  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > 
> > --
> > 1.9.1
> > 
