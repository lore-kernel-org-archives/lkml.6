Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933449AbeCFOp2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:45:28 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:38709 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933206AbeCFOpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:45:20 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180306144518epoutp03ab1aa7286f91c9c15e880a1323946acd~ZXAM2-y-g1892618926epoutp03_
X-AuditID: b6c32a37-44bff70000001029-f7-5a9ea97d0a36
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 11/12] dt-bindings: thermal: remove no longer needed samsung
 thermal properties
Date: Tue, 06 Mar 2018 15:43:54 +0100
Message-id: <1520347435-22970-12-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsWy7bCmrm7tynlRBlc2qVpsnLGe1WL+kXNA
        4so1Vov+x6+ZLc6f38BusekxkHt51xw2i8+9RxgtZpzfx2RxaOpeRoul1y8yWbTuPcJu8eRh
        H5sDr8eaeWsYPS5fu8jssXPWXXaPxXteMnlsWtXJ5rF5Sb1H35ZVjB6fN8kFcERx2aSk5mSW
        pRbp2yVwZfy+uYi54LJExfmuu8wNjIdEuhg5OSQETCRWHdzH1sXIxSEksINR4mfHJhYI5zuj
        xPbl79lgqm5N/c8KkdjNKNHxczlU1S9Gib/T25lAqtgErCQmtq9iBLFFBEokpq3qZQQpYhY4
        yySxY/s7FpCEsECixKrGw2BjWQRUJc5NWABm8wp4SsxtOs0EsU5O4uSxyawgNidQ/ETHObAD
        JQROsElsvPKBEaLIReL7zy4oW1ji1fEt7F2MHEC2tMSlo7YQ9c2MEt927GGGqJnAKLFnvRCE
        bS1x+PhFsAXMAnwS7772sEL08kp0tEGVeEhM+LoOqtVR4s3Pj0wQH89hlLjy5i3rBEapBYwM
        qxjFUguKc9NTiw0LjPWKE3OLS/PS9ZLzczcxgiNey3wH44ZzPocYBTgYlXh4N3jMjRJiTSwr
        rsw9xCjBwawkwhuhPy9KiDclsbIqtSg/vqg0J7X4EKM0B4uSOG9AgEuUkEB6YklqdmpqQWoR
        TJaJg1OqgXHR2yz9a4rNburtRxn5z3SxLCmQ/pkxM9H0XuUr9ou9F9zn/PzIYzOBYfJuoZtL
        HZ2y/r7X63c6LdjauyPeyiL01O0Cz4f3QzkOnprZuGznamUO26Se6D2aeotTtlp6L/z+bvuG
        aCuZi7t45/xYsWhxyKeZ/w79+/vjl9PvuzM6CjUED32dEL1ViaU4I9FQi7moOBEA0jlRGvQC
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsVy+t9jAd2alfOiDG5vFrDYOGM9q8X8I+eA
        xJVrrBb9j18zW5w/v4HdYtNjIPfyrjlsFp97jzBazDi/j8ni0NS9jBZLr19ksmjde4Td4snD
        PjYHXo8189Ywely+dpHZY+esu+wei/e8ZPLYtKqTzWPzknqPvi2rGD0+b5IL4IjisklJzcks
        Sy3St0vgyvh9cxFzwWWJivNdd5kbGA+JdDFyckgImEjcmvqftYuRi0NIYCejxO7br5ggnF+M
        Egcu3WQBqWITsJKY2L6KEcQWESiR6Jz2mhnEZhY4yyRx8D8HiC0skCixqvEwG4jNIqAqcW7C
        AjCbV8BTYm7TaSaIbXISJ49NZgWxOYHiJzrOgdUICXhILO7+zTaBkWcBI8MqRsnUguLc9Nxi
        owLDvNRyveLE3OLSvHS95PzcTYzA8Nx2WKtvB+P9JfGHGAU4GJV4eDd4zI0SYk0sK67MPcQo
        wcGsJMIboT8vSog3JbGyKrUoP76oNCe1+BCjNAeLkjjv7bxjkUIC6YklqdmpqQWpRTBZJg5O
        qQbGiVF7N4hvr6ueWraVP/9U6Bsn069/1kyX/XuQL+9mn+Lz67Vn+sTNxTszZLxn3r/++94Z
        7oWLLHplTRmenb7EN/lr4R/l1UdDpt+ZoNP66pa2SEDEsY3M/5acNZQSyFi11KAy2uvbqS0m
        U6ZlTv7EtfbzQaldghZr9m6VNBXfELBWuuT+dKWsqUosxRmJhlrMRcWJADTuoOVLAgAA
