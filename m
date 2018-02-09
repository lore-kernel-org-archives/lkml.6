Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752632AbeBIHBA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 02:01:00 -0500
Received: from mail-sh2.amlogic.com ([58.32.228.45]:31779 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750895AbeBIHAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 02:00:03 -0500
From: Yixun Lan <yixun.lan@amlogic.com>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
CC: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh@kernel.org>,
        Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: clock: reset: Add AXG AO Clock and Reset Bindings
Date: Fri, 9 Feb 2018 15:00:25 +0800
Message-ID: <20180209070026.193879-2-yixun.lan@amlogic.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180209070026.193879-1-yixun.lan@amlogic.com>
References: <20180209070026.193879-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.18.20.235]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings headers for the Meson-AXG's AO clock and
reset controller.

CC: <devicetree@vger.kernel.org>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 include/dt-bindings/clock/axg-aoclkc.h | 26 ++++++++++++++++++++++++++
 include/dt-bindings/reset/axg-aoclkc.h | 20 ++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 include/dt-bindings/clock/axg-aoclkc.h
 create mode 100644 include/dt-bindings/reset/axg-aoclkc.h

diff --git a/include/dt-bindings/clock/axg-aoclkc.h b/include/dt-bindings/clock/axg-aoclkc.h
new file mode 100644
index 000000000000..78683abb4247
--- /dev/null
+++ b/include/dt-bindings/clock/axg-aoclkc.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD) */
+/*
+ * Copyright (c) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Qiufang Dai <qiufang.dai@amlogic.com>
+ */
+
+#ifndef DT_BINDINGS_CLOCK_AMLOGIC_MESON_AXG_AOCLK
+#define DT_BINDINGS_CLOCK_AMLOGIC_MESON_AXG_AOCLK
+
+#define CLKID_AO_REMOTE		0
+#define CLKID_AO_I2C_MASTER	1
+#define CLKID_AO_I2C_SLAVE	2
+#define CLKID_AO_UART1		3
+#define CLKID_AO_UART2		4
+#define CLKID_AO_IR_BLASTER	5
+#define CLKID_AO_SAR_ADC	6
+#define CLKID_AO_CLK81		7
+#define CLKID_AO_SAR_ADC_SEL	8
+#define CLKID_AO_SAR_ADC_DIV	9
+#define CLKID_AO_SAR_ADC_CLK	10
+#define CLKID_AO_ALT_XTAL	11
+
+#endif
diff --git a/include/dt-bindings/reset/axg-aoclkc.h b/include/dt-bindings/reset/axg-aoclkc.h
new file mode 100644
index 000000000000..307f58161bbb
--- /dev/null
+++ b/include/dt-bindings/reset/axg-aoclkc.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD) */
+/*
+ * Copyright (c) 2016 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Qiufang Dai <qiufang.dai@amlogic.com>
+ */
+
+#ifndef DT_BINDINGS_RESET_AMLOGIC_MESON_AXG_AOCLK
+#define DT_BINDINGS_RESET_AMLOGIC_MESON_AXG_AOCLK
+
+#define RESET_AO_REMOTE		0
+#define RESET_AO_I2C_MASTER	1
+#define RESET_AO_I2C_SLAVE	2
+#define RESET_AO_UART1		3
+#define RESET_AO_UART2		4
+#define RESET_AO_IR_BLASTER	5
+
+#endif
-- 
2.15.1
