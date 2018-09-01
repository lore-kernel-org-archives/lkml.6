Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E546C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A401420843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 13:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A401420843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeIARR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 13:17:56 -0400
Received: from mout.perfora.net ([74.208.4.196]:39823 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbeIARRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 13:17:55 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MbRkA-1gEqw11FXI-00IpKc; Sat, 01 Sep 2018 15:05:45 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 16/19] ARM: tegra: apalis-tk1: replace underscores in node names with dashes
Date:   Sat,  1 Sep 2018 15:05:01 +0200
Message-Id: <20180901130504.14318-17-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901130504.14318-1-marcel@ziswiler.com>
References: <20180901130504.14318-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:MDIijAPTZNz+8SPcyI83rMq6vaEfjpqpffxxqDSvKyUOai7adh2
 8SWYMg+DkvR0gUA8KcWzYmcpyChgqZQNngDjgMcUYHbVqWaQt3ScVsrk7SypPa58VrbCi5t
 ttVfw4KiaX6+dDW3tJQtp2iu7v596xIZ/STmb1ttZa5Nueu4bV32FknXauOrF6d93sJGKO2
 B+ZC13BTZ9cYzl4noJIfA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z/esSw9/+EI=:NP/OWHfO0X+cUk33zP30sQ
 hFH0zOgSJFCgYeddUBIzziIAc/FlbQbL3SQgrm1bqt7pdZVvTgV1E8fw6TULmO4A485VtmUFT
 E/6wWaf5w0/SC65gJn+G9scWd1bRfWdE2gBASThi1KbueRJJdBGEKyDB+GWouHv0drKkzeImf
 d2s5Z5DeajzH8Ges3yfe2haev0Df+9KDRujsgK4nUMFUw+dqDAsd7oWaSQDGEz+JwIn2o5lql
 aNZZPDAo2CzW8oTkgkmFa5oSNYjWU7vjqq1YxcsLxpeXNREyNkJdglCLuCtsoWWcEWa6W+vhl
 e5K9mWZ+jCEH1quYe6yRIUs07oBNh02hgYtIcEp+2zRUeQoTyNhB/SAwY4jTzrWkJt1dPJ01h
 jTbddNBRpO94PZ9oI7ryEevl5V9lFhLRLVFPixVbm/P5beEVNdaQT3Z/5XivV02pu1Pcl9DA1
 a9z6eyv3eY867L9FrvGxJ/soXcPl5I+2qnAFjN2QwBlobeb26gethUVnMWvgRLhdtrwXI2cLR
 iBxKSt/jdDk5xgnLFO9ZY5w5//RpGYYKBuaw22QiLrT7Jvt0AyvKsjxjCbHT1iX6Hd+tkNTfK
 FtrqG7YXauhI5VSRHlPukEspn3O4lUYOkSVWw7O/juOjR6XQi/K+UTG/c4ulM3KTFZNcN9bPD
 CW1xzrVp30HAYDjyspWVVySS0aKr1SdYJdnq4QcwVjXe3WyqPS74HgcB6Im2G864U10g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

As underscores in node names are not recommended replace them all where
possible with dashes.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2:
- New patch.

 arch/arm/boot/dts/tegra124-apalis-eval.dts      |   2 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts |   2 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi     | 290 ++++++++++++------------
 arch/arm/boot/dts/tegra124-apalis.dtsi          | 290 ++++++++++++------------
 4 files changed, 292 insertions(+), 292 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-apalis-eval.dts b/arch/arm/boot/dts/tegra124-apalis-eval.dts
