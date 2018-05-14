Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeENVzV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 17:55:21 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34942 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeENVzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 17:55:19 -0400
X-Google-Smtp-Source: AB8JxZpP3m4V2ZlqDpCbCI2NqRpgw6eLsuJooeC9kb5ZVtKbFYF0JyWm+jhUNbLo+l4jnde5DK9JMg==
From: Thomas Hebb <tommyhebb@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, Thomas Hebb <tommyhebb@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH] Documentation: arm: clean up Marvell Berlin family info
Date: Mon, 14 May 2018 17:55:10 -0400
Message-Id: <20180514215511.17328-1-tommyhebb@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove dead links, make spacing consistent, and note that the family was
acquired by Synaptics in 2017.

Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>
---
 Documentation/arm/Marvell/README | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index b5bb7f518840..56ada27c53be 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -302,19 +302,15 @@ Berlin family (Multimedia Solutions)
 	88DE3010, Armada 1000 (no Linux support)
 		Core:		Marvell PJ1 (ARMv5TE), Dual-core
 		Product Brief:	http://www.marvell.com.cn/digital-entertainment/assets/armada_1000_pb.pdf
-	88DE3005, Armada 1500-mini
 	88DE3005, Armada 1500 Mini
 		Design name:	BG2CD
 		Core:		ARM Cortex-A9, PL310 L2CC
-		Homepage:	http://www.marvell.com/multimedia-solutions/armada-1500-mini/
-        88DE3006, Armada 1500 Mini Plus
-                Design name:    BG2CDP
-                Core:           Dual Core ARM Cortex-A7
-                Homepage:       http://www.marvell.com/multimedia-solutions/armada-1500-mini-plus/
+	88DE3006, Armada 1500 Mini Plus
+		Design name:	BG2CDP
+		Core:		Dual Core ARM Cortex-A7
 	88DE3100, Armada 1500
 		Design name:	BG2
 		Core:		Marvell PJ4B-MP (ARMv7), Tauros3 L2CC
-		Product Brief:	http://www.marvell.com/digital-entertainment/armada-1500/assets/Marvell-ARMADA-1500-Product-Brief.pdf
 	88DE3114, Armada 1500 Pro
 		Design name:	BG2Q
 		Core:		Quad Core ARM Cortex-A9, PL310 L2CC
@@ -324,13 +320,16 @@ Berlin family (Multimedia Solutions)
 	88DE3218, ARMADA 1500 Ultra
 		Core:		ARM Cortex-A53
 
-  Homepage: http://www.marvell.com/multimedia-solutions/
+  Homepage: https://www.synaptics.com/products/multimedia-solutions
   Directory: arch/arm/mach-berlin
 
   Comments:
+
    * This line of SoCs is based on Marvell Sheeva or ARM Cortex CPUs
      with Synopsys DesignWare (IRQ, GPIO, Timers, ...) and PXA IP (SDHCI, USB, ETH, ...).
 
+   * The Berlin family was acquired by Synaptics from Marvell in 2017.
+
 CPU Cores
 ---------
 
-- 
2.17.0
