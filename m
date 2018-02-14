Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934967AbeBNIzD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 03:55:03 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54885 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934695AbeBNIzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 03:55:01 -0500
X-Google-Smtp-Source: AH8x227FffOWF5KlLkGT1VTlkHicUxDAILdgCAQKpFD7QZUevr+UAuSU3fzlCTBibm7whgqgWrdIvg==
From: Corentin Labbe <clabbe@baylibre.com>
To: catalin.marinas@arm.com, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, robh+dt@kernel.org, wens@csie.org,
        will.deacon@arm.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] ARM64: dts: allwinner: sun50i-h5-orangepi-zero-plus2: rename mmc0_pins_a to mmc0_pins
Date: Wed, 14 Feb 2018 08:54:47 +0000
Message-Id: <1518598487-29201-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmc0_pins_a were renamed in arch/arm but not in arch/arm64 resulting in
a build failure.

Fixes: 813f2c8fa119 ("ARM: dts: sunxi: h3-h5: rename mmc0_pins_a and mmc1_pins_a")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
index feee125a4e9a..87c1a0dace5f 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-zero-plus2.dts
@@ -82,7 +82,7 @@
 
 &mmc1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&mmc1_pins_a>;
+	pinctrl-0 = <&mmc1_pins>;
 	vmmc-supply = <&reg_vcc3v3>;
 	vqmmc-supply = <&reg_vcc3v3>;
 	mmc-pwrseq = <&wifi_pwrseq>;
-- 
2.13.6
