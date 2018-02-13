Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935330AbeBMM5I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:57:08 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:19486 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935223AbeBMMyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:54:45 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v3 11/11] ARM: dts: STi: Remove unused clk_ext2f_a9 clock
Date: Tue, 13 Feb 2018 13:53:37 +0100
Message-ID: <1518526417-11919-12-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
References: <1518526417-11919-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

This clock node is unused, remove it.
This allows to fix the following warnings when compiling
dtb with W=1 option :

arch/arm/boot/dts/stih410-b2120.dtb: Warning (simple_bus_reg):
Node /clocks/clockgen-c0 missing or empty reg/ranges property

arch/arm/boot/dts/stih410-b2260.dtb: Warning (simple_bus_reg):
Node /clocks/clockgen-c0 missing or empty reg/ranges property

arch/arm/boot/dts/stih418-b2199.dtb: Warning (simple_bus_reg):
Node /clocks/clockgen-c0 missing or empty reg/ranges property

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v3: _ none
v2: _ remove clk_ext2f_a9 node


 arch/arm/boot/dts/stih407-clock.dtsi | 11 -----------
 arch/arm/boot/dts/stih410-clock.dtsi | 11 -----------
 arch/arm/boot/dts/stih418-clock.dtsi | 11 -----------
 3 files changed, 33 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index 084c02926f33..ea7833489832 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -71,17 +71,6 @@
 			};
 		};
 
-		/*
-		 * Bootloader initialized system infrastructure clock for
-		 * serial devices.
-		 */
-		clk_ext2f_a9: clockgen-c0 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <200000000>;
-			clock-output-names = "clk-s-icn-reg-0";
-		};
-
 		clockgen-a@90ff000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x90ff000 0x1000>;
diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index b2c814f1261a..5f11d09cb030 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -71,17 +71,6 @@
 			};
 		};
 
-		/*
-		 * Bootloader initialized system infrastructure clock for
-		 * serial devices.
-		 */
-		clk_ext2f_a9: clockgen-c0 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <200000000>;
-			clock-output-names = "clk-s-icn-reg-0";
-		};
-
 		clockgen-a@90ff000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x90ff000 0x1000>;
diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
index a192608ff689..13fb8db52fc1 100644
--- a/arch/arm/boot/dts/stih418-clock.dtsi
+++ b/arch/arm/boot/dts/stih418-clock.dtsi
@@ -72,17 +72,6 @@
 			};
 		};
 
-		/*
-		 * Bootloader initialized system infrastructure clock for
-		 * serial devices.
-		 */
-		clk_ext2f_a9: clockgen-c0 {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <200000000>;
-			clock-output-names = "clk-s-icn-reg-0";
-		};
-
 		clockgen-a@90ff000 {
 			compatible = "st,clkgen-c32";
 			reg = <0x90ff000 0x1000>;
-- 
1.9.1
