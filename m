Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeBWGme (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 01:42:34 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:32945 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751402AbeBWGln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 01:41:43 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180223064141epoutp01a41d27c164f81d070c68e8dd8be7f1d2~V4Tz55Nfc3131431314epoutp015
X-AuditID: b6c32a48-9adff70000000ff0-f0-5a8fb7a45bcd
From: Jaehoon Chung <jh80.chung@samsung.com>
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        manabian@gmail.com, dinguyen@kernel.org, will.deacon@arm.com,
        xuwei5@hisilicon.com, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 3/6] ARM: dts: socfpga: remove 'num-slots' property for
 dwmmc
Date: Fri, 23 Feb 2018 15:41:35 +0900
Message-id: <20180223064138.18401-3-jh80.chung@samsung.com>
X-Mailer: git-send-email 2.15.1
In-reply-to: <20180223064138.18401-1-jh80.chung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7bCmhe7S7f1RBu2bmSzmHznHanH0/G4m
        ixu/2lgtLu+aw2Zx5H8/o8Xu6+cYLZZev8hk0br3CLvF8bXhFi8/nmCxeHJ0CrMDt8eaeWsY
        PXbOusvu8XjuRnaPTas62TzuXNvD5tG3ZRWjx+dNcgHsUak2GamJKalFCql5yfkpmXnptkre
        wfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUA3KimUJeaUAoUCEouLlfTtbIryS0tSFTLy
        i0tslaINDY30DA3M9YyMjPRMjGOtjEyBShJSM/befsZU8JavYt+0XuYGxtk8XYycHBICJhKz
        2s8zdTFycQgJ7GCUuDHhBCuE851R4u7yJlaYqv8zprJDJDYwSlxbfY0FwvnBKDHr4jomkCo2
        AR2J7d+Og9kiApES81cdZgYpYhY4wihx+eFtIIeDQ1jAX+LpA2kQk0VAVeLgAQ2Qcl4Ba4lX
        l8+wQyyTl5iwpYkFxOYUsJGY8OcF2C4JgR1sEh27nrJAFLlInLz1Cuo6YYlXx7dANUtLPFu1
        kRHCbmeUODtbGKJ5CqPEihndTBAJY4lnC7vAbGYBPomOw3/ZQQ6SEOCV6GgTgijxkNj59iMb
        hO0ocXzFd6iH+xklnrbsYJrAKLWAkWEVo1hqQXFuemqxUYGJXnFibnFpXrpecn7uJkZwGtLy
        2MF44JzPIUYBDkYlHt6Ikt4oIdbEsuLK3EOMEhzMSiK8Dqv6o4R4UxIrq1KL8uOLSnNSiw8x
        mgLDZiKzlGhyPjBF5pXEG5pYGpiYmRmZm1kAk4M4b1uAS5SQQHpiSWp2ampBahFMHxMHp1QD
        o/L8hatVmdvFHMO1vSYu//GI8+Q9Ow2mKxqFB9LYVMS8Fig8fygwfU51ztuV1X0Om16feZK+
        TW3+Nt5/N1u/bX6uLLsw4uyiD7bH85cGpLSLcSRzX6s8Oy9pdxjzr9LzzrtrLYrsbO4atk55
        8tr2+d2GswGTUlQOJk2S/VW2uHi6nHRcg1XhdiWW4oxEQy3mouJEAEf1WEdZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsVy+t9jQd0l2/ujDHa95beYf+Qcq8XR87uZ
        LG78amO1uLxrDpvFkf/9jBa7r59jtFh6/SKTReveI+wWx9eGW7z8eILF4snRKcwO3B5r5q1h
        9Ng56y67x+O5G9k9Nq3qZPO4c20Pm0ffllWMHp83yQWwR3HZpKTmZJalFunbJXBl7L39jKng
        LV/Fvmm9zA2Ms3m6GDk5JARMJP7PmMrexcjFISSwjlFi0ZxfjBDOD0aJHT2N7CBVbAI6Etu/
        HWcCsUUEIiUO/J7CBFLELHCEUWLnhqlADgeHsICvxM1JMSAmi4CqxMEDGiDlvALWEq8un2GH
        WCYvMWFLEwuIzSlgIzHhzwswWwio5t353ywTGHkWMDKsYpRMLSjOTc8tNiowykst1ytOzC0u
        zUvXS87P3cQIDL9th7X6dzA+XhJ/iFGAg1GJhzeipDdKiDWxrLgy9xCjBAezkgivw6r+KCHe
        lMTKqtSi/Pii0pzU4kOM0hwsSuK8/PnHIoUE0hNLUrNTUwtSi2CyTBycUg2MIsrphtejYv4s
        n7uX+430vjB1re/fpp9aHtB95euDj5oxeYu8V6amnLlVneESecE+saHRZEdS/4vr255Mjkz+
        vv9/+ZcDtX+6M5IflD6NW1LdVdPQ0xCXMMvrwYXVAbf/3vtxVP9XoYe+q8TeqR3Xeywcw/e9
        bLxZOd+iZneX9Brp9aEPs+YUKbEUZyQaajEXFScCAN2FrFc7AgAA
