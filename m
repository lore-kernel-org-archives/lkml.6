Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50EEC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEB62083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 07:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AEB62083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937425AbeFSH66 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 03:58:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:21646 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S937405AbeFSH64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 03:58:56 -0400
X-UUID: d08d9cf685754c14a2b34def90d95748-20180619
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1203975387; Tue, 19 Jun 2018 15:58:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 19 Jun 2018 15:58:51 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 19 Jun 2018 15:58:51 +0800
Message-ID: <1529395131.26480.1.camel@mtksdaap41>
Subject: Re: [PATCH v6 08/29] drm/mediatek: add component DSI2
From:   CK Hu <ck.hu@mediatek.com>
To:     Stu Hsieh <stu.hsieh@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date:   Tue, 19 Jun 2018 15:58:51 +0800
In-Reply-To: <1529393670-26862-9-git-send-email-stu.hsieh@mediatek.com>
References: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
         <1529393670-26862-9-git-send-email-stu.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-19 at 15:34 +0800, Stu Hsieh wrote:
> This patch add the component DSI2
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 ++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> index cc74b1a7278c..071f9f5aefea 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -227,6 +227,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
>  	[DDP_COMPONENT_DPI1]	= { MTK_DPI,		1, NULL },
>  	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
>  	[DDP_COMPONENT_DSI1]	= { MTK_DSI,		1, NULL },
> +	[DDP_COMPONENT_DSI2]	= { MTK_DSI,		2, NULL },
>  	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, &ddp_gamma },
>  	[DDP_COMPONENT_OD0]	= { MTK_DISP_OD,	0, &ddp_od },
>  	[DDP_COMPONENT_OD1]	= { MTK_DISP_OD,	1, &ddp_od },
> @@ -278,6 +279,7 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
>  	    comp_id == DDP_COMPONENT_DPI0 ||
>  	    comp_id == DDP_COMPONENT_DPI1 ||
>  	    comp_id == DDP_COMPONENT_DSI0 ||
> +	    comp_id == DDP_COMPONENT_DSI2 ||
>  	    comp_id == DDP_COMPONENT_PWM0) {
>  		comp->regs = NULL;
>  		comp->clk = NULL;
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 54c99c169093..8d152b337f15 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -50,6 +50,7 @@ enum mtk_ddp_comp_id {
>  	DDP_COMPONENT_DPI1,
>  	DDP_COMPONENT_DSI0,
>  	DDP_COMPONENT_DSI1,
> +	DDP_COMPONENT_DSI2,
>  	DDP_COMPONENT_GAMMA,
>  	DDP_COMPONENT_OD0,
>  	DDP_COMPONENT_OD1,


