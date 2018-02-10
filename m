Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbeBJBjj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 20:39:39 -0500
Received: from mout.perfora.net ([74.208.4.194]:51173 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbeBJBjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 20:39:35 -0500
From: Marcel Ziswiler <marcel@ziswiler.com>
To: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/4] ARM: dts: tegra: beaver: remove invalid uses of rsvd1
Date: Sat, 10 Feb 2018 02:33:24 +0100
Message-Id: <20180210013326.27771-4-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180210013326.27771-1-marcel@ziswiler.com>
References: <20180210013326.27771-1-marcel@ziswiler.com>
X-Provags-ID: V03:K0:w3VGbkYbpSMAXMb4SinexKmMpbJT+Bog3YNflyEriju04AbrMZs
 X9OJsEaHKHUo3sMUO9oxqz/ONcD1JT1yW8Gvj/LFfTnUYrWEqbALDQhaP3J2VWmUihkUdum
 ctpVY+Fxi006afsUZiMyao5iZ3CAfr/Ag9GZfGxKtByh7tbu0SMJw0S9XfZh8ctp7W0GixI
 V02nUdkxOBVTW+FVR05xw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M8b2sdutSMQ=:toytnbzTNTSU2esxqTYGwp
 M4inqfBJpSB7RsBsWPc7o9yH32jV8maUyT94DmYKUlawIlgTdj3ARg0xIafQtmPX4QyPaYHbz
 zQh7522GYyIwbFWqvG5yMQW8nG1TlMzMbOoPkEnkCKR4RCFxW9d9m2cX9e6cKAwZwzYZ3JXq0
 r0IG0gZpSk6gcX7dkIInnGrJJ6ZPkUdaixNVdyZzzaZUM11shwWM/wrD9cf4GZMQrp00ToEaf
 QWtjpYA1sikpZU4EsLFRK18+NsrSAhJIUmiGTH9vwXwleDYV5yuMLH80P5UFE7rIO+Z80La+q
 +4ObTGFfmD1UuMvle2dePMZA+AM3LUOHyTJY8nH8n6nRfTfDUpH2Ao+l44xn3eScRfEx6FpoB
 DWtdyS/lYwTqQu2oFNr0rNRlXDmcYSmzYJAgp+5B7tqRbYCWSRsJ8vMG7pqWLj7KrL9SjUIT+
 nQ2EjhINOYS0zWfDloBSIcy1qvrvFcP5vodMs8M/6oJv3LgBUhN1fgFo0Tp8BOZutIEOUU0/m
 /qNv5J6VTwiQ5dbkjLwThwI/wIB4BXK/7gccAuHc/Q2NtV1PDSYhf3XiROoCfOciqiJGG8CdF
 6N3Hyow8Xfp6o3lizcnkmwRBP5zzkPG6msEZVhh2hCPCG8r6Us//OVPhXivxFv8doxDgp71ce
 qgx24H+wHkcUiO2v/ehieBg7Hy3FhXXIcEq7o9jKmxh8yw2Jrjdx9TYGZfaaAicJEQOfwehrh
 o6U6k0Q4DL/wZLlJTn6uXJ8YXLBGt5K+umiD2A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Remove invalid uses of rsvd1 from beaver device tree. Replace by actual
function names of pinmux option 1.

Taken from https://github.com/NVIDIA/tegra-pinmux-scripts commit
b0aceda108c0 ("remove invalid uses of rsvd1 from beaver config").

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra30-beaver.dts | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 36b85a0ab0eb..ae52a5039506 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -260,14 +260,14 @@
 			};
 			sdmmc3_dat6_pd3 {
 				nvidia,pins = "sdmmc3_dat6_pd3";
-				nvidia,function = "rsvd1";
+				nvidia,function = "spdif";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			sdmmc3_dat7_pd4 {
 				nvidia,pins = "sdmmc3_dat7_pd4";
-				nvidia,function = "rsvd1";
+				nvidia,function = "spdif";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
@@ -281,14 +281,14 @@
 			};
 			vi_vsync_pd6 {
 				nvidia,pins = "vi_vsync_pd6";
-				nvidia,function = "rsvd1";
+				nvidia,function = "ddr";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			vi_hsync_pd7 {
 				nvidia,pins = "vi_hsync_pd7";
-				nvidia,function = "rsvd1";
+				nvidia,function = "ddr";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
@@ -806,7 +806,7 @@
 			};
 			hdmi_int_pn7 {
 				nvidia,pins = "hdmi_int_pn7";
-				nvidia,function = "rsvd1";
+				nvidia,function = "hdmi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
@@ -841,7 +841,7 @@
 			};
 			ulpi_data3_po4 {
 				nvidia,pins = "ulpi_data3_po4";
-				nvidia,function = "rsvd1";
+				nvidia,function = "uarta";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
@@ -1107,21 +1107,21 @@
 			};
 			vi_d10_pt2 {
 				nvidia,pins = "vi_d10_pt2";
-				nvidia,function = "rsvd1";
+				nvidia,function = "ddr";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			vi_d11_pt3 {
 				nvidia,pins = "vi_d11_pt3";
-				nvidia,function = "rsvd1";
+				nvidia,function = "ddr";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			vi_d0_pt4 {
 				nvidia,pins = "vi_d0_pt4";
-				nvidia,function = "rsvd1";
+				nvidia,function = "ddr";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
@@ -1151,7 +1151,7 @@
 			};
 			pu0 {
 				nvidia,pins = "pu0";
-				nvidia,function = "rsvd1";
+				nvidia,function = "owr";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
@@ -1172,7 +1172,7 @@
 			};
 			pu3 {
 				nvidia,pins = "pu3";
-				nvidia,function = "rsvd1";
+				nvidia,function = "pwm0";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
@@ -1193,7 +1193,7 @@
 			};
 			pu6 {
 				nvidia,pins = "pu6";
-				nvidia,function = "rsvd1";
+				nvidia,function = "pwm3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
@@ -1221,7 +1221,7 @@
 			};
 			pv3 {
 				nvidia,pins = "pv3";
-				nvidia,function = "rsvd1";
+				nvidia,function = "clk_12m_out";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
@@ -1510,7 +1510,7 @@
 			};
 			pbb0 {
 				nvidia,pins = "pbb0";
-				nvidia,function = "rsvd1";
+				nvidia,function = "i2s4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
@@ -1575,7 +1575,7 @@
 			};
 			pcc1 {
 				nvidia,pins = "pcc1";
-				nvidia,function = "rsvd1";
+				nvidia,function = "i2s4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-- 
2.14.3
