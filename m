Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F486C1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC1E20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 09:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC1E20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754933AbeFTJiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 05:38:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55839 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754358AbeFTI3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:29:38 -0400
X-UUID: 3846771449fa494fa62c0278bb3d3da7-20180620
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1982215437; Wed, 20 Jun 2018 16:14:33 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 20 Jun 2018 16:14:30 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 20 Jun 2018 16:14:31 +0800
Message-ID: <1529482471.11190.46.camel@mtksdccf07>
Subject: Re: [PATCH v6 12/29] drm/mediatek: Update the definition of
 connection from RDMA1 to DPI0
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date:   Wed, 20 Jun 2018 16:14:31 +0800
In-Reply-To: <1529396422.26480.8.camel@mtksdaap41>
References: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
         <1529393670-26862-13-git-send-email-stu.hsieh@mediatek.com>
         <1529396422.26480.8.camel@mtksdaap41>
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

On Tue, 2018-06-19 at 16:20 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Tue, 2018-06-19 at 15:34 +0800, Stu Hsieh wrote:
> > This patch update the definition of connection from RDMA1 to DPI0.
> > Change the term MOUT to SOUT.
> > 
> 
> I would like commit message describe 'why' of this patch. Both you and
> me know 'why' of this patch because we have discuss previously. But for
> someone who just see this patch, he or she does not understand why you
> change the name. So explain 'MOUT', 'SOUT' and describe 'why' change the
> naming.
> 
> Regards,
> CK
> 
OK

Regards,
Stu

> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > index 8bfc0debd2c2..977df8facb79 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > @@ -29,7 +29,7 @@
> >  #define DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x084
> >  #define DISP_REG_CONFIG_DISP_COLOR1_SEL_IN	0x088
> >  #define DISP_REG_CONFIG_DPI_SEL_IN		0x0ac
> > -#define DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN	0x0c8
> > +#define DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN	0x0c8
> >  #define DISP_REG_CONFIG_MMSYS_CG_CON0		0x100
> >  
> >  #define DISP_REG_CONFIG_DISP_OVL_MOUT_EN	0x030
> > @@ -80,7 +80,7 @@
> >  #define COLOR0_SEL_IN_OVL0		0x1
> >  #define OVL1_MOUT_EN_COLOR1		0x1
> >  #define GAMMA_MOUT_EN_RDMA1		0x1
> > -#define RDMA1_MOUT_DPI0			0x2
> > +#define RDMA1_SOUT_DPI0			0x2
> >  #define DPI0_SEL_IN_RDMA1		0x1
> >  #define COLOR1_SEL_IN_OVL1		0x1
> >  
> > @@ -156,8 +156,8 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
> >  		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
> >  		value = OD1_MOUT_EN_RDMA1;
> >  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
> > -		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
> > -		value = RDMA1_MOUT_DPI0;
> > +		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
> > +		value = RDMA1_SOUT_DPI0;
> >  	} else {
> >  		value = 0;
> >  	}
> 
> 