X-CMS-MailID: 20180306144516epcas1p3e951e15e666779c870ad091d65041409
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180306144516epcas1p3e951e15e666779c870ad091d65041409
X-RootMTR: 20180306144516epcas1p3e951e15e666779c870ad091d65041409
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180306144516epcas1p3e951e15e666779c870ad091d65041409@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove documentation for longer needed samsung thermal properties.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 .../devicetree/bindings/thermal/exynos-thermal.txt | 23 +++++-----------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
index 1b596fd..b957acf 100644
--- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
@@ -49,19 +49,6 @@ on the SoC (only first trip points defined in DT will be configured):
  - samsung,exynos5433-tmu: 8
  - samsung,exynos7-tmu: 8
 
-Following properties are mandatory (depending on SoC):
-- samsung,tmu_gain: Gain value for internal TMU operation.
-- samsung,tmu_reference_voltage: Value of TMU IP block's reference voltage
-- samsung,tmu_noise_cancel_mode: Mode for noise cancellation
-- samsung,tmu_efuse_value: Default level of temperature - it is needed when
-			   in factory fusing produced wrong value
-- samsung,tmu_min_efuse_value: Minimum temperature fused value
-- samsung,tmu_max_efuse_value: Maximum temperature fused value
-- samsung,tmu_first_point_trim: First point trimming value
-- samsung,tmu_second_point_trim: Second point trimming value
-- samsung,tmu_default_temp_offset: Default temperature offset
-- samsung,tmu_cal_type: Callibration type
-
 ** Optional properties:
 
 - vtmu-supply: This entry is optional and provides the regulator node supplying
@@ -78,7 +65,7 @@ Example 1):
 		clocks = <&clock 383>;
 		clock-names = "tmu_apbif";
 		vtmu-supply = <&tmu_regulator_node>;
-		#include "exynos4412-tmu-sensor-conf.dtsi"
+		#thermal-sensor-cells = <0>;
 	};
 
 Example 2):
@@ -89,7 +76,7 @@ Example 2):
 		interrupts = <0 58 0>;
 		clocks = <&clock 21>;
 		clock-names = "tmu_apbif";
-		#include "exynos5440-tmu-sensor-conf.dtsi"
+		#thermal-sensor-cells = <0>;
 	};
 
 Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
@@ -99,7 +86,7 @@ Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
 		interrupts = <0 184 0>;
 		clocks = <&clock 318>, <&clock 318>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-		#include "exynos4412-tmu-sensor-conf.dtsi"
+		#thermal-sensor-cells = <0>;
 	};
 
 	tmu_cpu3: tmu@1006c000 {
@@ -108,7 +95,7 @@ Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
 		interrupts = <0 185 0>;
 		clocks = <&clock 318>, <&clock 319>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-		#include "exynos4412-tmu-sensor-conf.dtsi"
+		#thermal-sensor-cells = <0>;
 	};
 
 	tmu_gpu: tmu@100a0000 {
@@ -117,7 +104,7 @@ Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
 		interrupts = <0 215 0>;
 		clocks = <&clock 319>, <&clock 318>;
 		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
-		#include "exynos4412-tmu-sensor-conf.dtsi"
+		#thermal-sensor-cells = <0>;
 	};
 
 Note: For multi-instance tmu each instance should have an alias correctly
-- 
1.9.1
