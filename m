Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757763AbeD0IP3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 04:15:29 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44791 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757640AbeD0IOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 04:14:55 -0400
X-UUID: d26dcfc1b7b1449ab978df5b29a6c616-20180427
From: <sean.wang@mediatek.com>
To: <sboyd@codeaurora.org>, <mturquette@baylibre.com>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 4/6] dt-bindings: reset: mediatek: add entry for Mali-450 node to refer
Date: Fri, 27 Apr 2018 16:14:45 +0800
Message-ID: <d9f327fa30c987ac9cf3a349551bbaa037d1b24a.1524816502.git.sean.wang@mediatek.com>
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

Just add binding for a required reset referenced by Mali-450 on MT7623
or MT2701 SoC.

Cc: devicetree@vger.kernel.org
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 include/dt-bindings/reset/mt2701-resets.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/reset/mt2701-resets.h b/include/dt-bindings/reset/mt2701-resets.h
index 21deb54..50b7f06 100644
--- a/include/dt-bindings/reset/mt2701-resets.h
+++ b/include/dt-bindings/reset/mt2701-resets.h
@@ -87,4 +87,7 @@
 #define MT2701_ETHSYS_GMAC_RST			23
 #define MT2701_ETHSYS_PPE_RST			31
 
+/* G3DSYS resets */
+#define MT2701_G3DSYS_CORE_RST			0
+
 #endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT2701 */
-- 
2.7.4
