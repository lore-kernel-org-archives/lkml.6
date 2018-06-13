Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9CE70C07D5C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1F6208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1F6208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934786AbeFMB7b (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:59:31 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21441 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933577AbeFMB7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:59:30 -0400
X-UUID: 1f87d5e3f9d94076a9fba9e15723af81-20180613
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 207452611; Wed, 13 Jun 2018 09:59:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 13 Jun 2018 09:59:24 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 13 Jun 2018 09:59:24 +0800
Message-ID: <1528855164.5296.9.camel@mtkswgap22>
Subject: Re: [PATCH 1/2] ndings: mediatek: Add bindings for mediatek MT6765
 Platform
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Jades Shih <jades.shih@mediatek.com>,
        "Yingjoe Chen" <yingjoe.chen@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Wed, 13 Jun 2018 09:59:24 +0800
In-Reply-To: <CAL_JsqJ3LjA3yG7UvD7FyhCxF60xWuu=c4uXLW1wD7MCLWuOPg@mail.gmail.com>
References: <1528843243-29782-1-git-send-email-mars.cheng@mediatek.com>
         <1528843243-29782-2-git-send-email-mars.cheng@mediatek.com>
         <CAL_JsqJ3LjA3yG7UvD7FyhCxF60xWuu=c4uXLW1wD7MCLWuOPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 18:51 -0600, Rob Herring wrote:
> On Tue, Jun 12, 2018 at 4:40 PM, Mars Cheng <mars.cheng@mediatek.com> wrote:
> > This adds dt-binding documentation for Mediatek MT6765. Only
> > include very basic items, gic, uart timer and cpu.
> 
> Check your subject...

Hi Rob

oops, my bad... will correct this in v2

> 
> >
> > Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/arm/mediatek.txt |    4 ++++
> >  .../interrupt-controller/mediatek,sysirq.txt       |    1 +
> >  .../devicetree/bindings/serial/mtk-uart.txt        |    1 +
> >  3 files changed, 6 insertions(+)


