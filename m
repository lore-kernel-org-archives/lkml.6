Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA37C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CD220685
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CD220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeIZJCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:02:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:7235 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726171AbeIZJCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:02:18 -0400
X-UUID: 7e98363f3cb6421badc3e087049fd241-20180926
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1327875058; Wed, 26 Sep 2018 10:51:32 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 26 Sep 2018 10:51:30 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Sep 2018 10:51:30 +0800
Message-ID: <1537930290.881.2.camel@mtkswgap22>
Subject: Re: [Resend PATCH 5/5] arm: dts: mt7623: add display subsystem
 related device nodes
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Roy Luo <cheng-hao.luo@mediatek.com>,
        Weijie Gao <weijie.gao@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>,
        chunhui dai <chunhui.dai@mediatek.com>,
        "Bibby Hsieh" <bibby.hsieh@mediatek.com>
Date:   Wed, 26 Sep 2018 10:51:30 +0800
In-Reply-To: <aef1f507-b217-5587-d058-fb0b08698cd1@gmail.com>
References: <84011aa94dd7be9239b7a2f944dd30fc70568fbb.1536155449.git.ryder.lee@mediatek.com>
         <7105c341de3525761ad4067ca57c641c7097f773.1536155449.git.ryder.lee@mediatek.com>
         <aef1f507-b217-5587-d058-fb0b08698cd1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5C6E57BEFAC54557BB11AA8701732B0EBD2D323429297D4D36B02ADB1E0825732000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 17:48 +0200, Matthias Brugger wrote:
> 
> On 05/09/2018 16:09, Ryder Lee wrote:
> > Add display subsystem related device nodes for MT7623.
> > 
> > Cc: CK Hu <ck.hu@mediatek.com>
> > Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> > I forgot to sort nodes in my previous mail. Sorry for the inconvenience.
> > 
> > This patch depends on the series: https://lkml.org/lkml/2018/9/5/223
> 
> That's not yet merged, right?

Yes.

> > 
> > @Matthias,
> > I know you're working on broken MMSYS - just want to ask whether it's possible
> > to let the patch to go to your tree (if others are okay with it), and send a
> > fixup one for MT7623 MMSYS later?
> 
> I know I'm a big blocker here, sorry for the inconvenience.
> I'll do my best to get that in for the next release. If I make no progress on
> that then we should find a different solution.

No problem. Thanks for your great effort :)

> Regards,
> Matthias
> 
> > ---
> >  arch/arm/boot/dts/mt7623.dtsi                 | 177 ++++++++++++++++++++++++++
> >  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  83 ++++++++++++
> >  arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |  83 ++++++++++++
> >  3 files changed, 343 insertions(+)


