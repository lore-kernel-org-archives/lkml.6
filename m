Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757218AbeDXLfF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:35:05 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:36362 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756986AbeDXLee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:34:34 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 5/7] arm64: dts: allwinner: h5: Add cpu0 label for first cpu
Date: Tue, 24 Apr 2018 19:34:22 +0800
Message-Id: <20180424113424.13196-6-wens@csie.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180424113424.13196-1-wens@csie.org>
References: <20180424113424.13196-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the board level, we want to be able to specify what regulator
supplies power to the cpu domain.

Add a label to the first cpu node so we can reference it later.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index e237c05cfdb4..62d646baac3c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -47,7 +47,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu0: cpu@0 {
 			compatible = "arm,cortex-a53", "arm,armv8";
 			device_type = "cpu";
 			reg = <0>;
-- 
2.17.0
