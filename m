Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754497AbeDPKOt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:14:49 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:32281 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754362AbeDPKOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:14:31 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180416101429epoutp03f8e431ab3e3e53abdded8e116c5a7f78~l4wdF9Fhw1184611846epoutp039
X-AuditID: b6c32a39-591ff70000000ff4-b9-5ad4778549fe
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 14/14] arm64: dts: exynos: remove no longer needed samsung
 thermal properties
Date: Mon, 16 Apr 2018 12:12:05 +0200
Message-id: <1523873525-23718-15-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7bCmrm5r+ZUogx23OS02zljPajHvs6zF
        /CvXWC36H79mtjh/fgO7xeVdc9gsPvceYbSYcX4fk8WTh31sDpweO2fdZfdYvOclk8emVZ1s
        Hneu7WHz6NuyitHj8ya5ALYoLpuU1JzMstQifbsEroy3SxpYC5boVFw48pStgfGRahcjJ4eE
        gInE9w2LmLsYuTiEBHYwSqy4eJUdwvnOKNH9pp8NpmrtpK2MEIkNjBItJ25AOb8YJZbu/csK
        UsUmYCUxsX0VI4gtIqAlceLSdiaQImaBCUwST1/NBBslLBAv8ff7eyYQm0VAVeLWlSVgzbwC
        nhLtm84zQayTkzh5bDJYnBMo3rTmGhvIIAmBJWwSF19NYIEocpHoal/HCGELS7w6vgXocA4g
        W1ri0lFbiPpmRolvO/YwQ9RMYJTYs14IwraWOHz8ItgCZgE+iXdfe1ghenklOtqgSjwkdl+7
        C9XqKLHo4gVoIM1hlNg88w/jBEapBYwMqxjFUguKc9NTiw0LTPWKE3OLS/PS9ZLzczcxgqNW
        y3IH47FzPocYBTgYlXh4d5y9HCXEmlhWXJl7iFGCg1lJhHdZIlCINyWxsiq1KD++qDQntfgQ
        ozQHi5I471OfM1FCAumJJanZqakFqUUwWSYOTqkGxrWNOxn+aj6a87x+T4M8B9vM/vdtqy/P
        aOBdGnenZofLK+/Q7btF9Dj/3OyrSf7yrWeFazyDSaDVvDdVCnks39ZEVDA2beoWyrxT/dXS
        YlPn56OtiZPLL14rdq19VKN8tOL/dN6H79ISgs7ZzzpcMVOLubEn8cNFX84kh+WNZutYith+
        aKmsUWIpzkg01GIuKk4EADhwAtPWAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t9jQd2W8itRBqfXGFlsnLGe1WLeZ1mL
        +VeusVr0P37NbHH+/AZ2i8u75rBZfO49wmgx4/w+JosnD/vYHDg9ds66y+6xeM9LJo9NqzrZ
        PO5c28Pm0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBlvlzSwFizRqbhw5ClbA+Mj1S5GTg4J
        AROJtZO2MnYxcnEICaxjlJh68SozhPOLUaKv6zczSBWbgJXExPZVjCC2iICWxIlL25lAipgF
        JjBJLFm7iB0kISwQL/H3+3smEJtFQFXi1pUlrCA2r4CnRPum80wQ6+QkTh6bDBbnBIo3rbnG
        BmILCXhINE68yjiBkWcBI8MqRsnUguLc9NxiowLDvNRyveLE3OLSvHS95PzcTYzAINt2WKtv
        B+P9JfGHGAU4GJV4eHecvRwlxJpYVlyZe4hRgoNZSYR3WSJQiDclsbIqtSg/vqg0J7X4EKM0
        B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBsYtFb+CHRfP3Xyug++6n86X3WmJ1xO87nJ8
        9jneuTTUdTpnjzn/5PmNv7vnen6Tlv3uyLy0TkDZRn263b4/OdtZ4o9e02krMP9pp+57k79b
        3furyuNgG497S8Q439oJnCzw7m72vtr4adrqDdGi9V7cG1klsn/Efpml+PjOGR4XlpQjvc+Y
        tiixFGckGmoxFxUnAgBoZo+lLgIAAA==
X-CMS-MailID: 20180416101428epcas1p1d9646bf1b56f0512a3fa3a6301b793c6
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180416101428epcas1p1d9646bf1b56f0512a3fa3a6301b793c6
X-RootMTR: 20180416101428epcas1p1d9646bf1b56f0512a3fa3a6301b793c6
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101428epcas1p1d9646bf1b56f0512a3fa3a6301b793c6@epcas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove no longer needed samsung thermal properties.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi  | 20 --------------------
 .../boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi | 19 -------------------
 arch/arm64/boot/dts/exynos/exynos5433.dtsi          | 10 +++++-----
 .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi    | 21 ---------------------
 arch/arm64/boot/dts/exynos/exynos7.dtsi             |  2 +-
 5 files changed, 6 insertions(+), 66 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
