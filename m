Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeDQDTJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 23:19:09 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34432 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751218AbeDQDTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 23:19:07 -0400
X-Google-Smtp-Source: AIpwx4+RBIABMkZoP7NxE9qEpiPWEMqOj3E/XQ0HdJivk+ErD3qICT+YAU2JQOQy0UwW3bGMAYNTcQ==
From: Baolin Wang <baolin.wang@linaro.org>
To: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com
Cc: baolin.wang@linaro.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaotong.lu@spreadtrum.com
Subject: [PATCH 1/2] dt-bindings: input: Add Add Spreadtrum SC27xx vibrator documentation
Date: Tue, 17 Apr 2018 11:18:23 +0800
Message-Id: <0bfdc811c2b3da3aa1cde2feef278a86503e3804.1523934640.git.baolin.wang@linaro.org>
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
