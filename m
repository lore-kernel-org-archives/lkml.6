Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965052AbeEYCey (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 22:34:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47646 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S964822AbeEYCel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 22:34:41 -0400
X-UUID: 897d6977a1d048b08da53456eb406409-20180525
From: <stu.hsieh@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>,
        Stu Hsieh <stu.hsieh@mediatek.com>
Subject: [PATCH v3 4/8] drm/mediatek: add ddp component AAL1
Date: Fri, 25 May 2018 10:34:21 +0800
Message-ID: <1527215665-11937-5-git-send-email-stu.hsieh@mediatek.com>
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

This patch add component AAL1 and
rename AAL to AAL0

Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
index 0828cf8bf85c..eee3c0cc2632 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
@@ -41,7 +41,8 @@ enum mtk_ddp_comp_type {
 };
 
 enum mtk_ddp_comp_id {
-	DDP_COMPONENT_AAL,
+	DDP_COMPONENT_AAL0,
+	DDP_COMPONENT_AAL1,
 	DDP_COMPONENT_BLS,
 	DDP_COMPONENT_COLOR0,
 	DDP_COMPONENT_COLOR1,
-- 
2.12.5
