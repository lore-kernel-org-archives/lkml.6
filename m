Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbeBWNld (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:41:33 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43187 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbeBWNla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:41:30 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: arnd@arndb.de, geert@linux-m68k.org, horms@verge.net.au,
        magnus.damm@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] arm64: dts: renesas: r8a77965: Add "reg" properties
Date: Fri, 23 Feb 2018 14:40:53 +0100
Message-Id: <1519393259-26108-2-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519393259-26108-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519393259-26108-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "reg" properties to place-holder nodes with unit address defined for
R-Car M3-N SoC.

This silences the following DTC compiler warning:
Warning (unit_address_vs_reg): Node /soc/... has a unit name,
but no reg property

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---
v1 -> v2:
- Extend "du" address length to include third channel
---
 arch/arm64/boot/dts/renesas/r8a77965.dtsi | 51 +++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77965.dtsi b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
index 55f05f7..4286453 100644
--- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
@@ -317,6 +317,7 @@
 		};
 
 		intc_ex: interrupt-controller@e61c0000 {
+			reg = <0 0xe61c0000 0 0x200>;
 			/* placeholder */
 		};
 
@@ -520,130 +521,163 @@
 		};
 
 		avb: ethernet@e6800000 {
+			reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;
 			/* placeholder */
 		};
 
 		csi20: csi2@fea80000 {
+			reg = <0 0xfea80000 0 0x10000>;
 			/* placeholder */
 		};
 
 		csi40: csi2@feaa0000 {
+			reg = <0 0xfeaa0000 0 0x10000>;
 			/* placeholder */
 		};
 
 		vin0: video@e6ef0000 {
+			reg = <0 0xe6ef0000 0 0x1000>;
 			/* placeholder */
 		};
 
 		vin1: video@e6ef1000 {
+			reg = <0 0xe6ef1000 0 0x1000>;
 			/* placeholder */
 		};
 
 		vin2: video@e6ef2000 {
+			reg = <0 0xe6ef2000 0 0x1000>;
 			/* placeholder */
 		};
 
 		vin3: video@e6ef3000 {
+			reg = <0 0xe6ef3000 0 0x1000>;
 			/* placeholder */
 		};
 
 		vin4: video@e6ef4000 {
+			reg = <0 0xe6ef4000 0 0x1000>;
 			/* placeholder */
 		};
 
 		vin5: video@e6ef5000 {
+			reg = <0 0xe6ef5000 0 0x1000>;
 			/* placeholder */
 		};
 
 		vin6: video@e6ef6000 {
+			reg = <0 0xe6ef6000 0 0x1000>;
 			/* placeholder */
 		};
 
 		vin7: video@e6ef7000 {
+			reg = <0 0xe6ef7000 0 0x1000>;
 			/* placeholder */
 		};
 
 		ohci0: usb@ee080000 {
+			reg = <0 0xee080000 0 0x100>;
 			/* placeholder */
 		};
 
 		ehci0: usb@ee080100 {
+			reg = <0 0xee080100 0 0x100>;
 			/* placeholder */
 		};
 
 		usb2_phy0: usb-phy@ee080200 {
+			reg = <0 0xee080200 0 0x700>;
 			/* placeholder */
 		};
 
 		ohci1: usb@ee0a0000 {
+			reg = <0 0xee0a0000 0 0x100>;
 			/* placeholder */
 		};
 
 		ehci1: usb@ee0a0100 {
+			reg = <0 0xee0a0100 0 0x100>;
 			/* placeholder */
 		};
 
 		i2c0: i2c@e6500000 {
+			reg = <0 0xe6500000 0 0x40>;
 			/* placeholder */
 		};
 
 		i2c1: i2c@e6508000 {
+			reg = <0 0xe6508000 0 0x40>;
 			/* placeholder */
 		};
 
 		i2c2: i2c@e6510000 {
+			reg = <0 0xe6510000 0 0x40>;
 			/* placeholder */
 		};
 
 		i2c3: i2c@e66d0000 {
+			reg = <0 0xe66d0000 0 0x40>;
 			/* placeholder */
 		};
 
 		i2c4: i2c@e66d8000 {
+			reg = <0 0xe66d8000 0 0x40>;
 			/* placeholder */
 		};
 
 		i2c5: i2c@e66e0000 {
+			reg = <0 0xe66e0000 0 0x40>;
 			/* placeholder */
 		};
 
 		i2c6: i2c@e66e8000 {
+			reg = <0 0xe66e8000 0 0x40>;
 			/* placeholder */
 		};
 
 		i2c_dvfs: i2c@e60b0000 {
+			reg = <0 0xe60b0000 0 0x425>;
 			/* placeholder */
 		};
 
 		pwm0: pwm@e6e30000 {
+			reg = <0 0xe6e30000 0 8>;
 			/* placeholder */
 		};
 
 		pwm1: pwm@e6e31000 {
+			reg = <0 0xe6e31000 0 8>;
 			/* placeholder */
 		};
 
 		pwm2: pwm@e6e32000 {
+			reg = <0 0xe6e32000 0 8>;
 			/* placeholder */
 		};
 
 		pwm3: pwm@e6e33000 {
+			reg = <0 0xe6e33000 0 8>;
 			/* placeholder */
 		};
 
 		pwm4: pwm@e6e34000 {
+			reg = <0 0xe6e34000 0 8>;
 			/* placeholder */
 		};
 
 		pwm5: pwm@e6e35000 {
+			reg = <0 0xe6e35000 0 8>;
 			/* placeholder */
 		};
 
 		pwm6: pwm@e6e36000 {
+			reg = <0 0xe6e36000 0 8>;
 			/* placeholder */
 		};
 
 		du: display@feb00000 {
+			reg = <0 0xfeb00000 0 0x80000>,
+			      <0 0xfeb90000 0 0x14>;
 			/* placeholder */
 
 			ports {
@@ -666,18 +700,26 @@
 		};
 
 		hsusb: usb@e6590000 {
+			reg = <0 0xe6590000 0 0x100>;
 			/* placeholder */
 		};
 
 		pciec0: pcie@fe000000 {
+			reg = <0 0xfe000000 0 0x80000>;
 			/* placeholder */
 		};
 
 		pciec1: pcie@ee800000 {
+			reg = <0 0xee800000 0 0x80000>;
 			/* placeholder */
 		};
 
 		rcar_sound: sound@ec500000 {
+			reg =	<0 0xec500000 0 0x1000>, /* SCU */
+				<0 0xec5a0000 0 0x100>,  /* ADG */
+				<0 0xec540000 0 0x1000>, /* SSIU */
+				<0 0xec541000 0 0x280>,  /* SSI */
+				<0 0xec740000 0 0x200>;  /* Audio DMAC peri peri*/
 			/* placeholder */
 
 			rcar_sound,dvc {
@@ -703,38 +745,47 @@
 		};
 
 		usb2_phy1: usb-phy@ee0a0200 {
+			reg = <0 0xee0a0200 0 0x700>;
 			/* placeholder */
 		};
 
 		sdhi0: sd@ee100000 {
+			reg = <0 0xee100000 0 0x2000>;
 			/* placeholder */
 		};
 
 		sdhi1: sd@ee120000 {
+			reg = <0 0xee120000 0 0x2000>;
 			/* placeholder */
 		};
 
 		sdhi2: sd@ee140000 {
+			reg = <0 0xee140000 0 0x2000>;
 			/* placeholder */
 		};
 
 		sdhi3: sd@ee160000 {
+			reg = <0 0xee160000 0 0x2000>;
 			/* placeholder */
 		};
 
 		usb3_phy0: usb-phy@e65ee000 {
+			reg = <0 0xe65ee000 0 0x90>;
 			/* placeholder */
 		};
 
 		usb3_peri0: usb@ee020000 {
+			reg = <0 0xee020000 0 0x400>;
 			/* placeholder */
 		};
 
 		xhci0: usb@ee000000 {
+			reg = <0 0xee000000 0 0xc00>;
 			/* placeholder */
 		};
 
 		wdt0: watchdog@e6020000 {
+			reg = <0 0xe6020000 0 0x0c>;
 			/* placeholder */
 		};
 	};
-- 
2.7.4
