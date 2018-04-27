Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757734AbeD0IPZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:15:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42143 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757689AbeD0IPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:15:04 -0400
X-UUID: 02e43fe195514bf88caeb50468fe727a-20180427
From: <sean.wang@mediatek.com>
To: <sboyd@codeaurora.org>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 3/6] dt-bindings: clock: mediatek: add entry for Mali-450 node to refer
Date: Fri, 27 Apr 2018 16:14:44 +0800
Message-ID: <082c3040e2be27d30e0642943f6df35ff4de5666.1524816502.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1524816502.git.sean.wang@mediatek.com>
References: <cover.1524816502.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Just add binding for a required clock referenced by Mali-450 on MT7623
or MT2701 SoC.

Cc: devicetree@vger.kernel.org
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 include/dt-bindings/clock/mt2701-clk.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/mt2701-clk.h b/include/dt-bindings/clock/mt2701-clk.h
index 24e93df..2ac62a6 100644
--- a/include/dt-bindings/clock/mt2701-clk.h
+++ b/include/dt-bindings/clock/mt2701-clk.h
@@ -431,6 +431,10 @@
 #define CLK_ETHSYS_CRYPTO			8
 #define CLK_ETHSYS_NR				9
 
+/* G3DSYS */
+#define CLK_G3DSYS_CORE				1
+#define CLK_G3DSYS_NR				2
+
 /* BDP */
 
 #define CLK_BDP_BRG_BA				1
-- 
2.7.4
