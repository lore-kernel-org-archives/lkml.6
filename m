Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752272AbeCLHFc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 03:05:32 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47181 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751903AbeCLHDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 03:03:50 -0400
X-UUID: 7dc9f3ab743941efb0fd4f947a5c18af-20180312
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
Subject: [PATCH v2 3/5] dt-bindings: clock: add clocks for MT2712
Date: Mon, 12 Mar 2018 15:03:40 +0800
Message-ID: <20180312070342.4335-5-weiyi.lu@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20180312070342.4335-1-weiyi.lu@mediatek.com>
References: <20180312070342.4335-1-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add new clocks according to ECO design change

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 include/dt-bindings/clock/mt2712-clk.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/clock/mt2712-clk.h b/include/dt-bindings/clock/mt2712-clk.h
index 48a8e797a617..76265836a1e1 100644
--- a/include/dt-bindings/clock/mt2712-clk.h
+++ b/include/dt-bindings/clock/mt2712-clk.h
@@ -222,7 +222,13 @@
 #define CLK_TOP_APLL_DIV_PDN5		183
 #define CLK_TOP_APLL_DIV_PDN6		184
 #define CLK_TOP_APLL_DIV_PDN7		185
-#define CLK_TOP_NR_CLK			186
+#define CLK_TOP_APLL1_D3		186
+#define CLK_TOP_APLL1_REF_SEL		187
+#define CLK_TOP_APLL2_REF_SEL		188
+#define CLK_TOP_NFI2X_EN		189
+#define CLK_TOP_NFIECC_EN		190
+#define CLK_TOP_NFI1X_CK_EN		191
+#define CLK_TOP_NR_CLK			192
 
 /* INFRACFG */
 
@@ -281,7 +287,9 @@
 #define CLK_PERI_MSDC30_3_EN		41
 #define CLK_PERI_MSDC50_0_HCLK_EN	42
 #define CLK_PERI_MSDC50_3_HCLK_EN	43
-#define CLK_PERI_NR_CLK			44
+#define CLK_PERI_MSDC30_0_QTR_EN	44
+#define CLK_PERI_MSDC30_3_QTR_EN	45
+#define CLK_PERI_NR_CLK			46
 
 /* MCUCFG */
 
-- 
2.12.5
