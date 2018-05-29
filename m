Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932785AbeE2JPM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 05:15:12 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:32903 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932284AbeE2JOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 05:14:31 -0400
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
        devicetree@vger.kernel.org, davem@davemloft.net,
        mchehab+samsung@kernel.org, akpm@linux-foundation.org,
        rdunlap@infradead.org, Avi Fishman <AviFishman70@gmail.com>
Subject: [PATCH v1 2/3] USB: DT probing support to ehci-npcm7xx
Date: Tue, 29 May 2018 11:35:34 +0300
Message-Id: <1527582935-31175-3-git-send-email-avifishman70@gmail.com>
X-Mailer: git-send-email 1.8.3.4
In-Reply-To: <1527582935-31175-1-git-send-email-avifishman70@gmail.com>
References: <1527582935-31175-1-git-send-email-avifishman70@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Fishman <AviFishman70@gmail.com>

Device Tree documentation for Nuvoton npcm7xx EHCI driver.

Signed-off-by: Avi Fishman <AviFishman70@gmail.com>
---
 Documentation/devicetree/bindings/usb/npcm7xx-usb.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/npcm7xx-usb.txt

diff --git a/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt b/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
new file mode 100644
index 000000000000..628692dff7e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
@@ -0,0 +1,18 @@
+Nuvoton NPCM7XX SoC USB controllers:
+-----------------------------
+
+EHCI:
+-----
+
+Required properties:
+- compatible: "nuvoton,npcm750-ehci"
+  that services interrupts for this device
+- interrupts: Should contain the EHCI interrupt
+
+Example:
+
+	ehci@e1800000 {
+		compatible = "nuvoton,npcm750-ehci", "usb-ehci";
+		reg = <0xf0806000 0x1000>;
+		interrupts = <0 61 4>;
+	};
-- 
2.14.1
