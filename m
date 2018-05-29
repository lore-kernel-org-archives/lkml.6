Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936508AbeE2Ply (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:41:54 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:39900 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935702AbeE2Plr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:41:47 -0400
X-Google-Smtp-Source: ADUXVKL5X8cSDrqip4mN217SKLv/PO3Jd4TvnJfi9U5ic5TuxPZPqjlQvuUpofnjwpzq6iI/tY6Xqw==
From: Thomas Hebb <tommyhebb@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Thomas Hebb <tommyhebb@gmail.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Synaptics
        Berlin SoC support),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH] ARM: dts: berlin: switch to earlycon
Date: Tue, 29 May 2018 11:41:42 -0400
Message-Id: <7f67507ad697fc8c6d012f734c4d9a631d1afad1.1527608389.git.tommyhebb@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Synopsys DesignWare 8250 UART in Berlin SoCs is now supported by
8250_early, so we can use earlycon for early console output instead
of earlyprintk, which requires an SoC-specific kernel.

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
---
 arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts        | 2 +-
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 2 +-
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
index 1c475796d17f..f98798bb684f 100644
--- a/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
+++ b/arch/arm/boot/dts/berlin2-sony-nsz-gs7.dts
@@ -45,7 +45,7 @@
 	compatible = "sony,nsz-gs7", "marvell,berlin2", "marvell,berlin";
 
 	chosen {
-		bootargs = "earlyprintk";
+		bootargs = "earlycon";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
index ca24def0ce13..20f31cdeaf38 100644
--- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
+++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
@@ -46,7 +46,7 @@
 	compatible = "google,chromecast", "marvell,berlin2cd", "marvell,berlin";
 
 	chosen {
-		bootargs = "earlyprintk";
+		bootargs = "earlycon";
 		stdout-path = "serial0:115200n8";
 	};
 
diff --git a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
index 57aa5f8a7c77..9834e84a0797 100644
--- a/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
+++ b/arch/arm/boot/dts/berlin2q-marvell-dmp.dts
@@ -49,7 +49,7 @@
 	};
 
 	chosen {
-		bootargs = "earlyprintk";
+		bootargs = "earlycon";
 		stdout-path = "serial0:115200n8";
 	};
 
-- 
2.17.0
