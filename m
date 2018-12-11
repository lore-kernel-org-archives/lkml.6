Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C444FC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882C62081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 06:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 882C62081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbeLKG2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:28:43 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:43616 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725923AbeLKG2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 01:28:43 -0500
X-UUID: d2d6ad3b42854a759334fc83043f32ad-20181211
X-UUID: d2d6ad3b42854a759334fc83043f32ad-20181211
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1434808722; Tue, 11 Dec 2018 14:28:30 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 11 Dec
 2018 14:28:28 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Dec 2018 14:28:28 +0800
Message-ID: <1544509708.14641.6.camel@mhfsdcap03>
Subject: Re: [PATCH 1/5] dt-bindings: i2c: Add Mediatek MT7629 i2c binding
From:   mtk15107 <qii.wang@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>
CC:     <wsa@the-dreams.de>, <devicetree@vger.kernel.org>,
        <ryder.lee@mediatek.com>, <srv_heupstream@mediatek.com>,
        <leilk.liu@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 11 Dec 2018 14:28:28 +0800
In-Reply-To: <CAGp9Lzppg3NXBtfgG2SLzMxKBiV9ozgDbBQRTffYA2JhT48Efg@mail.gmail.com>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
         <1543843974-4054-2-git-send-email-qii.wang@mediatek.com>
         <CAGp9Lzppg3NXBtfgG2SLzMxKBiV9ozgDbBQRTffYA2JhT48Efg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-04 at 12:19 -0800, Sean Wang wrote:
> <qii.wang@mediatek.com> 於 2018年12月3日 週一 上午5:34寫道：
> >
> > From: qii wang <qii.wang@mediatek.com>
> >
> > Add MT7629 i2c binding to i2c-mt2712.txt and there is no need to
> 
> where's i2c-mt2712.txt mentioned here?
> 

Sorry, I will rewrite this commit. Such as:

Add MT7629 i2c binding to binding file. 

> > modify i2c driver.
> 
> suggest not to mention driver in any dt-binding, dt-binding self
> should be os-agnostic
> 

Yes, I will remove it.

> >
> > Signed-off-by: qii wang <qii.wang@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> > index e199695..7729e57 100644
> > --- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
> > @@ -10,6 +10,7 @@ Required properties:
> >        "mediatek,mt6589-i2c": for MediaTek MT6589
> >        "mediatek,mt7622-i2c": for MediaTek MT7622
> >        "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
> > +      "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek mt7629
> 
> change mt7629 to MT7629 to align to the others
> 

OK.

> >        "mediatek,mt8173-i2c": for MediaTek MT8173
> >    - reg: physical base address of the controller and dma base, length of memory
> >      mapped region.
> > --
> > 1.7.9.5
> >
> >
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek


