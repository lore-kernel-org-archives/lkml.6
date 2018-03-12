Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeCLEYD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 00:24:03 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:47712 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbeCLEX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 00:23:59 -0400
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ARM: dts: sun8i: a33: Drop sunxi-common-regulators.dtsi for A33-OLinuXino
Date: Mon, 12 Mar 2018 12:23:54 +0800
Message-Id: <20180312042356.18625-3-wens@csie.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180312042356.18625-1-wens@csie.org>
References: <20180312042356.18625-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the common regulators defined in sunxi-common-regulators.dtsi
are used for the A33-OLinuXino.

Drop the include.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index 6349e0bec9a3..925a5339711f 100644
--- a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -43,7 +43,6 @@
 
 /dts-v1/;
 #include "sun8i-a33.dtsi"
-#include "sunxi-common-regulators.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
-- 
2.16.2
