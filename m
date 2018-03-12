Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeCLHDv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:03:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35890 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751849AbeCLHDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:03:49 -0400
X-UUID: 2421fbb537ae447892b58e27530ed0e3-20180312
From: Weiyi Lu <weiyi.lu@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>
CC: James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <srv_heupstream@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: [PATCH v2 1/5] dt-bindings: soc: update MT2712 power dt-bindings
Date: Mon, 12 Mar 2018 15:03:38 +0800
Message-ID: <20180312070342.4335-3-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20180312070342.4335-1-weiyi.lu@mediatek.com>
References: <20180312070342.4335-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new power domains(MFG_SC1/MFG_SC2/MFG_SC3)
for MT2712 according to ECO design change.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/power/mt2712-power.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/power/mt2712-power.h b/include/dt-bindings/power/mt2712-power.h
index 92b46d772fae..2c147817efc2 100644
--- a/include/dt-bindings/power/mt2712-power.h
+++ b/include/dt-bindings/power/mt2712-power.h
@@ -22,5 +22,8 @@
 #define MT2712_POWER_DOMAIN_USB		5
 #define MT2712_POWER_DOMAIN_USB2	6
 #define MT2712_POWER_DOMAIN_MFG		7
+#define MT2712_POWER_DOMAIN_MFG_SC1	8
+#define MT2712_POWER_DOMAIN_MFG_SC2	9
+#define MT2712_POWER_DOMAIN_MFG_SC3	10
 
 #endif /* _DT_BINDINGS_POWER_MT2712_POWER_H */
-- 
2.12.5
