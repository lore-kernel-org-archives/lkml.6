Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755373AbeBOKKk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 05:10:40 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40575 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755240AbeBOKKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 05:10:38 -0500
X-Google-Smtp-Source: AH8x226VCVnXbgBkDstuj99ydgrWDY+bpTxq9UPlAxMXnJDMWymEw3reaMui+LKf2Qw+rSaO3t1kfA==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson-axg: fix pwm_AO_cd compatible
Date: Thu, 15 Feb 2018 11:10:31 +0100
Message-Id: <20180215101031.18934-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible in pwm_AO_cd is wrong and does not match anything.
Correct this with the correct compatible string

Fixes: 4a81e5ddfb43 ("ARM64: dts: meson-axg: add PWM DT info for Meson-Axg SoC")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index a7cc9e401a92..880e25b113c1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -844,7 +844,7 @@
 			};
 
 			pwm_AO_cd: pwm@2000 {
-				compatible = "amlogic,axg-ao-pwm";
+				compatible = "amlogic,meson-axg-ao-pwm";
 				reg = <0x0 0x02000  0x0 0x20>;
 				#pwm-cells = <3>;
 				status = "disabled";
-- 
2.14.3
