Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754402AbeDPKOe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:14:34 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:61975 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754295AbeDPKO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:14:29 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180416101427epoutp011bea249b37f6caa0d1a90d643aaa8f1d~l4wbeGtuR2791827918epoutp01S
X-AuditID: b6c32a35-139ff70000000fee-72-5ad477823c9c
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 13/14] ARM: dts: exynos: remove no longer needed samsung
 thermal properties
Date: Mon, 16 Apr 2018 12:12:04 +0200
Message-id: <1523873525-23718-14-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCmvm5T+ZUog4PPpC02zljPajHvs6zF
        /CvXWC36H79mtjh/fgO7xeVdc9gsPvceYbSYcX4fk8WTh31sDpweO2fdZfdYvOclk8emVZ1s
        Hneu7WHz6NuyitHj8ya5ALYoLpuU1JzMstQifbsErow1fZdZCu64VUyctZGxgfGMVRcjB4eE
        gInE/O2xXYxcHEICOxglTjyaywLhfGeU+HV4PRNMUcNTfYj4BkaJtVN+M0M4vxglpj5dzNjF
        yMnBJmAlMbF9FZgtIqAlceLSdiaQImaBCUwST1/NZAOZJCwQK7GzPxOkhkVAVeLw6UesIGFe
        AU+JlQ2xIGEJATmJk8cms4LYnEDhpjXX2EDGSAgsYZOY8WUnG0SRi8TcqauhbGGJV8e3sEMc
        Ki1x6agtRH0zo8S3HXuYIWomMErsWS8EYVtLHD5+EWwBswCfxLuvPawQvbwSHW1QJR4S09u3
        sUDYjhL3jy5lgvh3DqPEn19NTBMYpRYwMqxiFEstKM5NTy02LDDUK07MLS7NS9dLzs/dxAiO
        Vi3THYxTzvkcYhTgYFTi4d1x9nKUEGtiWXFl7iFGCQ5mJRHeZYlAId6UxMqq1KL8+KLSnNTi
        Q4zSHCxK4rxPfc5ECQmkJ5akZqemFqQWwWSZODilGhhDF/Dt/b5rrviiZGGlH93RVzPfZfS+
        OedxsH/5B6X3DMWcf7qOMT69kFLCw3fo5qVpQUqvpr263n24oa35LvOx1wG3owX1HGeHW8Sy
        MaqXbV2gYnhm49L2c4KBB7eoL5oq3Mne2dt5vkLOQVDSMn5LuYTO+6qf+/6ZLBTeuNhmg6+z
        zuXpybuUWIozEg21mIuKEwEJHgbB0gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsVy+t9jQd3G8itRBvcuaFhsnLGe1WLeZ1mL
        +VeusVr0P37NbHH+/AZ2i8u75rBZfO49wmgx4/w+JosnD/vYHDg9ds66y+6xeM9LJo9NqzrZ
        PO5c28Pm0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBlr+i6zFNxxq5g4ayNjA+MZqy5GDg4J
        AROJhqf6XYxcHEIC6xglzu/Yywrh/GKU+PxtHWMXIycHm4CVxMT2VWC2iICWxIlL25lAipgF
        JjBJLFm7iB1kkrBArMTO/kyQGhYBVYnDpx+xgoR5BTwlVjbEgoQlBOQkTh6bzApicwKFm9Zc
        YwOxhQQ8JBonXmWcwMizgJFhFaNkakFxbnpusVGBYV5quV5xYm5xaV66XnJ+7iZGYHhtO6zV
        t4Px/pL4Q4wCHIxKPLw7zl6OEmJNLCuuzD3EKMHBrCTCuywRKMSbklhZlVqUH19UmpNafIhR
        moNFSZz3dt6xSCGB9MSS1OzU1ILUIpgsEwenVAMjl/INs96HrwTFRBar1rYGiL1vXaif2Ve6
        2+HslImTn9cfPtauXOT51uf0odcOl3dLvjF+633jWOWWgOuf46aVH7Jj/vTp/C5H+40fLDr/
        9CqbTJ6bar5rh3o6e/u0Hzd3z+OvMpzw6gXjnd0aoWsv3GA59cNDV/2g+FI5BxmzbcumO18R
        qmnnVmIpzkg01GIuKk4EAOR+wUsrAgAA
