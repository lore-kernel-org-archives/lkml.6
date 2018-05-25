Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965109AbeEYCfA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 22:35:00 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43559 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S935861AbeEYCek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 22:34:40 -0400
X-UUID: 64b3cb9be63e4e06893cf2930827b89d-20180525
From: <stu.hsieh@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v3 6/8] drm/mediatek: add ddp component PWM2
Date: Fri, 25 May 2018 10:34:23 +0800
Message-ID: <1527215665-11937-7-git-send-email-stu.hsieh@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
References: <1527215665-11937-1-git-send-email-stu.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stu Hsieh <stu.hsieh@mediatek.com>

This patch add component PWM2

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 9b19fc4423f1..e00c2e798abd 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -56,6 +56,7 @@ enum mtk_ddp_comp_id {
 	DDP_COMPONENT_OVL1,
 	DDP_COMPONENT_PWM0,
 	DDP_COMPONENT_PWM1,
+	DDP_COMPONENT_PWM2,
 	DDP_COMPONENT_RDMA0,
 	DDP_COMPONENT_RDMA1,
 	DDP_COMPONENT_RDMA2,
-- 
2.12.5
