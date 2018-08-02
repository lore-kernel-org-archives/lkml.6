Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657BEC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20277214E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20277214E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbeHBNaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:30:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:14571 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732153AbeHBNaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:30:01 -0400
X-UUID: d85b8e7963aa4bc293870d2f0a195b30-20180802
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 433779484; Thu, 02 Aug 2018 19:39:11 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 2 Aug 2018 19:39:09 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 2 Aug 2018 19:39:09 +0800
Message-ID: <1533209949.11190.63.camel@mtksdccf07>
Subject: Re: [PATCH v1 14/15] drm/mediatek: fixed the error value for add
 DSI1 in mutex
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Thu, 2 Aug 2018 19:39:09 +0800
In-Reply-To: <1532495445.9280.22.camel@mtksdaap41>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
         <1532420235-22268-15-git-send-email-stu.hsieh@mediatek.com>
         <1532495445.9280.22.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, CK:

On Wed, 2018-07-25 at 13:10 +0800, CK Hu wrote:
> Hi, Stu:
> 
> 
> On Tue, 2018-07-24 at 16:17 +0800, Stu Hsieh wrote:
> > This patch fixed the error value for add DSI1 in mutex
> > 
> 
> English is not my mother language, but should it be 'fix' rather than
> 'fixed'?
> 
> Regards,
> CK
> 
OK

Regards,
Stu
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > index 3239f22785fd..ac047fdb1a2b 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > @@ -437,7 +437,7 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
> >  		reg = MUTEX_SOF_DSI0;
> >  		break;
> >  	case DDP_COMPONENT_DSI1:
> > -		reg = MUTEX_SOF_DSI0;
> > +		reg = MUTEX_SOF_DSI1;
> >  		break;
> >  	case DDP_COMPONENT_DSI2:
> >  		reg = MUTEX_SOF_DSI2;
> 
> 


