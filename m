Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DSxuNnBIGVt+SAAAmS7hNA
	; Thu, 07 Jun 2018 15:00:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B9907607E7; Thu,  7 Jun 2018 15:00:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 488EF601C3;
	Thu,  7 Jun 2018 15:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 488EF601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935793AbeFGPAg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:00:36 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:33487 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932536AbeFGPAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:00:33 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w57EwN84019459;
        Thu, 7 Jun 2018 17:58:24 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 8441)
        id A892562FF2; Thu,  7 Jun 2018 17:58:23 +0300 (IDT)
From: avifishman70@gmail.com
To: gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com,
        mathias.nyman@linux.intel.com, bjorn.andersson@linaro.org,
        jhogan@kernel.org, albeu@free.fr, chunfeng.yun@mediatek.com,
        tony@atomide.com, baolu.lu@linux.intel.com, elder@linaro.org,
        digetx@gmail.com, kstewart@linuxfoundation.org,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, openbmc@lists.ozlabs.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Avi Fishman <AviFishman70@gmail.com>
Subject: [PATCH v4 2/3] dt-bindings: usb: new ehci-npcm7xx dt
Date: Thu,  7 Jun 2018 17:58:20 +0300
Message-Id: <20180607145821.322979-3-avifishman70@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180607145821.322979-1-avifishman70@gmail.com>
References: <20180607145821.322979-1-avifishman70@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
index 000000000000..b682bec103f9
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
+	ehci1: usb@f0806000 {
+		compatible = "nuvoton,npcm750-ehci";
+		reg = <0xf0806000 0x1000>;
+		interrupts = <0 61 4>;
+	};
-- 
2.14.1