index 2710eb79b63e..0b4ac640e54f 100644
--- a/arch/arm/boot/dts/tegra124-apalis-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-eval.dts
@@ -282,7 +282,7 @@
 
 &gpio {
 	/* Apalis GPIO7 MXM3 pin 15 PLX PEX 8605 PCIe Switch Reset */
-	pex_perst_n {
+	pex-perst-n {
 		gpio-hog;
 		gpios = <TEGRA_GPIO(DD, 1) GPIO_ACTIVE_HIGH>;
 		output-high;
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
index 574780250031..799382d04bba 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts
@@ -248,7 +248,7 @@
 
 &gpio {
 	/* Apalis GPIO7 MXM3 pin 15 PLX PEX 8605 PCIe Switch Reset */
-	pex_perst_n {
+	pex-perst-n {
 		gpio-hog;
 		gpios = <TEGRA_GPIO(DD, 1) GPIO_ACTIVE_HIGH>;
 		output-high;
diff --git a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
index e70994518c70..6d36521448ce 100644
--- a/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi
@@ -70,35 +70,35 @@
 
 		state_default: pinmux {
 			/* Analogue Audio (On-module) */
-			dap3_fs_pp0 {
+			dap3-fs-pp0 {
 				nvidia,pins = "dap3_fs_pp0";
 				nvidia,function = "i2s2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap3_din_pp1 {
+			dap3-din-pp1 {
 				nvidia,pins = "dap3_din_pp1";
 				nvidia,function = "i2s2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			dap3_dout_pp2 {
+			dap3-dout-pp2 {
 				nvidia,pins = "dap3_dout_pp2";
 				nvidia,function = "i2s2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap3_sclk_pp3 {
+			dap3-sclk-pp3 {
 				nvidia,pins = "dap3_sclk_pp3";
 				nvidia,function = "i2s2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap_mclk1_pw4 {
+			dap-mclk1-pw4 {
 				nvidia,pins = "dap_mclk1_pw4";
 				nvidia,function = "extperiph1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -125,7 +125,7 @@
 			};
 
 			/* Apalis CAM1_MCLK */
-			cam_mclk_pcc0 {
+			cam-mclk-pcc0 {
 				nvidia,pins = "cam_mclk_pcc0";
 				nvidia,function = "vi_alt3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -134,28 +134,28 @@
 			};
 
 			/* Apalis Digital Audio */
-			dap2_fs_pa2 {
+			dap2-fs-pa2 {
 				nvidia,pins = "dap2_fs_pa2";
 				nvidia,function = "hda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			dap2_sclk_pa3 {
+			dap2-sclk-pa3 {
 				nvidia,pins = "dap2_sclk_pa3";
 				nvidia,function = "hda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			dap2_din_pa4 {
+			dap2-din-pa4 {
 				nvidia,pins = "dap2_din_pa4";
 				nvidia,function = "hda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			dap2_dout_pa5 {
+			dap2-dout-pa5 {
 				nvidia,pins = "dap2_dout_pa5";
 				nvidia,function = "hda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -168,7 +168,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			clk3_out_pee0 {
+			clk3-out-pee0 {
 				nvidia,pins = "clk3_out_pee0";
 				nvidia,function = "extperiph3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -177,7 +177,7 @@
 			};
 
 			/* Apalis GPIO */
-			usb_vbus_en0_pn4 {
+			usb-vbus-en0-pn4 {
 				nvidia,pins = "usb_vbus_en0_pn4";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -185,7 +185,7 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
 			};
-			usb_vbus_en1_pn5 {
+			usb-vbus-en1-pn5 {
 				nvidia,pins = "usb_vbus_en1_pn5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -193,35 +193,35 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
 			};
-			pex_l0_rst_n_pdd1 {
+			pex-l0-rst-n-pdd1 {
 				nvidia,pins = "pex_l0_rst_n_pdd1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			pex_l0_clkreq_n_pdd2 {
+			pex-l0-clkreq-n-pdd2 {
 				nvidia,pins = "pex_l0_clkreq_n_pdd2";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			pex_l1_rst_n_pdd5 {
+			pex-l1-rst-n-pdd5 {
 				nvidia,pins = "pex_l1_rst_n_pdd5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			pex_l1_clkreq_n_pdd6 {
+			pex-l1-clkreq-n-pdd6 {
 				nvidia,pins = "pex_l1_clkreq_n_pdd6";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			dp_hpd_pff0 {
+			dp-hpd-pff0 {
 				nvidia,pins = "dp_hpd_pff0";
 				nvidia,function = "dp";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -245,7 +245,7 @@
 			};
 
 			/* Apalis HDMI1_CEC */
-			hdmi_cec_pee3 {
+			hdmi-cec-pee3 {
 				nvidia,pins = "hdmi_cec_pee3";
 				nvidia,function = "cec";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -255,7 +255,7 @@
 			};
 
 			/* Apalis HDMI1_HPD */
-			hdmi_int_pn7 {
+			hdmi-int-pn7 {
 				nvidia,pins = "hdmi_int_pn7";
 				nvidia,function = "rsvd1";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
@@ -265,7 +265,7 @@
 			};
 
 			/* Apalis I2C1 */
-			gen1_i2c_scl_pc4 {
+			gen1-i2c-scl-pc4 {
 				nvidia,pins = "gen1_i2c_scl_pc4";
 				nvidia,function = "i2c1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -273,7 +273,7 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
-			gen1_i2c_sda_pc5 {
+			gen1-i2c-sda-pc5 {
 				nvidia,pins = "gen1_i2c_sda_pc5";
 				nvidia,function = "i2c1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -283,7 +283,7 @@
 			};
 
 			/* Apalis I2C3 (CAM) */
-			cam_i2c_scl_pbb1 {
+			cam-i2c-scl-pbb1 {
 				nvidia,pins = "cam_i2c_scl_pbb1";
 				nvidia,function = "i2c3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -291,7 +291,7 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
-			cam_i2c_sda_pbb2 {
+			cam-i2c-sda-pbb2 {
 				nvidia,pins = "cam_i2c_sda_pbb2";
 				nvidia,function = "i2c3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -301,7 +301,7 @@
 			};
 
 			/* Apalis I2C4 (DDC) */
-			ddc_scl_pv4 {
+			ddc-scl-pv4 {
 				nvidia,pins = "ddc_scl_pv4";
 				nvidia,function = "i2c4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -309,7 +309,7 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,rcv-sel = <TEGRA_PIN_ENABLE>;
 			};
-			ddc_sda_pv5 {
+			ddc-sda-pv5 {
 				nvidia,pins = "ddc_sda_pv5";
 				nvidia,function = "i2c4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -319,77 +319,77 @@
 			};
 
 			/* Apalis MMC1 */
-			sdmmc1_cd_n_pv3 { /* CD# GPIO */
+			sdmmc1-cd-n-pv3 { /* CD# GPIO */
 				nvidia,pins = "sdmmc1_wp_n_pv3";
 				nvidia,function = "sdmmc1";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			clk2_out_pw5 { /* D5 GPIO */
+			clk2-out-pw5 { /* D5 GPIO */
 				nvidia,pins = "clk2_out_pw5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc1_dat3_py4 {
+			sdmmc1-dat3-py4 {
 				nvidia,pins = "sdmmc1_dat3_py4";
 				nvidia,function = "sdmmc1";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc1_dat2_py5 {
+			sdmmc1-dat2-py5 {
 				nvidia,pins = "sdmmc1_dat2_py5";
 				nvidia,function = "sdmmc1";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc1_dat1_py6 {
+			sdmmc1-dat1-py6 {
 				nvidia,pins = "sdmmc1_dat1_py6";
 				nvidia,function = "sdmmc1";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc1_dat0_py7 {
+			sdmmc1-dat0-py7 {
 				nvidia,pins = "sdmmc1_dat0_py7";
 				nvidia,function = "sdmmc1";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc1_clk_pz0 {
+			sdmmc1-clk-pz0 {
 				nvidia,pins = "sdmmc1_clk_pz0";
 				nvidia,function = "sdmmc1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc1_cmd_pz1 {
+			sdmmc1-cmd-pz1 {
 				nvidia,pins = "sdmmc1_cmd_pz1";
 				nvidia,function = "sdmmc1";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			clk2_req_pcc5 { /* D4 GPIO */
+			clk2-req-pcc5 { /* D4 GPIO */
 				nvidia,pins = "clk2_req_pcc5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc3_clk_lb_in_pee5 { /* D6 GPIO */
+			sdmmc3-clk-lb-in-pee5 { /* D6 GPIO */
 				nvidia,pins = "sdmmc3_clk_lb_in_pee5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			usb_vbus_en2_pff1 { /* D7 GPIO */
+			usb-vbus-en2-pff1 { /* D7 GPIO */
 				nvidia,pins = "usb_vbus_en2_pff1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -429,7 +429,7 @@
 			};
 
 			/* Apalis SATA1_ACT# */
-			dap1_dout_pn2 {
+			dap1-dout-pn2 {
 				nvidia,pins = "dap1_dout_pn2";
 				nvidia,function = "gmi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -438,49 +438,49 @@
 			};
 
 			/* Apalis SD1 */
-			sdmmc3_clk_pa6 {
+			sdmmc3-clk-pa6 {
 				nvidia,pins = "sdmmc3_clk_pa6";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc3_cmd_pa7 {
+			sdmmc3-cmd-pa7 {
 				nvidia,pins = "sdmmc3_cmd_pa7";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc3_dat3_pb4 {
+			sdmmc3-dat3-pb4 {
 				nvidia,pins = "sdmmc3_dat3_pb4";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc3_dat2_pb5 {
+			sdmmc3-dat2-pb5 {
 				nvidia,pins = "sdmmc3_dat2_pb5";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc3_dat1_pb6 {
+			sdmmc3-dat1-pb6 {
 				nvidia,pins = "sdmmc3_dat1_pb6";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc3_dat0_pb7 {
+			sdmmc3-dat0-pb7 {
 				nvidia,pins = "sdmmc3_dat0_pb7";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc3_cd_n_pv2 { /* CD# GPIO */
+			sdmmc3-cd-n-pv2 { /* CD# GPIO */
 				nvidia,pins = "sdmmc3_cd_n_pv2";
 				nvidia,function = "rsvd3";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -489,14 +489,14 @@
 			};
 
 			/* Apalis SPDIF */
-			spdif_out_pk5 {
+			spdif-out-pk5 {
 				nvidia,pins = "spdif_out_pk5";
 				nvidia,function = "spdif";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			spdif_in_pk6 {
+			spdif-in-pk6 {
 				nvidia,pins = "spdif_in_pk6";
 				nvidia,function = "spdif";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -505,28 +505,28 @@
 			};
 
 			/* Apalis SPI1 */
-			ulpi_clk_py0 {
+			ulpi-clk-py0 {
 				nvidia,pins = "ulpi_clk_py0";
 				nvidia,function = "spi1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			ulpi_dir_py1 {
+			ulpi-dir-py1 {
 				nvidia,pins = "ulpi_dir_py1";
 				nvidia,function = "spi1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			ulpi_nxt_py2 {
+			ulpi-nxt-py2 {
 				nvidia,pins = "ulpi_nxt_py2";
 				nvidia,function = "spi1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			ulpi_stp_py3 {
+			ulpi-stp-py3 {
 				nvidia,pins = "ulpi_stp_py3";
 				nvidia,function = "spi1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -579,42 +579,42 @@
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			uart1_txd_pu0 {
+			uart1-txd-pu0 {
 				nvidia,pins = "pu0";
 				nvidia,function = "uarta";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			uart1_rxd_pu1 {
+			uart1-rxd-pu1 {
 				nvidia,pins = "pu1";
 				nvidia,function = "uarta";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			uart1_cts_n_pu2 {
+			uart1-cts-n-pu2 {
 				nvidia,pins = "pu2";
 				nvidia,function = "uarta";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			uart1_rts_n_pu3 {
+			uart1-rts-n-pu3 {
 				nvidia,pins = "pu3";
 				nvidia,function = "uarta";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			uart3_cts_n_pa1 { /* DSR GPIO */
+			uart3-cts-n-pa1 { /* DSR GPIO */
 				nvidia,pins = "uart3_cts_n_pa1";
 				nvidia,function = "gmi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			uart3_rts_n_pc0 { /* DTR GPIO */
+			uart3-rts-n-pc0 { /* DTR GPIO */
 				nvidia,pins = "uart3_rts_n_pc0";
 				nvidia,function = "gmi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -623,28 +623,28 @@
 			};
 
 			/* Apalis UART2 */
-			uart2_txd_pc2 {
+			uart2-txd-pc2 {
 				nvidia,pins = "uart2_txd_pc2";
 				nvidia,function = "irda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			uart2_rxd_pc3 {
+			uart2-rxd-pc3 {
 				nvidia,pins = "uart2_rxd_pc3";
 				nvidia,function = "irda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			uart2_cts_n_pj5 {
+			uart2-cts-n-pj5 {
 				nvidia,pins = "uart2_cts_n_pj5";
 				nvidia,function = "uartb";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			uart2_rts_n_pj6 {
+			uart2-rts-n-pj6 {
 				nvidia,pins = "uart2_rts_n_pj6";
 				nvidia,function = "uartb";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -653,14 +653,14 @@
 			};
 
 			/* Apalis UART3 */
-			uart3_txd_pw6 {
+			uart3-txd-pw6 {
 				nvidia,pins = "uart3_txd_pw6";
 				nvidia,function = "uartc";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			uart3_rxd_pw7 {
+			uart3-rxd-pw7 {
 				nvidia,pins = "uart3_rxd_pw7";
 				nvidia,function = "uartc";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -669,14 +669,14 @@
 			};
 
 			/* Apalis UART4 */
-			uart4_rxd_pb0 {
+			uart4-rxd-pb0 {
 				nvidia,pins = "pb0";
 				nvidia,function = "uartd";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			uart4_txd_pj7 {
+			uart4-txd-pj7 {
 				nvidia,pins = "pj7";
 				nvidia,function = "uartd";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -685,7 +685,7 @@
 			};
 
 			/* Apalis USBH_EN */
-			gen2_i2c_sda_pt6 {
+			gen2-i2c-sda-pt6 {
 				nvidia,pins = "gen2_i2c_sda_pt6";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -704,7 +704,7 @@
 			};
 
 			/* Apalis USBO1_EN */
-			gen2_i2c_scl_pt5 {
+			gen2-i2c-scl-pt5 {
 				nvidia,pins = "gen2_i2c_scl_pt5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -723,7 +723,7 @@
 			};
 
 			/* Apalis WAKE1_MICO */
-			pex_wake_n_pdd3 {
+			pex-wake-n-pdd3 {
 				nvidia,pins = "pex_wake_n_pdd3";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -732,7 +732,7 @@
 			};
 
 			/* CORE_PWR_REQ */
-			core_pwr_req {
+			core-pwr-req {
 				nvidia,pins = "core_pwr_req";
 				nvidia,function = "pwron";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -741,7 +741,7 @@
 			};
 
 			/* CPU_PWR_REQ */
-			cpu_pwr_req {
+			cpu-pwr-req {
 				nvidia,pins = "cpu_pwr_req";
 				nvidia,function = "cpu";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -750,14 +750,14 @@
 			};
 
 			/* DVFS */
-			dvfs_pwm_px0 {
+			dvfs-pwm-px0 {
 				nvidia,pins = "dvfs_pwm_px0";
 				nvidia,function = "cldvfs";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dvfs_clk_px2 {
+			dvfs-clk-px2 {
 				nvidia,pins = "dvfs_clk_px2";
 				nvidia,function = "cldvfs";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -766,70 +766,70 @@
 			};
 
 			/* eMMC */
-			sdmmc4_dat0_paa0 {
+			sdmmc4-dat0-paa0 {
 				nvidia,pins = "sdmmc4_dat0_paa0";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_dat1_paa1 {
+			sdmmc4-dat1-paa1 {
 				nvidia,pins = "sdmmc4_dat1_paa1";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_dat2_paa2 {
+			sdmmc4-dat2-paa2 {
 				nvidia,pins = "sdmmc4_dat2_paa2";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_dat3_paa3 {
+			sdmmc4-dat3-paa3 {
 				nvidia,pins = "sdmmc4_dat3_paa3";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_dat4_paa4 {
+			sdmmc4-dat4-paa4 {
 				nvidia,pins = "sdmmc4_dat4_paa4";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_dat5_paa5 {
+			sdmmc4-dat5-paa5 {
 				nvidia,pins = "sdmmc4_dat5_paa5";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_dat6_paa6 {
+			sdmmc4-dat6-paa6 {
 				nvidia,pins = "sdmmc4_dat6_paa6";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_dat7_paa7 {
+			sdmmc4-dat7-paa7 {
 				nvidia,pins = "sdmmc4_dat7_paa7";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_clk_pcc4 {
+			sdmmc4-clk-pcc4 {
 				nvidia,pins = "sdmmc4_clk_pcc4";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_cmd_pt7 {
+			sdmmc4-cmd-pt7 {
 				nvidia,pins = "sdmmc4_cmd_pt7";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -838,7 +838,7 @@
 			};
 
 			/* JTAG_RTCK */
-			jtag_rtck {
+			jtag-rtck {
 				nvidia,pins = "jtag_rtck";
 				nvidia,function = "rtck";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -847,7 +847,7 @@
 			};
 
 			/* LAN_DEV_OFF# */
-			ulpi_data5_po6 {
+			ulpi-data5-po6 {
 				nvidia,pins = "ulpi_data5_po6";
 				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -856,7 +856,7 @@
 			};
 
 			/* LAN_RESET# */
-			kb_row10_ps2 {
+			kb-row10-ps2 {
 				nvidia,pins = "kb_row10_ps2";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -865,7 +865,7 @@
 			};
 
 			/* LAN_WAKE# */
-			ulpi_data4_po5 {
+			ulpi-data4-po5 {
 				nvidia,pins = "ulpi_data4_po5";
 				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -919,35 +919,35 @@
 			};
 
 			/* MCU SPI */
-			gpio_x4_aud_px4 {
+			gpio-x4-aud-px4 {
 				nvidia,pins = "gpio_x4_aud_px4";
 				nvidia,function = "spi2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			gpio_x5_aud_px5 {
+			gpio-x5-aud-px5 {
 				nvidia,pins = "gpio_x5_aud_px5";
 				nvidia,function = "spi2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			gpio_x6_aud_px6 { /* MCU_CS */
+			gpio-x6-aud-px6 { /* MCU_CS */
 				nvidia,pins = "gpio_x6_aud_px6";
 				nvidia,function = "spi2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			gpio_x7_aud_px7 {
+			gpio-x7-aud-px7 {
 				nvidia,pins = "gpio_x7_aud_px7";
 				nvidia,function = "spi2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			gpio_w2_aud_pw2 { /* MCU_CSEZP */
+			gpio-w2-aud-pw2 { /* MCU_CSEZP */
 				nvidia,pins = "gpio_w2_aud_pw2";
 				nvidia,function = "spi2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -956,7 +956,7 @@
 			};
 
 			/* PMIC_CLK_32K */
-			clk_32k_in {
+			clk-32k-in {
 				nvidia,pins = "clk_32k_in";
 				nvidia,function = "clk";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -965,7 +965,7 @@
 			};
 
 			/* PMIC_CPU_OC_INT */
-			clk_32k_out_pa0 {
+			clk-32k-out-pa0 {
 				nvidia,pins = "clk_32k_out_pa0";
 				nvidia,function = "soc";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -974,7 +974,7 @@
 			};
 
 			/* PWR_I2C */
-			pwr_i2c_scl_pz6 {
+			pwr-i2c-scl-pz6 {
 				nvidia,pins = "pwr_i2c_scl_pz6";
 				nvidia,function = "i2cpwr";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -982,7 +982,7 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
-			pwr_i2c_sda_pz7 {
+			pwr-i2c-sda-pz7 {
 				nvidia,pins = "pwr_i2c_sda_pz7";
 				nvidia,function = "i2cpwr";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -992,7 +992,7 @@
 			};
 
 			/* PWR_INT_N */
-			pwr_int_n {
+			pwr-int-n {
 				nvidia,pins = "pwr_int_n";
 				nvidia,function = "pmi";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -1010,7 +1010,7 @@
 			};
 
 			/* RESET_OUT_N */
-			reset_out_n {
+			reset-out-n {
 				nvidia,pins = "reset_out_n";
 				nvidia,function = "reset_out_n";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -1019,14 +1019,14 @@
 			};
 
 			/* SHIFT_CTRL_DIR_IN */
-			kb_row0_pr0 {
+			kb-row0-pr0 {
 				nvidia,pins = "kb_row0_pr0";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row1_pr1 {
+			kb-row1-pr1 {
 				nvidia,pins = "kb_row1_pr1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
@@ -1035,7 +1035,7 @@
 			};
 
 			/* Configure level-shifter as output for HDA */
-			kb_row11_ps3 {
+			kb-row11-ps3 {
 				nvidia,pins = "kb_row11_ps3";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -1044,21 +1044,21 @@
 			};
 
 			/* SHIFT_CTRL_DIR_OUT */
-			kb_col5_pq5 {
+			kb-col5-pq5 {
 				nvidia,pins = "kb_col5_pq5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_col6_pq6 {
+			kb-col6-pq6 {
 				nvidia,pins = "kb_col6_pq6";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_col7_pq7 {
+			kb-col7-pq7 {
 				nvidia,pins = "kb_col7_pq7";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -1067,35 +1067,35 @@
 			};
 
 			/* SHIFT_CTRL_OE */
-			kb_col0_pq0 {
+			kb-col0-pq0 {
 				nvidia,pins = "kb_col0_pq0";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_col1_pq1 {
+			kb-col1-pq1 {
 				nvidia,pins = "kb_col1_pq1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_col2_pq2 {
+			kb-col2-pq2 {
 				nvidia,pins = "kb_col2_pq2";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_col4_pq4 {
+			kb-col4-pq4 {
 				nvidia,pins = "kb_col4_pq4";
 				nvidia,function = "kbc";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row2_pr2 {
+			kb-row2-pr2 {
 				nvidia,pins = "kb_row2_pr2";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
@@ -1113,7 +1113,7 @@
 			};
 
 			/* TOUCH_INT */
-			gpio_w3_aud_pw3 {
+			gpio-w3-aud-pw3 {
 				nvidia,pins = "gpio_w3_aud_pw3";
 				nvidia,function = "spi6";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -1254,189 +1254,189 @@
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap1_fs_pn0 { /* NC */
+			dap1-fs-pn0 { /* NC */
 				nvidia,pins = "dap1_fs_pn0";
 				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap1_din_pn1 { /* NC */
+			dap1-din-pn1 { /* NC */
 				nvidia,pins = "dap1_din_pn1";
 				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap1_sclk_pn3 { /* NC */
+			dap1-sclk-pn3 { /* NC */
 				nvidia,pins = "dap1_sclk_pn3";
 				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			ulpi_data7_po0 { /* NC */
+			ulpi-data7-po0 { /* NC */
 				nvidia,pins = "ulpi_data7_po0";
 				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			ulpi_data0_po1 { /* NC */
+			ulpi-data0-po1 { /* NC */
 				nvidia,pins = "ulpi_data0_po1";
 				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			ulpi_data1_po2 { /* NC */
+			ulpi-data1-po2 { /* NC */
 				nvidia,pins = "ulpi_data1_po2";
 				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			ulpi_data2_po3 { /* NC */
+			ulpi-data2-po3 { /* NC */
 				nvidia,pins = "ulpi_data2_po3";
 				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			ulpi_data3_po4 { /* NC */
+			ulpi-data3-po4 { /* NC */
 				nvidia,pins = "ulpi_data3_po4";
 				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			ulpi_data6_po7 { /* NC */
+			ulpi-data6-po7 { /* NC */
 				nvidia,pins = "ulpi_data6_po7";
 				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap4_fs_pp4 { /* NC */
+			dap4-fs-pp4 { /* NC */
 				nvidia,pins = "dap4_fs_pp4";
 				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap4_din_pp5 { /* NC */
+			dap4-din-pp5 { /* NC */
 				nvidia,pins = "dap4_din_pp5";
 				nvidia,function = "rsvd3";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap4_dout_pp6 { /* NC */
+			dap4-dout-pp6 { /* NC */
 				nvidia,pins = "dap4_dout_pp6";
 				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap4_sclk_pp7 { /* NC */
+			dap4-sclk-pp7 { /* NC */
 				nvidia,pins = "dap4_sclk_pp7";
 				nvidia,function = "rsvd3";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_col3_pq3 { /* NC */
+			kb-col3-pq3 { /* NC */
 				nvidia,pins = "kb_col3_pq3";
 				nvidia,function = "kbc";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row3_pr3 { /* NC */
+			kb-row3-pr3 { /* NC */
 				nvidia,pins = "kb_row3_pr3";
 				nvidia,function = "kbc";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row4_pr4 { /* NC */
+			kb-row4-pr4 { /* NC */
 				nvidia,pins = "kb_row4_pr4";
 				nvidia,function = "rsvd3";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row5_pr5 { /* NC */
+			kb-row5-pr5 { /* NC */
 				nvidia,pins = "kb_row5_pr5";
 				nvidia,function = "rsvd3";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row6_pr6 { /* NC */
+			kb-row6-pr6 { /* NC */
 				nvidia,pins = "kb_row6_pr6";
 				nvidia,function = "kbc";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row7_pr7 { /* NC */
+			kb-row7-pr7 { /* NC */
 				nvidia,pins = "kb_row7_pr7";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row8_ps0 { /* NC */
+			kb-row8-ps0 { /* NC */
 				nvidia,pins = "kb_row8_ps0";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row9_ps1 { /* NC */
+			kb-row9-ps1 { /* NC */
 				nvidia,pins = "kb_row9_ps1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row12_ps4 { /* NC */
+			kb-row12-ps4 { /* NC */
 				nvidia,pins = "kb_row12_ps4";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row13_ps5 { /* NC */
+			kb-row13-ps5 { /* NC */
 				nvidia,pins = "kb_row13_ps5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row14_ps6 { /* NC */
+			kb-row14-ps6 { /* NC */
 				nvidia,pins = "kb_row14_ps6";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row15_ps7 { /* NC */
+			kb-row15-ps7 { /* NC */
 				nvidia,pins = "kb_row15_ps7";
 				nvidia,function = "rsvd3";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row16_pt0 { /* NC */
+			kb-row16-pt0 { /* NC */
 				nvidia,pins = "kb_row16_pt0";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row17_pt1 { /* NC */
+			kb-row17-pt1 { /* NC */
 				nvidia,pins = "kb_row17_pt1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
@@ -1468,14 +1468,14 @@
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			gpio_x1_aud_px1 { /* NC */
+			gpio-x1-aud-px1 { /* NC */
 				nvidia,pins = "gpio_x1_aud_px1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			gpio_x3_aud_px3 { /* NC */
+			gpio-x3-aud-px3 { /* NC */
 				nvidia,pins = "gpio_x3_aud_px3";
 				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
@@ -1503,14 +1503,14 @@
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			clk3_req_pee1 { /* NC */
+			clk3-req-pee1 { /* NC */
 				nvidia,pins = "clk3_req_pee1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap_mclk1_req_pee2 { /* NC */
+			dap-mclk1-req-pee2 { /* NC */
 				nvidia,pins = "dap_mclk1_req_pee2";
 				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
@@ -1526,7 +1526,7 @@
 			 * SDMMC_VENDOR_MISC_CNTRL_0 register's SDMMC_SPARE1
 			 * bits being set to 0xfffd according to the TRM!
 			 */
-			sdmmc3_clk_lb_out_pee4 { /* NC */
+			sdmmc3-clk-lb-out-pee4 { /* NC */
 				nvidia,pins = "sdmmc3_clk_lb_out_pee4";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -1580,14 +1580,14 @@
 			pinctrl-0 = <&as3722_default>;
 
 			as3722_default: pinmux {
-				gpio2_7 {
+				gpio2-7 {
 					pins = "gpio2", /* PWR_EN_+V3.3 */
 					       "gpio7"; /* +V1.6_LPO */
 					function = "gpio";
 					bias-pull-up;
 				};
 
-				gpio0_1_3_4_5_6 {
+				gpio0-1-3-4-5-6 {
 					pins = "gpio0", "gpio1", "gpio3",
 					       "gpio4", "gpio5", "gpio6";
 					bias-high-impedance;
@@ -2048,7 +2048,7 @@
 
 &gpio {
 	/* I210 Gigabit Ethernet Controller Reset */
-	lan_reset_n {
+	lan-reset-n {
 		gpio-hog;
 		gpios = <TEGRA_GPIO(S, 2) GPIO_ACTIVE_HIGH>;
 		output-high;
@@ -2056,7 +2056,7 @@
 	};
 
 	/* Control MXM3 pin 26 Reset Module Output Carrier Input */
-	reset_moci_ctrl {
+	reset-moci-ctrl {
 		gpio-hog;
 		gpios = <TEGRA_GPIO(U, 4) GPIO_ACTIVE_HIGH>;
 		output-high;
diff --git a/arch/arm/boot/dts/tegra124-apalis.dtsi b/arch/arm/boot/dts/tegra124-apalis.dtsi
index b1a05c37106d..a8f1306b5cd7 100644
--- a/arch/arm/boot/dts/tegra124-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra124-apalis.dtsi
@@ -106,35 +106,35 @@
 
 		state_default: pinmux {
 			/* Analogue Audio (On-module) */
-			dap3_fs_pp0 {
+			dap3-fs-pp0 {
 				nvidia,pins = "dap3_fs_pp0";
 				nvidia,function = "i2s2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap3_din_pp1 {
+			dap3-din-pp1 {
 				nvidia,pins = "dap3_din_pp1";
 				nvidia,function = "i2s2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			dap3_dout_pp2 {
+			dap3-dout-pp2 {
 				nvidia,pins = "dap3_dout_pp2";
 				nvidia,function = "i2s2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap3_sclk_pp3 {
+			dap3-sclk-pp3 {
 				nvidia,pins = "dap3_sclk_pp3";
 				nvidia,function = "i2s2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap_mclk1_pw4 {
+			dap-mclk1-pw4 {
 				nvidia,pins = "dap_mclk1_pw4";
 				nvidia,function = "extperiph1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -161,7 +161,7 @@
 			};
 
 			/* Apalis CAM1_MCLK */
-			cam_mclk_pcc0 {
+			cam-mclk-pcc0 {
 				nvidia,pins = "cam_mclk_pcc0";
 				nvidia,function = "vi_alt3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -170,28 +170,28 @@
 			};
 
 			/* Apalis Digital Audio */
-			dap2_fs_pa2 {
+			dap2-fs-pa2 {
 				nvidia,pins = "dap2_fs_pa2";
 				nvidia,function = "hda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			dap2_sclk_pa3 {
+			dap2-sclk-pa3 {
 				nvidia,pins = "dap2_sclk_pa3";
 				nvidia,function = "hda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			dap2_din_pa4 {
+			dap2-din-pa4 {
 				nvidia,pins = "dap2_din_pa4";
 				nvidia,function = "hda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			dap2_dout_pa5 {
+			dap2-dout-pa5 {
 				nvidia,pins = "dap2_dout_pa5";
 				nvidia,function = "hda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -204,7 +204,7 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			clk3_out_pee0 {
+			clk3-out-pee0 {
 				nvidia,pins = "clk3_out_pee0";
 				nvidia,function = "extperiph3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -213,49 +213,49 @@
 			};
 
 			/* Apalis GPIO */
-			ddc_scl_pv4 {
+			ddc-scl-pv4 {
 				nvidia,pins = "ddc_scl_pv4";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			ddc_sda_pv5 {
+			ddc-sda-pv5 {
 				nvidia,pins = "ddc_sda_pv5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			pex_l0_rst_n_pdd1 {
+			pex-l0-rst-n-pdd1 {
 				nvidia,pins = "pex_l0_rst_n_pdd1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			pex_l0_clkreq_n_pdd2 {
+			pex-l0-clkreq-n-pdd2 {
 				nvidia,pins = "pex_l0_clkreq_n_pdd2";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			pex_l1_rst_n_pdd5 {
+			pex-l1-rst-n-pdd5 {
 				nvidia,pins = "pex_l1_rst_n_pdd5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			pex_l1_clkreq_n_pdd6 {
+			pex-l1-clkreq-n-pdd6 {
 				nvidia,pins = "pex_l1_clkreq_n_pdd6";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			dp_hpd_pff0 {
+			dp-hpd-pff0 {
 				nvidia,pins = "dp_hpd_pff0";
 				nvidia,function = "dp";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -279,7 +279,7 @@
 			};
 
 			/* Apalis HDMI1_CEC */
-			hdmi_cec_pee3 {
+			hdmi-cec-pee3 {
 				nvidia,pins = "hdmi_cec_pee3";
 				nvidia,function = "cec";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -289,7 +289,7 @@
 			};
 
 			/* Apalis HDMI1_HPD */
-			hdmi_int_pn7 {
+			hdmi-int-pn7 {
 				nvidia,pins = "hdmi_int_pn7";
 				nvidia,function = "rsvd1";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
@@ -299,7 +299,7 @@
 			};
 
 			/* Apalis I2C1 */
-			gen1_i2c_scl_pc4 {
+			gen1-i2c-scl-pc4 {
 				nvidia,pins = "gen1_i2c_scl_pc4";
 				nvidia,function = "i2c1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -307,7 +307,7 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
-			gen1_i2c_sda_pc5 {
+			gen1-i2c-sda-pc5 {
 				nvidia,pins = "gen1_i2c_sda_pc5";
 				nvidia,function = "i2c1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -317,7 +317,7 @@
 			};
 
 			/* Apalis I2C2 (DDC) */
-			gen2_i2c_scl_pt5 {
+			gen2-i2c-scl-pt5 {
 				nvidia,pins = "gen2_i2c_scl_pt5";
 				nvidia,function = "i2c2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -325,7 +325,7 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
-			gen2_i2c_sda_pt6 {
+			gen2-i2c-sda-pt6 {
 				nvidia,pins = "gen2_i2c_sda_pt6";
 				nvidia,function = "i2c2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -335,7 +335,7 @@
 			};
 
 			/* Apalis I2C3 (CAM) */
-			cam_i2c_scl_pbb1 {
+			cam-i2c-scl-pbb1 {
 				nvidia,pins = "cam_i2c_scl_pbb1";
 				nvidia,function = "i2c3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -343,7 +343,7 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
-			cam_i2c_sda_pbb2 {
+			cam-i2c-sda-pbb2 {
 				nvidia,pins = "cam_i2c_sda_pbb2";
 				nvidia,function = "i2c3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -353,77 +353,77 @@
 			};
 
 			/* Apalis MMC1 */
-			sdmmc1_cd_n_pv3 { /* CD# GPIO */
+			sdmmc1-cd-n-pv3 { /* CD# GPIO */
 				nvidia,pins = "sdmmc1_wp_n_pv3";
 				nvidia,function = "sdmmc1";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			clk2_out_pw5 { /* D5 GPIO */
+			clk2-out-pw5 { /* D5 GPIO */
 				nvidia,pins = "clk2_out_pw5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc1_dat3_py4 {
+			sdmmc1-dat3-py4 {
 				nvidia,pins = "sdmmc1_dat3_py4";
 				nvidia,function = "sdmmc1";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc1_dat2_py5 {
+			sdmmc1-dat2-py5 {
 				nvidia,pins = "sdmmc1_dat2_py5";
 				nvidia,function = "sdmmc1";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc1_dat1_py6 {
+			sdmmc1-dat1-py6 {
 				nvidia,pins = "sdmmc1_dat1_py6";
 				nvidia,function = "sdmmc1";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc1_dat0_py7 {
+			sdmmc1-dat0-py7 {
 				nvidia,pins = "sdmmc1_dat0_py7";
 				nvidia,function = "sdmmc1";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc1_clk_pz0 {
+			sdmmc1-clk-pz0 {
 				nvidia,pins = "sdmmc1_clk_pz0";
 				nvidia,function = "sdmmc1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc1_cmd_pz1 {
+			sdmmc1-cmd-pz1 {
 				nvidia,pins = "sdmmc1_cmd_pz1";
 				nvidia,function = "sdmmc1";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			clk2_req_pcc5 { /* D4 GPIO */
+			clk2-req-pcc5 { /* D4 GPIO */
 				nvidia,pins = "clk2_req_pcc5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc3_clk_lb_in_pee5 { /* D6 GPIO */
+			sdmmc3-clk-lb-in-pee5 { /* D6 GPIO */
 				nvidia,pins = "sdmmc3_clk_lb_in_pee5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			usb_vbus_en2_pff1 { /* D7 GPIO */
+			usb-vbus-en2-pff1 { /* D7 GPIO */
 				nvidia,pins = "usb_vbus_en2_pff1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -463,7 +463,7 @@
 			};
 
 			/* Apalis SATA1_ACT# */
-			dap1_dout_pn2 {
+			dap1-dout-pn2 {
 				nvidia,pins = "dap1_dout_pn2";
 				nvidia,function = "gmi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -472,49 +472,49 @@
 			};
 
 			/* Apalis SD1 */
-			sdmmc3_clk_pa6 {
+			sdmmc3-clk-pa6 {
 				nvidia,pins = "sdmmc3_clk_pa6";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc3_cmd_pa7 {
+			sdmmc3-cmd-pa7 {
 				nvidia,pins = "sdmmc3_cmd_pa7";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc3_dat3_pb4 {
+			sdmmc3-dat3-pb4 {
 				nvidia,pins = "sdmmc3_dat3_pb4";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc3_dat2_pb5 {
+			sdmmc3-dat2-pb5 {
 				nvidia,pins = "sdmmc3_dat2_pb5";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc3_dat1_pb6 {
+			sdmmc3-dat1-pb6 {
 				nvidia,pins = "sdmmc3_dat1_pb6";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc3_dat0_pb7 {
+			sdmmc3-dat0-pb7 {
 				nvidia,pins = "sdmmc3_dat0_pb7";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc3_cd_n_pv2 { /* CD# GPIO */
+			sdmmc3-cd-n-pv2 { /* CD# GPIO */
 				nvidia,pins = "sdmmc3_cd_n_pv2";
 				nvidia,function = "rsvd3";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -523,14 +523,14 @@
 			};
 
 			/* Apalis SPDIF */
-			spdif_out_pk5 {
+			spdif-out-pk5 {
 				nvidia,pins = "spdif_out_pk5";
 				nvidia,function = "spdif";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			spdif_in_pk6 {
+			spdif-in-pk6 {
 				nvidia,pins = "spdif_in_pk6";
 				nvidia,function = "spdif";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -539,28 +539,28 @@
 			};
 
 			/* Apalis SPI1 */
-			ulpi_clk_py0 {
+			ulpi-clk-py0 {
 				nvidia,pins = "ulpi_clk_py0";
 				nvidia,function = "spi1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			ulpi_dir_py1 {
+			ulpi-dir-py1 {
 				nvidia,pins = "ulpi_dir_py1";
 				nvidia,function = "spi1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			ulpi_nxt_py2 {
+			ulpi-nxt-py2 {
 				nvidia,pins = "ulpi_nxt_py2";
 				nvidia,function = "spi1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			ulpi_stp_py3 {
+			ulpi-stp-py3 {
 				nvidia,pins = "ulpi_stp_py3";
 				nvidia,function = "spi1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -613,42 +613,42 @@
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			uart1_txd_pu0 {
+			uart1-txd-pu0 {
 				nvidia,pins = "pu0";
 				nvidia,function = "uarta";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			uart1_rxd_pu1 {
+			uart1-rxd-pu1 {
 				nvidia,pins = "pu1";
 				nvidia,function = "uarta";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			uart1_cts_n_pu2 {
+			uart1-cts-n-pu2 {
 				nvidia,pins = "pu2";
 				nvidia,function = "uarta";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			uart1_rts_n_pu3 {
+			uart1-rts-n-pu3 {
 				nvidia,pins = "pu3";
 				nvidia,function = "uarta";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			uart3_cts_n_pa1 { /* DSR GPIO */
+			uart3-cts-n-pa1 { /* DSR GPIO */
 				nvidia,pins = "uart3_cts_n_pa1";
 				nvidia,function = "gmi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			uart3_rts_n_pc0 { /* DTR GPIO */
+			uart3-rts-n-pc0 { /* DTR GPIO */
 				nvidia,pins = "uart3_rts_n_pc0";
 				nvidia,function = "gmi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -657,28 +657,28 @@
 			};
 
 			/* Apalis UART2 */
-			uart2_txd_pc2 {
+			uart2-txd-pc2 {
 				nvidia,pins = "uart2_txd_pc2";
 				nvidia,function = "irda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			uart2_rxd_pc3 {
+			uart2-rxd-pc3 {
 				nvidia,pins = "uart2_rxd_pc3";
 				nvidia,function = "irda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			uart2_cts_n_pj5 {
+			uart2-cts-n-pj5 {
 				nvidia,pins = "uart2_cts_n_pj5";
 				nvidia,function = "uartb";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			uart2_rts_n_pj6 {
+			uart2-rts-n-pj6 {
 				nvidia,pins = "uart2_rts_n_pj6";
 				nvidia,function = "uartb";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -687,14 +687,14 @@
 			};
 
 			/* Apalis UART3 */
-			uart3_txd_pw6 {
+			uart3-txd-pw6 {
 				nvidia,pins = "uart3_txd_pw6";
 				nvidia,function = "uartc";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			uart3_rxd_pw7 {
+			uart3-rxd-pw7 {
 				nvidia,pins = "uart3_rxd_pw7";
 				nvidia,function = "uartc";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -703,14 +703,14 @@
 			};
 
 			/* Apalis UART4 */
-			uart4_rxd_pb0 {
+			uart4-rxd-pb0 {
 				nvidia,pins = "pb0";
 				nvidia,function = "uartd";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			uart4_txd_pj7 {
+			uart4-txd-pj7 {
 				nvidia,pins = "pj7";
 				nvidia,function = "uartd";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -719,7 +719,7 @@
 			};
 
 			/* Apalis USBH_EN */
-			usb_vbus_en1_pn5 {
+			usb-vbus-en1-pn5 {
 				nvidia,pins = "usb_vbus_en1_pn5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -738,7 +738,7 @@
 			};
 
 			/* Apalis USBO1_EN */
-			usb_vbus_en0_pn4 {
+			usb-vbus-en0-pn4 {
 				nvidia,pins = "usb_vbus_en0_pn4";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -757,7 +757,7 @@
 			};
 
 			/* Apalis WAKE1_MICO */
-			pex_wake_n_pdd3 {
+			pex-wake-n-pdd3 {
 				nvidia,pins = "pex_wake_n_pdd3";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -766,7 +766,7 @@
 			};
 
 			/* CORE_PWR_REQ */
-			core_pwr_req {
+			core-pwr-req {
 				nvidia,pins = "core_pwr_req";
 				nvidia,function = "pwron";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -775,7 +775,7 @@
 			};
 
 			/* CPU_PWR_REQ */
-			cpu_pwr_req {
+			cpu-pwr-req {
 				nvidia,pins = "cpu_pwr_req";
 				nvidia,function = "cpu";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -784,14 +784,14 @@
 			};
 
 			/* DVFS */
-			dvfs_pwm_px0 {
+			dvfs-pwm-px0 {
 				nvidia,pins = "dvfs_pwm_px0";
 				nvidia,function = "cldvfs";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dvfs_clk_px2 {
+			dvfs-clk-px2 {
 				nvidia,pins = "dvfs_clk_px2";
 				nvidia,function = "cldvfs";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -800,70 +800,70 @@
 			};
 
 			/* eMMC */
-			sdmmc4_dat0_paa0 {
+			sdmmc4-dat0-paa0 {
 				nvidia,pins = "sdmmc4_dat0_paa0";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_dat1_paa1 {
+			sdmmc4-dat1-paa1 {
 				nvidia,pins = "sdmmc4_dat1_paa1";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_dat2_paa2 {
+			sdmmc4-dat2-paa2 {
 				nvidia,pins = "sdmmc4_dat2_paa2";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_dat3_paa3 {
+			sdmmc4-dat3-paa3 {
 				nvidia,pins = "sdmmc4_dat3_paa3";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_dat4_paa4 {
+			sdmmc4-dat4-paa4 {
 				nvidia,pins = "sdmmc4_dat4_paa4";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_dat5_paa5 {
+			sdmmc4-dat5-paa5 {
 				nvidia,pins = "sdmmc4_dat5_paa5";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_dat6_paa6 {
+			sdmmc4-dat6-paa6 {
 				nvidia,pins = "sdmmc4_dat6_paa6";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_dat7_paa7 {
+			sdmmc4-dat7-paa7 {
 				nvidia,pins = "sdmmc4_dat7_paa7";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_clk_pcc4 {
+			sdmmc4-clk-pcc4 {
 				nvidia,pins = "sdmmc4_clk_pcc4";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			sdmmc4_cmd_pt7 {
+			sdmmc4-cmd-pt7 {
 				nvidia,pins = "sdmmc4_cmd_pt7";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -872,7 +872,7 @@
 			};
 
 			/* JTAG_RTCK */
-			jtag_rtck {
+			jtag-rtck {
 				nvidia,pins = "jtag_rtck";
 				nvidia,function = "rtck";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -881,7 +881,7 @@
 			};
 
 			/* LAN_DEV_OFF# */
-			ulpi_data5_po6 {
+			ulpi-data5-po6 {
 				nvidia,pins = "ulpi_data5_po6";
 				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -890,7 +890,7 @@
 			};
 
 			/* LAN_RESET# */
-			kb_row10_ps2 {
+			kb-row10-ps2 {
 				nvidia,pins = "kb_row10_ps2";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -899,7 +899,7 @@
 			};
 
 			/* LAN_WAKE# */
-			ulpi_data4_po5 {
+			ulpi-data4-po5 {
 				nvidia,pins = "ulpi_data4_po5";
 				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -953,35 +953,35 @@
 			};
 
 			/* MCU SPI */
-			gpio_x4_aud_px4 {
+			gpio-x4-aud-px4 {
 				nvidia,pins = "gpio_x4_aud_px4";
 				nvidia,function = "spi2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			gpio_x5_aud_px5 {
+			gpio-x5-aud-px5 {
 				nvidia,pins = "gpio_x5_aud_px5";
 				nvidia,function = "spi2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			gpio_x6_aud_px6 { /* MCU_CS */
+			gpio-x6-aud-px6 { /* MCU_CS */
 				nvidia,pins = "gpio_x6_aud_px6";
 				nvidia,function = "spi2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			gpio_x7_aud_px7 {
+			gpio-x7-aud-px7 {
 				nvidia,pins = "gpio_x7_aud_px7";
 				nvidia,function = "spi2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
-			gpio_w2_aud_pw2 { /* MCU_CSEZP */
+			gpio-w2-aud-pw2 { /* MCU_CSEZP */
 				nvidia,pins = "gpio_w2_aud_pw2";
 				nvidia,function = "spi2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -990,7 +990,7 @@
 			};
 
 			/* PMIC_CLK_32K */
-			clk_32k_in {
+			clk-32k-in {
 				nvidia,pins = "clk_32k_in";
 				nvidia,function = "clk";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -999,7 +999,7 @@
 			};
 
 			/* PMIC_CPU_OC_INT */
-			clk_32k_out_pa0 {
+			clk-32k-out-pa0 {
 				nvidia,pins = "clk_32k_out_pa0";
 				nvidia,function = "soc";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -1008,7 +1008,7 @@
 			};
 
 			/* PWR_I2C */
-			pwr_i2c_scl_pz6 {
+			pwr-i2c-scl-pz6 {
 				nvidia,pins = "pwr_i2c_scl_pz6";
 				nvidia,function = "i2cpwr";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -1016,7 +1016,7 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
-			pwr_i2c_sda_pz7 {
+			pwr-i2c-sda-pz7 {
 				nvidia,pins = "pwr_i2c_sda_pz7";
 				nvidia,function = "i2cpwr";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -1026,7 +1026,7 @@
 			};
 
 			/* PWR_INT_N */
-			pwr_int_n {
+			pwr-int-n {
 				nvidia,pins = "pwr_int_n";
 				nvidia,function = "pmi";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -1044,7 +1044,7 @@
 			};
 
 			/* RESET_OUT_N */
-			reset_out_n {
+			reset-out-n {
 				nvidia,pins = "reset_out_n";
 				nvidia,function = "reset_out_n";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -1053,14 +1053,14 @@
 			};
 
 			/* SHIFT_CTRL_DIR_IN */
-			kb_row0_pr0 {
+			kb-row0-pr0 {
 				nvidia,pins = "kb_row0_pr0";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row1_pr1 {
+			kb-row1-pr1 {
 				nvidia,pins = "kb_row1_pr1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
@@ -1069,7 +1069,7 @@
 			};
 
 			/* Configure level-shifter as output for HDA */
-			kb_row11_ps3 {
+			kb-row11-ps3 {
 				nvidia,pins = "kb_row11_ps3";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -1078,21 +1078,21 @@
 			};
 
 			/* SHIFT_CTRL_DIR_OUT */
-			kb_col5_pq5 {
+			kb-col5-pq5 {
 				nvidia,pins = "kb_col5_pq5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_col6_pq6 {
+			kb-col6-pq6 {
 				nvidia,pins = "kb_col6_pq6";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_col7_pq7 {
+			kb-col7-pq7 {
 				nvidia,pins = "kb_col7_pq7";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
@@ -1101,35 +1101,35 @@
 			};
 
 			/* SHIFT_CTRL_OE */
-			kb_col0_pq0 {
+			kb-col0-pq0 {
 				nvidia,pins = "kb_col0_pq0";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_col1_pq1 {
+			kb-col1-pq1 {
 				nvidia,pins = "kb_col1_pq1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_col2_pq2 {
+			kb-col2-pq2 {
 				nvidia,pins = "kb_col2_pq2";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_col4_pq4 {
+			kb-col4-pq4 {
 				nvidia,pins = "kb_col4_pq4";
 				nvidia,function = "kbc";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row2_pr2 {
+			kb-row2-pr2 {
 				nvidia,pins = "kb_row2_pr2";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
@@ -1147,7 +1147,7 @@
 			};
 
 			/* TOUCH_INT */
-			gpio_w3_aud_pw3 {
+			gpio-w3-aud-pw3 {
 				nvidia,pins = "gpio_w3_aud_pw3";
 				nvidia,function = "spi6";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -1288,189 +1288,189 @@
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap1_fs_pn0 { /* NC */
+			dap1-fs-pn0 { /* NC */
 				nvidia,pins = "dap1_fs_pn0";
 				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap1_din_pn1 { /* NC */
+			dap1-din-pn1 { /* NC */
 				nvidia,pins = "dap1_din_pn1";
 				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap1_sclk_pn3 { /* NC */
+			dap1-sclk-pn3 { /* NC */
 				nvidia,pins = "dap1_sclk_pn3";
 				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			ulpi_data7_po0 { /* NC */
+			ulpi-data7-po0 { /* NC */
 				nvidia,pins = "ulpi_data7_po0";
 				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			ulpi_data0_po1 { /* NC */
+			ulpi-data0-po1 { /* NC */
 				nvidia,pins = "ulpi_data0_po1";
 				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			ulpi_data1_po2 { /* NC */
+			ulpi-data1-po2 { /* NC */
 				nvidia,pins = "ulpi_data1_po2";
 				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			ulpi_data2_po3 { /* NC */
+			ulpi-data2-po3 { /* NC */
 				nvidia,pins = "ulpi_data2_po3";
 				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			ulpi_data3_po4 { /* NC */
+			ulpi-data3-po4 { /* NC */
 				nvidia,pins = "ulpi_data3_po4";
 				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			ulpi_data6_po7 { /* NC */
+			ulpi-data6-po7 { /* NC */
 				nvidia,pins = "ulpi_data6_po7";
 				nvidia,function = "ulpi";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap4_fs_pp4 { /* NC */
+			dap4-fs-pp4 { /* NC */
 				nvidia,pins = "dap4_fs_pp4";
 				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap4_din_pp5 { /* NC */
+			dap4-din-pp5 { /* NC */
 				nvidia,pins = "dap4_din_pp5";
 				nvidia,function = "rsvd3";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap4_dout_pp6 { /* NC */
+			dap4-dout-pp6 { /* NC */
 				nvidia,pins = "dap4_dout_pp6";
 				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap4_sclk_pp7 { /* NC */
+			dap4-sclk-pp7 { /* NC */
 				nvidia,pins = "dap4_sclk_pp7";
 				nvidia,function = "rsvd3";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_col3_pq3 { /* NC */
+			kb-col3-pq3 { /* NC */
 				nvidia,pins = "kb_col3_pq3";
 				nvidia,function = "kbc";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row3_pr3 { /* NC */
+			kb-row3-pr3 { /* NC */
 				nvidia,pins = "kb_row3_pr3";
 				nvidia,function = "kbc";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row4_pr4 { /* NC */
+			kb-row4-pr4 { /* NC */
 				nvidia,pins = "kb_row4_pr4";
 				nvidia,function = "rsvd3";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row5_pr5 { /* NC */
+			kb-row5-pr5 { /* NC */
 				nvidia,pins = "kb_row5_pr5";
 				nvidia,function = "rsvd3";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row6_pr6 { /* NC */
+			kb-row6-pr6 { /* NC */
 				nvidia,pins = "kb_row6_pr6";
 				nvidia,function = "kbc";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row7_pr7 { /* NC */
+			kb-row7-pr7 { /* NC */
 				nvidia,pins = "kb_row7_pr7";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row8_ps0 { /* NC */
+			kb-row8-ps0 { /* NC */
 				nvidia,pins = "kb_row8_ps0";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row9_ps1 { /* NC */
+			kb-row9-ps1 { /* NC */
 				nvidia,pins = "kb_row9_ps1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row12_ps4 { /* NC */
+			kb-row12-ps4 { /* NC */
 				nvidia,pins = "kb_row12_ps4";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row13_ps5 { /* NC */
+			kb-row13-ps5 { /* NC */
 				nvidia,pins = "kb_row13_ps5";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row14_ps6 { /* NC */
+			kb-row14-ps6 { /* NC */
 				nvidia,pins = "kb_row14_ps6";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row15_ps7 { /* NC */
+			kb-row15-ps7 { /* NC */
 				nvidia,pins = "kb_row15_ps7";
 				nvidia,function = "rsvd3";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row16_pt0 { /* NC */
+			kb-row16-pt0 { /* NC */
 				nvidia,pins = "kb_row16_pt0";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			kb_row17_pt1 { /* NC */
+			kb-row17-pt1 { /* NC */
 				nvidia,pins = "kb_row17_pt1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
@@ -1498,14 +1498,14 @@
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			gpio_x1_aud_px1 { /* NC */
+			gpio-x1-aud-px1 { /* NC */
 				nvidia,pins = "gpio_x1_aud_px1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			gpio_x3_aud_px3 { /* NC */
+			gpio-x3-aud-px3 { /* NC */
 				nvidia,pins = "gpio_x3_aud_px3";
 				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
@@ -1533,14 +1533,14 @@
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			clk3_req_pee1 { /* NC */
+			clk3-req-pee1 { /* NC */
 				nvidia,pins = "clk3_req_pee1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
-			dap_mclk1_req_pee2 { /* NC */
+			dap-mclk1-req-pee2 { /* NC */
 				nvidia,pins = "dap_mclk1_req_pee2";
 				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
@@ -1556,7 +1556,7 @@
 			 * SDMMC_VENDOR_MISC_CNTRL_0 register's SDMMC_SPARE1
 			 * bits being set to 0xfffd according to the TRM!
 			 */
-			sdmmc3_clk_lb_out_pee4 { /* NC */
+			sdmmc3-clk-lb-out-pee4 { /* NC */
 				nvidia,pins = "sdmmc3_clk_lb_out_pee4";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -1610,14 +1610,14 @@
 			pinctrl-0 = <&as3722_default>;
 
 			as3722_default: pinmux {
-				gpio2_7 {
+				gpio2-7 {
 					pins = "gpio2", /* PWR_EN_+V3.3 */
 					       "gpio7"; /* +V1.6_LPO */
 					function = "gpio";
 					bias-pull-up;
 				};
 
-				gpio0_1_3_4_5_6 {
+				gpio0-1-3-4-5-6 {
 					pins = "gpio0", "gpio1", "gpio3",
 					       "gpio4", "gpio5", "gpio6";
 					bias-high-impedance;
@@ -2078,7 +2078,7 @@
 
 &gpio {
 	/* I210 Gigabit Ethernet Controller Reset */
-	lan_reset_n {
+	lan-reset-n {
 		gpio-hog;
 		gpios = <TEGRA_GPIO(S, 2) GPIO_ACTIVE_HIGH>;
 		output-high;
@@ -2086,7 +2086,7 @@
 	};
 
 	/* Control MXM3 pin 26 Reset Module Output Carrier Input */
-	reset_moci_ctrl {
+	reset-moci-ctrl {
 		gpio-hog;
 		gpios = <TEGRA_GPIO(U, 4) GPIO_ACTIVE_HIGH>;
 		output-high;
-- 
2.14.4

