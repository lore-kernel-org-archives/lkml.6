Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963C0C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 03:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637BE2084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 03:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbeLQDjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 22:39:16 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:33921 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726272AbeLQDjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 22:39:15 -0500
X-UUID: 8e04e12d430f470db48ea9a5a9dfcc14-20181217
X-UUID: 8e04e12d430f470db48ea9a5a9dfcc14-20181217
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1372463767; Mon, 17 Dec 2018 11:39:09 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 17 Dec 2018 11:39:07 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 17 Dec 2018 11:39:07 +0800
Message-ID: <1545017947.7782.1.camel@mtkswgap22>
Subject: Re: [PATCH] dt-bindings: watchdog: update bindings for MT7629 SoC
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-watchdog@vger.kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 17 Dec 2018 11:39:07 +0800
In-Reply-To: <4152fe87-0e72-f9aa-6874-9f40dc15f278@gmail.com>
References: <55d108719233b3c30c747e75a010b9e64681af09.1541573395.git.ryder.lee@mediatek.com>
         <4152fe87-0e72-f9aa-6874-9f40dc15f278@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Sun, 2018-12-16 at 11:31 +0100, Matthias Brugger wrote:
> 
> On 07/11/2018 08:10, Ryder Lee wrote:
> > This updates dt-binding documentation for MT7629 SoC
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> 
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> > ---
> >  Documentation/devicetree/bindings/watchdog/mtk-wdt.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > index 859dee1..8682d6a 100644
> > --- a/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > +++ b/Documentation/devicetree/bindings/watchdog/mtk-wdt.txt
> > @@ -8,6 +8,7 @@ Required properties:
> >  	"mediatek,mt6797-wdt", "mediatek,mt6589-wdt": for MT6797
> >  	"mediatek,mt7622-wdt", "mediatek,mt6589-wdt": for MT7622
> >  	"mediatek,mt7623-wdt", "mediatek,mt6589-wdt": for MT7623
> > +	"mediatek,mt7629-wdt", "mediatek,mt6589-wdt": for MT7629
> >  
> >  - reg : Specifies base physical address and size of the registers.
> >  
> > 

Could you take this through your tree?

Ryder