deleted file mode 100644
index f080357..0000000
--- a/arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device tree sources for Exynos5433 TMU sensor configuration
- *
- * Copyright (c) 2016 Jonghwa Lee <jonghwa3.lee@samsung.com>
- */
-
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-#thermal-sensor-cells = <0>;
-samsung,tmu_gain = <8>;
-samsung,tmu_reference_voltage = <23>;
-samsung,tmu_noise_cancel_mode = <4>;
-samsung,tmu_efuse_value = <75>;
-samsung,tmu_min_efuse_value = <40>;
-samsung,tmu_max_efuse_value = <150>;
-samsung,tmu_first_point_trim = <25>;
-samsung,tmu_second_point_trim = <85>;
-samsung,tmu_default_temp_offset = <50>;
-samsung,tmu_mux_addr = <6>;
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
deleted file mode 100644
index cccae66..0000000
--- a/arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
+++ /dev/null
@@ -1,19 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device tree sources for Exynos5433 TMU sensor configuration
- *
- * Copyright (c) 2016 Chanwoo Choi <cw00.choi@samsung.com>
- */
-
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-#thermal-sensor-cells = <0>;
-samsung,tmu_gain = <8>;
-samsung,tmu_reference_voltage = <16>;
-samsung,tmu_noise_cancel_mode = <4>;
-samsung,tmu_efuse_value = <75>;
-samsung,tmu_min_efuse_value = <40>;
-samsung,tmu_max_efuse_value = <150>;
-samsung,tmu_first_point_trim = <25>;
-samsung,tmu_second_point_trim = <85>;
-samsung,tmu_default_temp_offset = <50>;
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index c0231d0..c414a27 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -637,7 +637,7 @@
 			clocks = <&cmu_peris CLK_PCLK_TMU0_APBIF>,
 				<&cmu_peris CLK_SCLK_TMU0>;
 			clock-names = "tmu_apbif", "tmu_sclk";
-			#include "exynos5433-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 			status = "disabled";
 		};
 
@@ -648,7 +648,7 @@
 			clocks = <&cmu_peris CLK_PCLK_TMU0_APBIF>,
 				<&cmu_peris CLK_SCLK_TMU0>;
 			clock-names = "tmu_apbif", "tmu_sclk";
-			#include "exynos5433-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 			status = "disabled";
 		};
 
@@ -659,7 +659,7 @@
 			clocks = <&cmu_peris CLK_PCLK_TMU1_APBIF>,
 				<&cmu_peris CLK_SCLK_TMU1>;
 			clock-names = "tmu_apbif", "tmu_sclk";
-			#include "exynos5433-tmu-g3d-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 			status = "disabled";
 		};
 
@@ -670,7 +670,7 @@
 			clocks = <&cmu_peris CLK_PCLK_TMU1_APBIF>,
 				<&cmu_peris CLK_SCLK_TMU1>;
 			clock-names = "tmu_apbif", "tmu_sclk";
-			#include "exynos5433-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 			status = "disabled";
 		};
 
@@ -681,7 +681,7 @@
 			clocks = <&cmu_peris CLK_PCLK_TMU1_APBIF>,
 				<&cmu_peris CLK_SCLK_TMU1>;
 			clock-names = "tmu_apbif", "tmu_sclk";
-			#include "exynos5433-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi b/arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
deleted file mode 100644
index 4849471..0000000
--- a/arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device tree sources for Exynos7 TMU sensor configuration
- *
- * Copyright (c) 2016 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- */
-
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-#thermal-sensor-cells = <0>;
-samsung,tmu_gain = <9>;
-samsung,tmu_reference_voltage = <17>;
-samsung,tmu_noise_cancel_mode = <4>;
-samsung,tmu_efuse_value = <75>;
-samsung,tmu_min_efuse_value = <15>;
-samsung,tmu_max_efuse_value = <100>;
-samsung,tmu_first_point_trim = <25>;
-samsung,tmu_second_point_trim = <85>;
-samsung,tmu_default_temp_offset = <50>;
-samsung,tmu_cal_type = <TYPE_ONE_POINT_TRIMMING>;
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index ad9dce6..8834879 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -589,7 +589,7 @@
 			clocks = <&clock_peris PCLK_TMU>,
 				 <&clock_peris SCLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_sclk";
-			#include "exynos7-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		thermal-zones {
-- 
1.9.1
