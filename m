Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756551AbeEJC5u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 22:57:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:1571 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756284AbeEJC5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 22:57:48 -0400
X-UUID: 3e603ff83f434655bfc2139b299245fe-20180510
From: <sean.wang@mediatek.com>
To: <matthias.bgg@gmail.com>, <rjw@rjwysocki.net>, <khilman@baylibre.com>
CC: <ulf.hansson@linaro.org>, <linux-mediatek@lists.infradead.org>,
        <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH] soc: mediatek: remove unneeded semicolon
Date: Thu, 10 May 2018 10:57:40 +0800
Message-ID: <a4b9c30335194d90072baf9373e41a21b349bc54.1525920846.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Fix up drivers/soc/mediatek/mtk-scpsys.c:255:2-3: Unneeded semicolon
accidently being added in commit f9e2f65dd561 ("soc: mediatek: add a
fixed wait for SRAM stable").

Fixes: f9e2f65dd561 ("soc: mediatek: add a fixed wait for SRAM stable")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 2080c8f..128e3dd 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -252,7 +252,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
 					 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
 		if (ret < 0)
 			goto err_pwr_ack;
-	};
+	}
 
 	if (scpd->data->bus_prot_mask) {
 		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
-- 
2.7.4
