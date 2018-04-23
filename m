Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754273AbeDWCee (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:34:34 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41884 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753995AbeDWCea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:34:30 -0400
X-Google-Smtp-Source: AIpwx4/ffRKudv39f39RvqFSZZzbs8PYN/gPyewol1WJlkkvPhzaDz96bYEqeuoLbIz3EzfWaJS56g==
From: Baolin Wang <baolin.wang@linaro.org>
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org,
        xiaotong.lu@spreadtrum.com
Subject: [PATCH v2 1/2] dt-bindings: input: Add Add Spreadtrum SC27xx vibrator documentation
Date: Mon, 23 Apr 2018 10:33:35 +0800
Message-Id: <e2f85ec0b1fb66baa41dd85bb31e8113e23c704b.1524450536.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaotong Lu <xiaotong.lu@spreadtrum.com>

This patch adds the binding documentation for Spreadtrum SC27xx series
vibrator device.

Signed-off-by: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v1:
 - No updates.
---
 .../bindings/input/sprd,sc27xx-vibra.txt           |   12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt

diff --git a/Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt b/Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
new file mode 100644
index 0000000..92ead29
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/sprd,sc27xx-vibra.txt
@@ -0,0 +1,12 @@
+Spreadtrum SC27xx PMIC Vibrator
+
+Required properties:
+- compatible: should be "sprd,sc27xx-vibrator".
+- reg: address of vibrator control register.
+
+Example :
+
+vibrator@eb4 {
+	compatible = "sprd,sc27xx-vibrator";
+	reg = <0xeb4>;
+};
-- 
1.7.9.5
