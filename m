Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932447AbeCIRYK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:24:10 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:38951 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932299AbeCIRYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:24:07 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180309172406epoutp016664caacaa259efdd014c07c8acb4899~aUGtSRbhN1630016300epoutp01Z
X-AuditID: b6c32a38-adbff70000001054-12-5aa2c33537fd
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: krzk@kernel.org
Cc: kgene@kernel.org, devicetree@vger.kernel.org, javierm@redhat.com,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 2/6] ARM: dts: exynos: Add audio clocks configuration for
 exynos5250-snow
Date: Fri, 09 Mar 2018 18:22:46 +0100
Message-id: <20180309172250.23019-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.14.2
In-reply-to: <20180309172250.23019-1-s.nawrocki@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCmga7p4UVRBvd+qltsnLGe1WL+kXOs
        FgunLWe06H/8mtni/PkN7BabHl9jtbi8aw6bxYzz+5gs1h65y25x+E07qwOXx6ZVnWwem5fU
        e7zfd5XNo2/LKkaPz5vkAlijuGxSUnMyy1KL9O0SuDImf4wquMVV8eDhOfYGxs8cXYycHBIC
        JhJ/v39j6mLk4hAS2MEo8fPCGTYI5zujxP4nx1hgqho2/WOGSGxglHgzZwVUyy9GiWOfVrGD
        VLEJGEr0Hu1jBLFFBIQl7i1dDhZnFpjEJDFrviyILSwQJ9F5fhrYVBYBVYkF+5eD2bwC1hKT
        dpxkhNgmL/F+wX0wm1PARmLJzMNsEPEFbBJ3WsshbBeJP1seQ10nLPHq+BagXRxAtrTEpaO2
        EOFqic62LnaQOyUEWhgl/ky7BDXHWuLw8YusELfxSbz72sMK0csr0dEmBFHiIdG7qxHqHEeJ
        Y6emskP8288oMWvlW7YJjFILGBlWMYqlFhTnpqcWGxaY6BUn5haX5qXrJefnbmIEx6uWxQ7G
        Ped8DjEKcDAq8fDumLooSog1say4MvcQowQHs5II7/saoBBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXHegACXKCGB9MSS1OzU1ILUIpgsEwenVANjD1fBK4E9d8MaO/wY2ee2esc+e/7/QH5MdHuX
        ycrlm6IjRZTF3oiorrxwU+F1uVDkrc/9UpujGnZZ2bgrVkcYbd07Sfl2+ZbFAsbzeZapqPnM
        d1WKinVovCFW6DQxNcrc/cd+5TV9jz1cE4yLvM+sXFjV4f501z/ZqXv4j1hOkAjrWFWx5ZYS
        S3FGoqEWc1FxIgAfjZ7S0wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsVy+t9jQV3jw4uiDK5Os7bYOGM9q8X8I+dY
        LRZOW85o0f/4NbPF+fMb2C02Pb7GanF51xw2ixnn9zFZrD1yl93i8Jt2Vgcuj02rOtk8Ni+p
        93i/7yqbR9+WVYwenzfJBbBGcdmkpOZklqUW6dslcGVM/hhVcIur4sHDc+wNjJ85uhg5OSQE
        TCQaNv1j7mLk4hASWMcocWjrExYI5xejxLGve1lBqtgEDCV6j/YxgtgiAsIS95YuZwcpYhaY
        xCTRtPMnWEJYIE6i8/w0FhCbRUBVYsH+5WA2r4C1xKQdJxkh1slLvF9wH8zmFLCRWDLzMFsX
        IwfQNmuJrccCJjDyLGBkWMUomVpQnJueW2xUYJiXWq5XnJhbXJqXrpecn7uJERhg2w5r9e1g
        vL8k/hCjAAejEg+vwIxFUUKsiWXFlbmHGCU4mJVEeN/XAIV4UxIrq1KL8uOLSnNSiw8xSnOw
        KInz3s47FikkkJ5YkpqdmlqQWgSTZeLglGpglLlTLrHiRtLBbgWOB8WBPPt3tbeErpNkVv3/
        OP9gmm5R9tH0eJkZ85RcFZOi/+42XhZ+4pjnxG7R478Kp5lH3byVO+/lDR/mhXsn/V9h55+4
        Kok59zqbeaxsXMbxvuAf68UVK1tnCaz7JKjkcf0Rt6WvK8NXBa5NkQrvz7nPLY13mD0nPPSw
        EktxRqKhFnNRcSIAY1FHhiwCAAA=
X-CMS-MailID: 20180309172404epcas1p446cf7033027ccefe2d8cfcfc49edc179
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180309172404epcas1p446cf7033027ccefe2d8cfcfc49edc179
X-RootMTR: 20180309172404epcas1p446cf7033027ccefe2d8cfcfc49edc179
References: <20180309172250.23019-1-s.nawrocki@samsung.com>
        <CGME20180309172404epcas1p446cf7033027ccefe2d8cfcfc49edc179@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the audio subsystem clocks are not configured properly on Snow
and sound is not working. The MAX98095 CODEC is not getting its master clock
on the MCLK pin connected to the SOC's CLKOUT GPIO. This patch adds CLKOUT
and other clocks configuration so HDMI audio can also be supported.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v1:
 - edited commit summary line.
---
 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index 59cf1b202849..bdf59dd3654b 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -225,6 +225,16 @@
 	};
 };
 
+&clock {
+	assigned-clocks = <&clock CLK_FOUT_EPLL>;
+	assigned-clock-rates = <49152000>;
+};
+
+&clock_audss {
+	assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>;
+	assigned-clock-parents = <&clock CLK_FOUT_EPLL>;
+};
+
 &cpu0 {
 	cpu0-supply = <&buck2_reg>;
 };
@@ -649,6 +659,11 @@
 	};
 };
 
+&pmu_system_controller {
+	assigned-clocks = <&pmu_system_controller 0>;
+	assigned-clock-parents = <&clock CLK_FIN_PLL>;
+};
+
 &rtc {
 	status = "okay";
 	clocks = <&clock CLK_RTC>, <&max77686 MAX77686_CLK_AP>;
-- 
2.14.2
