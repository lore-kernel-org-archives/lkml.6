Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753321AbeE1Flt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:41:49 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34939 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbeE1Flp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:41:45 -0400
X-Google-Smtp-Source: ADUXVKK8SGTDTqMlOEoOPAEG6CHU+J1CmpBEJLJRK+lPxZUi4AmdG5orMsoUYqXHqD5WfUSr46XSWw==
From: Srinath Mannam <srinath.mannam@broadcom.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>
Subject: [PATCH 1/3] dt-bindings: thermal: Add binding document for SR thermal
Date: Mon, 28 May 2018 11:11:22 +0530
Message-Id: <1527486084-4636-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527486084-4636-1-git-send-email-srinath.mannam@broadcom.com>
References: <1527486084-4636-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

Add binding document for supported thermal implementation
in Stingray.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 .../bindings/thermal/brcm,sr-thermal.txt           | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt

diff --git a/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
new file mode 100644
index 0000000..33f9e11
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
@@ -0,0 +1,45 @@
+* Broadcom Stingray Thermal
+
+This binding describes thermal sensors that is part of Stingray SoCs.
+
+Required properties:
+- compatible : Must be "brcm,sr-thermal"
+- reg : memory where tmon data will be available.
+
+Example:
+	tmons {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		tmon_ihost0: thermal@8f100000 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x8f100000 0x4>;
+		};
+
+		tmon_ihost1: thermal@8f100004 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x8f100004 0x4>;
+		};
+
+		tmon_ihost2: thermal@8f100008 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x8f100008 0x4>;
+		};
+
+		tmon_ihost3: thermal@8f10000c {
+			compatible = "brcm,sr-thermal";
+			reg = <0x8f10000c 0x4>;
+		};
+
+		tmon_crmu: thermal@8f100010 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x8f100010 0x4>;
+		};
+
+		tmon_nitro: thermal@8f100014 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x8f100014 0x4>;
+		};
+	};
-- 
2.7.4
