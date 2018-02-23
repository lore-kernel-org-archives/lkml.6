Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeBWKRB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:17:01 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:23098 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751579AbeBWKQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:16:54 -0500
X-UUID: 77a2d9838df8461a8bf1e2a581e63bb0-20180223
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>
Subject: [PATCH v1 03/19] dt-bindings: pinctrl: mediatek: add bindings for I2C2 and SPI2 on MT7623
Date: Fri, 23 Feb 2018 18:16:23 +0800
Message-ID: <607af13d88f733057df2ea057228e1cdbf77262a.1519378871.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1519378871.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add missing pinctrl binding about I2C2 and SPI2 which would be used in
devicetree related files.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 include/dt-bindings/pinctrl/mt7623-pinfunc.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/dt-bindings/pinctrl/mt7623-pinfunc.h b/include/dt-bindings/pinctrl/mt7623-pinfunc.h
index 2d6a7b1..4878a67 100644
--- a/include/dt-bindings/pinctrl/mt7623-pinfunc.h
+++ b/include/dt-bindings/pinctrl/mt7623-pinfunc.h
@@ -251,6 +251,12 @@
 #define MT7623_PIN_76_SCL0_FUNC_GPIO76 (MTK_PIN_NO(76) | 0)
 #define MT7623_PIN_76_SCL0_FUNC_SCL0 (MTK_PIN_NO(76) | 1)
 
+#define MT7623_PIN_77_SDA2_FUNC_GPIO77 (MTK_PIN_NO(77) | 0)
+#define MT7623_PIN_77_SDA2_FUNC_SDA2 (MTK_PIN_NO(77) | 1)
+
+#define MT7623_PIN_78_SCL2_FUNC_GPIO78 (MTK_PIN_NO(78) | 0)
+#define MT7623_PIN_78_SCL2_FUNC_SCL2 (MTK_PIN_NO(78) | 1)
+
 #define MT7623_PIN_79_URXD0_FUNC_GPIO79 (MTK_PIN_NO(79) | 0)
 #define MT7623_PIN_79_URXD0_FUNC_URXD0 (MTK_PIN_NO(79) | 1)
 #define MT7623_PIN_79_URXD0_FUNC_UTXD0 (MTK_PIN_NO(79) | 2)
@@ -291,6 +297,24 @@
 #define MT7623_PIN_100_MIPI_TDP0_FUNC_GPIO100 (MTK_PIN_NO(100) | 0)
 #define MT7623_PIN_100_MIPI_TDP0_FUNC_TDP0 (MTK_PIN_NO(100) | 1)
 
+#define MT7623_PIN_101_SPI2_CSN_FUNC_GPIO101 (MTK_PIN_NO(101) | 0)
+#define MT7623_PIN_101_SPI2_CSN_FUNC_SPI2_CS (MTK_PIN_NO(101) | 1)
+#define MT7623_PIN_101_SPI2_CSN_FUNC_SCL3 (MTK_PIN_NO(101) | 3)
+
+#define MT7623_PIN_102_SPI2_MI_FUNC_GPIO102 (MTK_PIN_NO(102) | 0)
+#define MT7623_PIN_102_SPI2_MI_FUNC_SPI2_MI (MTK_PIN_NO(102) | 1)
+#define MT7623_PIN_102_SPI2_MI_FUNC_SPI2_MO (MTK_PIN_NO(102) | 2)
+#define MT7623_PIN_102_SPI2_MI_FUNC_SDA3 (MTK_PIN_NO(102) | 3)
+
+#define MT7623_PIN_103_SPI2_MO_FUNC_GPIO103 (MTK_PIN_NO(103) | 0)
+#define MT7623_PIN_103_SPI2_MO_FUNC_SPI2_MO (MTK_PIN_NO(103) | 1)
+#define MT7623_PIN_103_SPI2_MO_FUNC_SPI2_MI (MTK_PIN_NO(103) | 2)
+#define MT7623_PIN_103_SPI2_MO_FUNC_SCL3 (MTK_PIN_NO(103) | 3)
+
+#define MT7623_PIN_104_SPI2_CK_FUNC_GPIO104 (MTK_PIN_NO(104) | 0)
+#define MT7623_PIN_104_SPI2_CK_FUNC_SPI2_CK (MTK_PIN_NO(104) | 1)
+#define MT7623_PIN_104_SPI2_CK_FUNC_SDA3 (MTK_PIN_NO(104) | 3)
+
 #define MT7623_PIN_105_MSDC1_CMD_FUNC_GPIO105 (MTK_PIN_NO(105) | 0)
 #define MT7623_PIN_105_MSDC1_CMD_FUNC_MSDC1_CMD (MTK_PIN_NO(105) | 1)
 #define MT7623_PIN_105_MSDC1_CMD_FUNC_SDA1 (MTK_PIN_NO(105) | 3)
-- 
2.7.4
