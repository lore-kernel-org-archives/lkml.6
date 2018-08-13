Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A851FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5439121545
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 09:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5439121545
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbeHMLxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 07:53:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:10470 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728226AbeHMLxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 07:53:32 -0400
X-UUID: 15d5483acb0b4dc68d0bb473a64c0612-20180813
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <owen.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 893402320; Mon, 13 Aug 2018 17:12:05 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 13 Aug 2018 17:12:03 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 13 Aug 2018 17:12:03 +0800
Message-ID: <1534151523.17494.48.camel@mtkswgap22>
Subject: Re: [PATCH v5 01/11] dt-bindings: clock: mediatek: document clk
 bindings for Mediatek MT6765 SoC
From:   Owen Chen <owen.chen@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mars Cheng <mars.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>
Date:   Mon, 13 Aug 2018 17:12:03 +0800
In-Reply-To: <20180720174331.GA26945@rob-hp-laptop>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
         <1531817552-17221-2-git-send-email-mars.cheng@mediatek.com>
         <20180720174331.GA26945@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-20 at 11:43 -0600, Rob Herring wrote:
> On Tue, Jul 17, 2018 at 04:52:22PM +0800, Mars Cheng wrote:
> > This patch adds the binding documentation for apmixedsys, audsys, camsys,
> > imgsys, infracfg, mipi0a, topckgen, vcodecsys
> > 
> > Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> > Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> > ---
> >  .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    1 +
> >  .../bindings/arm/mediatek/mediatek,audsys.txt      |    1 +
> >  .../bindings/arm/mediatek/mediatek,camsys.txt      |   27 ++++++++++++++++++++
> >  .../bindings/arm/mediatek/mediatek,imgsys.txt      |    1 +
> >  .../bindings/arm/mediatek/mediatek,infracfg.txt    |    1 +
> >  .../bindings/arm/mediatek/mediatek,mipi0a.txt      |   23 +++++++++++++++++
> >  .../bindings/arm/mediatek/mediatek,mmsys.txt       |    1 +
> >  .../bindings/arm/mediatek/mediatek,pericfg.txt     |    1 +
> >  .../bindings/arm/mediatek/mediatek,topckgen.txt    |    1 +
> >  .../bindings/arm/mediatek/mediatek,vcodecsys.txt   |   22 ++++++++++++++++
> >  10 files changed, 79 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> > index b404d59..44eaeac 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> > @@ -8,6 +8,7 @@ Required Properties:
> >  - compatible: Should be one of:
> >  	- "mediatek,mt2701-apmixedsys"
> >  	- "mediatek,mt2712-apmixedsys", "syscon"
> > +	- "mediatek,mt6765-apmixedsys", "syscon"
> >  	- "mediatek,mt6797-apmixedsys"
> >  	- "mediatek,mt7622-apmixedsys"
> >  	- "mediatek,mt8135-apmixedsys"
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> > index 34a69ba..9a8672a 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> > @@ -7,6 +7,7 @@ Required Properties:
> >  
> >  - compatible: Should be one of:
> >  	- "mediatek,mt2701-audsys", "syscon"
> > +	- "mediatek,mt6765-audsys", "syscon"
> >  	- "mediatek,mt7622-audsys", "syscon"
> >  - #clock-cells: Must be 1
> >  
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
> > new file mode 100644
> > index 0000000..dc75783
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
> > @@ -0,0 +1,27 @@
> > +MediaTek CAMSYS controller
> > +============================
> > +
> > +The MediaTek CAMSYS controller provides various clocks to the system.
> 
> Only clocks? If so, then this should be moved to bindings/clocks/.
> 

camsys conclude not only clks but also mtcmos, so it's better to put
this node in this path.

> > +
> > +Required Properties:
> > +
> > +- compatible: Should be one of:
> > +	- "mediatek,mt6765-camsys", "syscon"
> > +- #clock-cells: Must be 1
> > +
> > +The AUDSYS controller uses the common clk binding from
> > +Documentation/devicetree/bindings/clock/clock-bindings.txt
> > +The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> > +
> > +Required sub-nodes:
> > +-------
> > +For common binding part and usage, refer to
> > +../sonud/mt2701-afe-pcm.txt.
> > +
> > +Example:
> > +
> > +camsys: camsys@1a000000  {
> 
> clock-controller@...
> 
> if the above answer is yes.
> 
> Same comments on the other docs.


