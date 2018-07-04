Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCC8C6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1FC24704
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 00:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1FC24704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753082AbeGDAYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 20:24:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:30116 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750716AbeGDAYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 20:24:07 -0400
X-UUID: df413c6fb37c47cab8ca095941d64619-20180704
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1398450974; Wed, 04 Jul 2018 08:24:03 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 4 Jul 2018 08:24:01 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 4 Jul 2018 08:24:01 +0800
Message-ID: <1530663841.28949.0.camel@mtkswgap22>
Subject: Re: [PATCH v2 1/2] dt-bindings: mediatek: Add bindings for mediatek
 MT6765 Platform
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Jades Shih <jades.shih@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        "My Chuang" <my.chuang@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <linux-serial@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 4 Jul 2018 08:24:01 +0800
In-Reply-To: <20180703221101.GA6829@rob-hp-laptop>
References: <1529978646-28976-1-git-send-email-mars.cheng@mediatek.com>
         <1529978646-28976-2-git-send-email-mars.cheng@mediatek.com>
         <20180703221101.GA6829@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

On Tue, 2018-07-03 at 16:11 -0600, Rob Herring wrote:
> On Tue, Jun 26, 2018 at 10:04:05AM +0800, Mars Cheng wrote:
> > This adds dt-binding documentation for Mediatek MT6765. Only
> > include very basic items, gic, uart timer and cpu.
> > 
> > Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/arm/mediatek.txt |    4 ++++
> >  .../interrupt-controller/mediatek,sysirq.txt       |    1 +
> >  .../devicetree/bindings/serial/mtk-uart.txt        |    1 +
> 
> These can all go thru different trees, so should be split.
> 

Got it, will split them.

> >  3 files changed, 6 insertions(+)


