Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753896AbeE1HK2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:10:28 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39350 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753638AbeE1HJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:09:56 -0400
X-UUID: b801605c4e4f4300aa84634261675565-20180528
Message-ID: <1527491391.24367.5.camel@mtksdaap41>
Subject: Re: [PATCH v4 6/9] drm/mediatek: add ddp component PWM2
From: CK Hu <ck.hu@mediatek.com>
To: Stu Hsieh <stu.hsieh@mediatek.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date: Mon, 28 May 2018 15:09:51 +0800
In-Reply-To: <1527489507-24453-7-git-send-email-stu.hsieh@mediatek.com>
References: <1527489507-24453-1-git-send-email-stu.hsieh@mediatek.com>
         <1527489507-24453-7-git-send-email-stu.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stu:

On Mon, 2018-05-28 at 14:38 +0800, Stu Hsieh wrote:
> This patch add component PWM2
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 1 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index a5c7ac2d162d..86e8c9e5df41 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -233,6 +233,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
>  	[DDP_COMPONENT_OVL1]	= { MTK_DISP_OVL,	1, NULL },
>  	[DDP_COMPONENT_PWM0]	= { MTK_DISP_PWM,	0, NULL },
>  	[DDP_COMPONENT_PWM1]	= { MTK_DISP_PWM,	1, NULL },
> +	[DDP_COMPONENT_PWM2]	= { MTK_DISP_PWM,	2, NULL },
>  	[DDP_COMPONENT_RDMA0]	= { MTK_DISP_RDMA,	0, NULL },
>  	[DDP_COMPONENT_RDMA1]	= { MTK_DISP_RDMA,	1, NULL },
>  	[DDP_COMPONENT_RDMA2]	= { MTK_DISP_RDMA,	2, NULL },
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 9b19fc4423f1..e00c2e798abd 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -56,6 +56,7 @@ enum mtk_ddp_comp_id {
>  	DDP_COMPONENT_OVL1,
>  	DDP_COMPONENT_PWM0,
>  	DDP_COMPONENT_PWM1,
> +	DDP_COMPONENT_PWM2,
>  	DDP_COMPONENT_RDMA0,
>  	DDP_COMPONENT_RDMA1,
>  	DDP_COMPONENT_RDMA2,
