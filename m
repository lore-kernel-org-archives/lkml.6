Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeDIXAv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 19:00:51 -0400
Received: from anholt.net ([50.246.234.109]:54660 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752278AbeDIXAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 19:00:46 -0400
From: Eric Anholt <eric@anholt.net>
To: dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org
Cc: Eric Anholt <eric@anholt.net>
Subject: [PATCH 2/3] ARM: dts: bcm283x: Remove the vc4 GPU subsystem node.
Date: Mon,  9 Apr 2018 16:00:39 -0700
Message-Id: <20180409230040.1100-2-eric@anholt.net>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180409230040.1100-1-eric@anholt.net>
References: <20180409230040.1100-1-eric@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is no longer required by the DRM driver, and was just a temporary
hack for it.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm283x.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 9d293decf8d3..869bf350d426 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -609,10 +609,6 @@
 			reg = <0x7ec00000 0x1000>;
 			interrupts = <1 10>;
 		};
-
-		vc4: gpu {
-			compatible = "brcm,bcm2835-vc4";
-		};
 	};
 
 	clocks {
-- 
2.17.0
