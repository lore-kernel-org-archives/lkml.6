Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755318AbeEaNmI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 09:42:08 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:33128 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755217AbeEaNmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 09:42:03 -0400
From: avifishman70@gmail.com
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com,
        mathias.nyman@linux.intel.com, bjorn.andersson@linaro.org,
        jhogan@kernel.org, albeu@free.fr, chunfeng.yun@mediatek.com,
        tony@atomide.com, baolu.lu@linux.intel.com, elder@linaro.org,
        digetx@gmail.com, kstewart@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        openbmc@lists.ozlabs.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Avi Fishman <AviFishman70@gmail.com>
Subject: [PATCH v2 2/3] USB: DT probing support to ehci-npcm7xx
Date: Thu, 31 May 2018 16:40:45 +0300
Message-Id: <1527774046-7952-3-git-send-email-avifishman70@gmail.com>
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1527774046-7952-1-git-send-email-avifishman70@gmail.com>
References: <1527774046-7952-1-git-send-email-avifishman70@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Fishman <AviFishman70@gmail.com>

Device Tree documentation for Nuvoton npcm7xx EHCI.

Signed-off-by: Avi Fishman <AviFishman70@gmail.com>
---
 Documentation/devicetree/bindings/usb/npcm7xx-usb.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/npcm7xx-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt b/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
new file mode 100644
index 000000000000..dec67d4d4c30
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
@@ -0,0 +1,17 @@
+Nuvoton NPCM7XX SoC USB controllers:
+-----------------------------
+
+EHCI:
+-----
+
+Required properties:
+- compatible: "nuvoton,npcm750-ehci"
+- interrupts: Should contain the EHCI interrupt
+
+Example:
+
+	ehci@e1800000 {
+		compatible = "nuvoton,npcm750-ehci";
+		reg = <0xf0806000 0x1000>;
+		interrupts = <0 61 4>;
+	};
-- 
2.14.1
