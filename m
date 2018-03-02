Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428366AbeCBN4l (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:56:41 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:49674 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424607AbeCBN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:56:39 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>, Chanho Min <chanho.min@lge.com>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 1/4] arm64: dts: lg1312: DT fix s/#interrupts-cells/#interrupt-cells/
Date: Fri,  2 Mar 2018 14:56:30 +0100
Message-Id: <1519998993-14398-2-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519998993-14398-1-git-send-email-geert+renesas@glider.be>
References: <1519998993-14398-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Chanho Min <chanho.min@lge.com>
---
v3:
  - Add Acked-by,

v2:
  - Add Acked-by,
  - Rebased.
---
 arch/arm64/boot/dts/lg/lg1312.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/lg/lg1312.dtsi b/arch/arm64/boot/dts/lg/lg1312.dtsi
index 860c8fb10795011f..052c8a1906ae737e 100644
--- a/arch/arm64/boot/dts/lg/lg1312.dtsi
+++ b/arch/arm64/boot/dts/lg/lg1312.dtsi
@@ -124,7 +124,7 @@
 	amba {
 		#address-cells = <2>;
 		#size-cells = <1>;
-		#interrupts-cells = <3>;
+		#interrupt-cells = <3>;
 
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
-- 
2.7.4
