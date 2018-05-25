Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965319AbeEYJZq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:25:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53834 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S965248AbeEYJZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:25:44 -0400
X-UUID: 8e1a371e326c41acbeca87397834ff88-20180525
Message-ID: <1527240333.11190.3.camel@mtksdccf07>
Subject: Re: [PATCH v3 4/8] drm/mediatek: add ddp component AAL1
From: Stu Hsieh <stu.hsieh@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date: Fri, 25 May 2018 17:25:33 +0800
In-Reply-To: <1527222238.27165.12.camel@mtksdaap41>
References: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
         <1527215665-11937-5-git-send-email-stu.hsieh@mediatek.com>
         <1527222238.27165.12.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. CK:

On Fri, 2018-05-25 at 12:23 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Fri, 2018-05-25 at 10:34 +0800, stu.hsieh@mediatek.com wrote:
> > From: Stu Hsieh <stu.hsieh@mediatek.com>
> > 
> > This patch add component AAL1 and
> > rename AAL to AAL0
> > 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > index 0828cf8bf85c..eee3c0cc2632 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> > @@ -41,7 +41,8 @@ enum mtk_ddp_comp_type {
> >  };
> >  
> >  enum mtk_ddp_comp_id {
> > -	DDP_COMPONENT_AAL,
> > +	DDP_COMPONENT_AAL0,
> > +	DDP_COMPONENT_AAL1,
> 
> Be sure compiling is success when you apply each patch of a series. I
> think when you apply to this patch, it would cause compiling error
> because some related modification is in the patch 'Add support for
> mediatek SOC MT2712'. So move the modification from that patch to this
> patch.
> 
> Regards,
> CK
I would move some modification related some component to associated
patch from the patch 'Add support for mediatek SOC MT2712'

Regards,
Stu

> 
> >  	DDP_COMPONENT_BLS,
> >  	DDP_COMPONENT_COLOR0,
> >  	DDP_COMPONENT_COLOR1,
> 
> 