X-CMS-MailID: 20180416101425epcas1p46ab4d827e3a64c5c16b32a17f63dd9d0
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180416101425epcas1p46ab4d827e3a64c5c16b32a17f63dd9d0
X-RootMTR: 20180416101425epcas1p46ab4d827e3a64c5c16b32a17f63dd9d0
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101425epcas1p46ab4d827e3a64c5c16b32a17f63dd9d0@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove no longer needed samsung thermal properties.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/boot/dts/exynos3250.dtsi                 |  2 +-
 arch/arm/boot/dts/exynos4.dtsi                    |  2 +-
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi | 20 --------------------
 arch/arm/boot/dts/exynos5250.dtsi                 |  2 +-
 arch/arm/boot/dts/exynos5410.dtsi                 |  8 ++++----
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi | 21 ---------------------
 arch/arm/boot/dts/exynos5420.dtsi                 | 10 +++++-----
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi | 20 --------------------
 arch/arm/boot/dts/exynos5440.dtsi                 |  6 +++---
 9 files changed, 15 insertions(+), 76 deletions(-)
 delete mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index 0a5f989..d6e014f 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -227,7 +227,7 @@
 			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cmu CLK_TMU_APBIF>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 909a9f2..ca1921d 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -736,7 +736,7 @@
 			reg = <0x100C0000 0x100>;
 			interrupts = <2 4>;
 			status = "disabled";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		jpeg_codec: jpeg-codec@11840000 {
diff --git a/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi b/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
deleted file mode 100644
index 489b58c..0000000
--- a/arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device tree sources for Exynos4412 TMU sensor configuration
- *
- * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
- */
-
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-#thermal-sensor-cells = <0>;
-samsung,tmu_gain = <8>;
-samsung,tmu_reference_voltage = <16>;
-samsung,tmu_noise_cancel_mode = <4>;
-samsung,tmu_efuse_value = <55>;
-samsung,tmu_min_efuse_value = <40>;
-samsung,tmu_max_efuse_value = <100>;
-samsung,tmu_first_point_trim = <25>;
-samsung,tmu_second_point_trim = <85>;
-samsung,tmu_default_temp_offset = <50>;
-samsung,tmu_cal_type = <TYPE_ONE_POINT_TRIMMING>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 45283a6..45242ba 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -282,7 +282,7 @@
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		sata: sata@122f0000 {
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 55509c6..b8b68ec 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -93,7 +93,7 @@
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu1: tmu@10064000 {
@@ -102,7 +102,7 @@
 			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu2: tmu@10068000 {
@@ -111,7 +111,7 @@
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu3: tmu@1006c000 {
@@ -120,7 +120,7 @@
 			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos4412-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		mmc_0: mmc@12200000 {
diff --git a/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi b/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
deleted file mode 100644
index fbc77cb..0000000
--- a/arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device tree sources for Exynos5420 TMU sensor configuration
- *
- * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
- * Copyright (c) 2017 Krzysztof Kozlowski <krzk@kernel.org>
- */
-
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-#thermal-sensor-cells = <0>;
-samsung,tmu_gain = <8>;
-samsung,tmu_reference_voltage = <16>;
-samsung,tmu_noise_cancel_mode = <4>;
-samsung,tmu_efuse_value = <55>;
-samsung,tmu_min_efuse_value = <0>;
-samsung,tmu_max_efuse_value = <100>;
-samsung,tmu_first_point_trim = <25>;
-samsung,tmu_second_point_trim = <85>;
-samsung,tmu_default_temp_offset = <50>;
-samsung,tmu_cal_type = <TYPE_ONE_POINT_TRIMMING>;
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 2f3cb2a..85d8656 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -722,7 +722,7 @@
 			interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu1: tmu@10064000 {
@@ -731,7 +731,7 @@
 			interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>;
 			clock-names = "tmu_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu2: tmu@10068000 {
@@ -740,7 +740,7 @@
 			interrupts = <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>, <&clock CLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_cpu3: tmu@1006c000 {
@@ -749,7 +749,7 @@
 			interrupts = <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU>, <&clock CLK_TMU_GPU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmu_gpu: tmu@100a0000 {
@@ -758,7 +758,7 @@
 			interrupts = <GIC_SPI 215 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_TMU_GPU>, <&clock CLK_TMU>;
 			clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-			#include "exynos5420-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		sysmmu_g2dr: sysmmu@0x10A60000 {
diff --git a/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi b/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
deleted file mode 100644
index 0421c3d..0000000
--- a/arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device tree sources for Exynos5440 TMU sensor configuration
- *
- * Copyright (c) 2014 Lukasz Majewski <l.majewski@samsung.com>
- */
-
-#include <dt-bindings/thermal/thermal_exynos.h>
-
-#thermal-sensor-cells = <0>;
-samsung,tmu_gain = <5>;
-samsung,tmu_reference_voltage = <16>;
-samsung,tmu_noise_cancel_mode = <4>;
-samsung,tmu_efuse_value = <0x5d2d>;
-samsung,tmu_min_efuse_value = <16>;
-samsung,tmu_max_efuse_value = <76>;
-samsung,tmu_first_point_trim = <25>;
-samsung,tmu_second_point_trim = <70>;
-samsung,tmu_default_temp_offset = <25>;
-samsung,tmu_cal_type = <TYPE_ONE_POINT_TRIMMING>;
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index f3abecc4..a6323a4 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -234,7 +234,7 @@
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_B_125>;
 			clock-names = "tmu_apbif";
-			#include "exynos5440-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmuctrl_1: tmuctrl@16011c {
@@ -243,7 +243,7 @@
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_B_125>;
 			clock-names = "tmu_apbif";
-			#include "exynos5440-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		tmuctrl_2: tmuctrl@160120 {
@@ -252,7 +252,7 @@
 			interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clock CLK_B_125>;
 			clock-names = "tmu_apbif";
-			#include "exynos5440-tmu-sensor-conf.dtsi"
+			#thermal-sensor-cells = <0>;
 		};
 
 		sata@210000 {
-- 
1.9.1