X-CMS-MailID: 20180223064140epcas2p2145faef6a2c44d7d20bb3d6099f12d18
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180223064140epcas2p2145faef6a2c44d7d20bb3d6099f12d18
X-RootMTR: 20180223064140epcas2p2145faef6a2c44d7d20bb3d6099f12d18
References: <20180223064138.18401-1-jh80.chung@samsung.com>
        <CGME20180223064140epcas2p2145faef6a2c44d7d20bb3d6099f12d18@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 'num-slots' had already deprecated, remove the property in
device-tree file.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts | 1 -
 arch/arm/boot/dts/socfpga_arria5.dtsi             | 1 -
 arch/arm/boot/dts/socfpga_cyclone5.dtsi           | 1 -
 arch/arm/boot/dts/socfpga_vt.dts                  | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
index 040a164ba148..5822fd2085db 100644
--- a/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
+++ b/arch/arm/boot/dts/socfpga_arria10_socdk_sdmmc.dts
@@ -20,7 +20,6 @@
 
 &mmc {
 	status = "okay";
-	num-slots = <1>;
 	cap-sd-highspeed;
 	broken-cd;
 	bus-width = <4>;
diff --git a/arch/arm/boot/dts/socfpga_arria5.dtsi b/arch/arm/boot/dts/socfpga_arria5.dtsi
index 8c037297296c..e59461f5416e 100644
--- a/arch/arm/boot/dts/socfpga_arria5.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria5.dtsi
@@ -30,7 +30,6 @@
 		};
 
 		mmc0: dwmmc0@ff704000 {
-			num-slots = <1>;
 			broken-cd;
 			bus-width = <4>;
 			cap-mmc-highspeed;
diff --git a/arch/arm/boot/dts/socfpga_cyclone5.dtsi b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
index a05e3df23103..68ced67f8bfb 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5.dtsi
+++ b/arch/arm/boot/dts/socfpga_cyclone5.dtsi
@@ -31,7 +31,6 @@
 		};
 
 		mmc0: dwmmc0@ff704000 {
-			num-slots = <1>;
 			broken-cd;
 			bus-width = <4>;
 			cap-mmc-highspeed;
diff --git a/arch/arm/boot/dts/socfpga_vt.dts b/arch/arm/boot/dts/socfpga_vt.dts
index dfe2193cd4d5..547c38632c68 100644
--- a/arch/arm/boot/dts/socfpga_vt.dts
+++ b/arch/arm/boot/dts/socfpga_vt.dts
@@ -42,7 +42,6 @@
 		};
 
 		dwmmc0@ff704000 {
-			num-slots = <1>;
 			broken-cd;
 			bus-width = <4>;
 			cap-mmc-highspeed;
-- 
2.15.1
