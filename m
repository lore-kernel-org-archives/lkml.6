Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97BDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6FA217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 02:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbeLRCfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 21:35:34 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:53068 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726296AbeLRCfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 21:35:34 -0500
X-UUID: 12d34f486d8a4aae9f0d0a9ed5da43f5-20181218
X-UUID: 12d34f486d8a4aae9f0d0a9ed5da43f5-20181218
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <qii.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1683043214; Tue, 18 Dec 2018 10:35:27 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 18 Dec
 2018 10:35:25 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 18 Dec 2018 10:35:25 +0800
Message-ID: <1545100525.11699.47.camel@mhfsdcap03>
Subject: Re: [PATCH 4/5] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
From:   Qii Wang <qii.wang@mediatek.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <ryder.lee@mediatek.com>
Date:   Tue, 18 Dec 2018 10:35:25 +0800
In-Reply-To: <20181217230629.i7i3kbreurgt7u73@ninjato>
References: <1543843974-4054-1-git-send-email-qii.wang@mediatek.com>
         <1543843974-4054-5-git-send-email-qii.wang@mediatek.com>
         <20181211202931.xav4gzi7rzh2scgx@ninjato>
         <1544693547.11699.40.camel@mhfsdcap03>
         <20181217230629.i7i3kbreurgt7u73@ninjato>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-18 at 00:06 +0100, Wolfram Sang wrote:
> > > What is "multi-user"? Why can't you add this offset to the reg-property
> > > directly?
> 
> ...
> 
> > MT8183 doesn't need to support muti-user according to the latest project
> > information, and I'll remove this feature from patches.
> 
> Okay. It will be dropped then, thanks for the heads up!
> 
> > > > +  - mediatek,share-i3c: i3c controller can share i2c function.
> > > 
> > > Please explain in more detail? Is this an I3C controller?
> > 
> > Yes, it is a i3c controller, and it is compatible with i2c. I only use
> > the feature of i2c, so I need a flag to do some extra settings.
> 
> Can't you derive this from the compatible? If it is
> "mediatek,mt8183-i2c", then you know you need these extra settings?
> 

Not all channels are i3c controllers in MT8183. only i3c controller need
some extra settings.


