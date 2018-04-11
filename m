Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbeDKQlh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 12:41:37 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36574 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753864AbeDKQld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 12:41:33 -0400
X-Google-Smtp-Source: AIpwx4++00VHqxEt/8Ty+Cvt+7E3eqohhIDCMEzZ8wCt6GO6MCaZAn0uWnsJWwAgP1t0Mizi10ERxA==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: afaerber@suse.de, robh+dt@kernel.org
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/4] dt-bindings: power: Add Actions Semi S900 SPS
Date: Wed, 11 Apr 2018 22:10:33 +0530
Message-Id: <20180411164036.8046-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
References: <20180411164036.8046-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define power domains for Actions Semi S900 SoC Smart Power System (SPS).

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/power/actions,owl-sps.txt  |  2 ++
 include/dt-bindings/power/owl-s900-powergate.h     | 23 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 include/dt-bindings/power/owl-s900-powergate.h

diff --git a/Documentation/devicetree/bindings/power/actions,owl-sps.txt b/Documentation/devicetree/bindings/power/actions,owl-sps.txt
index 78edd63641e8..a3571937b019 100644
--- a/Documentation/devicetree/bindings/power/actions,owl-sps.txt
+++ b/Documentation/devicetree/bindings/power/actions,owl-sps.txt
@@ -3,11 +3,13 @@ Actions Semi Owl Smart Power System (SPS)
 Required properties:
 - compatible          :  "actions,s500-sps" for S500
                          "actions,s700-sps" for S700
+                         "actions,s900-sps" for S900
 - reg                 :  Offset and length of the register set for the device.
 - #power-domain-cells :  Must be 1.
                          See macros in:
                           include/dt-bindings/power/owl-s500-powergate.h for S500
                           include/dt-bindings/power/owl-s700-powergate.h for S700
+                          include/dt-bindings/power/owl-s900-powergate.h for S900
 
 
 Example:
diff --git a/include/dt-bindings/power/owl-s900-powergate.h b/include/dt-bindings/power/owl-s900-powergate.h
new file mode 100644
index 000000000000..f1aaf761112b
--- /dev/null
+++ b/include/dt-bindings/power/owl-s900-powergate.h
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Actions Semi S900 SPS
+ *
+ * Copyright (c) 2018 Linaro Ltd.
+ */
+#ifndef DT_BINDINGS_POWER_OWL_S900_POWERGATE_H
+#define DT_BINDINGS_POWER_OWL_S900_POWERGATE_H
+
+#define S900_PD_GPU_B	0
+#define S900_PD_VCE	1
+#define S900_PD_SENSOR	2
+#define S900_PD_VDE	3
+#define S900_PD_HDE	4
+#define S900_PD_USB3	5
+#define S900_PD_DDR0	6
+#define S900_PD_DDR1	7
+#define S900_PD_DE	8
+#define S900_PD_NAND	9
+#define S900_PD_USB2_H0	10
+#define S900_PD_USB2_H1	11
+
+#endif
-- 
2.14.1
