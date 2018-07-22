Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063FAECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C49C20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C49C20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731214AbeGVRrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:47 -0400
Received: from mout.perfora.net ([74.208.4.196]:46483 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729936AbeGVRrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:46 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MejCI-1fNXks2sIq-00OIrP; Sun, 22 Jul 2018 18:50:23 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 19/28] ARM: tegra: apalis_t30: add missing pinmux
Date:   Sun, 22 Jul 2018 18:49:27 +0200
Message-Id: <20180722164936.20581-20-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:FaP9uorz/ZO6IQ4nW5jIJPkvqHU6DeVoXTGmUnUDM+JU5VBXxBA
 3vp6h9zPE8ArKBKCodPo8xG62lKKoSfaKgv/UUT1hyKETHFiXxd3/iZZsmAPmyrHzaVkjqY
 PjUbFsrx5Ec90S8iGqhhF3+GUUCFtPiwtwcQF6ZuZjWRSfe/vn9slbsx5IDS++HWATsYX6/
 8gHXfu/nU77lhjGYQXBTQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4GdAy5IZKP0=:G3yzNGzV4l9sQwlEM6P2XG
 P+ninmFTkgJUKdHlcx1VptMn2mtbGevkCkZqgIdTARJl+edBRYknjFIslAjKjcsHluHPqAKq8
 Y4dFHNSpxvtzHlFEgy0lo388oB/MHCuGhWDcr9aSWPra2o/JMhLDY/EDIyZoqYK5Lqe7KZ1Mf
 PudlUal+1PLfmiQ39laIaPj1WKKiUDibjiAa+IIUx1NwO/jD7b/FE570rRVfIPYlvleBWKI+/
 n33ToBBmH2z6zts8rJ1JqlgsKwdMNqxa0tfnG7bQ1K5+3udJv6dpgTUFkV9z74Roy0a6sgcYF
 D4K1sRSccpfU6UzhWkit/Vf6pUB+LP8Cx3blqI2Gl40ThUe5UemcAQt60nPShH39ZYeZlgTUB
 fsyqowbzT7uorl9el7U7Jo/szog9hPK0Hd0XjTn4Jte0CNBenKgbfL0pYEoHEs4Xn66QZGvT0
 odL6uATyDb2vbJrYlhfEAVQLqbcGUzARAMwN5M5XEKbMhNFpuvqFDnZAn5mWpcvgFFoEYZdBR
 tBpx1EArZvTrBvptWEI2e1ePGJicm4waPvjaDif6yiTMiOAK9ajHsKb+qgeI4WUOzMEH9Z46r
 /5awOaRUMdXCipndY8IB1bLSSo62ljQNJCuzU1RJ1AionEgz/lulIT7IhX6YoOdlFph9+sLVc
 vDy6dvQRYB+uXHPVjUZdVtxrtSuOE6bHOr0MZkuzO7+GU4GvVBuj3ZEAuqEJkrjepLCo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Explicitly mux all T30 SoC balls now:
- Apalis GPIO
- Apalis HDMI1
- Apalis I2C1
- Apalis I2C2 (DDC)
- Apalis LCD1
- Apalis Parallel Camera
- Apalis SATA1_ACT#
- Apalis SPDIF1
- Apalis TS (Low-speed type specific)
- Apalis USBH_EN
- Apalis USBH_OC#
- Apalis VGA1
- on-module i210/i211 LAN control signals
- not connected and therefore disabled signals

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 370 ++++++++++++++++++++++++++++++++++
 1 file changed, 370 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index ac87eeebab03..ad48b0daa0f8 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -165,6 +165,68 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
+			/* Apalis GPIO */
+			kb_col0_pq0 {
+				nvidia,pins = "kb_col0_pq0",
+					      "kb_col1_pq1",
+					      "kb_row10_ps2",
+					      "kb_row11_ps3",
+					      "kb_row12_ps4",
+					      "kb_row13_ps5",
+					      "kb_row14_ps6",
+					      "kb_row15_ps7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			/* Multiplexed and therefore disabled */
+			owr {
+				nvidia,pins = "owr";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis HDMI1 */
+			hdmi_cec_pee3 {
+				nvidia,pins = "hdmi_cec_pee3";
+				nvidia,function = "cec";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+			};
+			hdmi_int_pn7 {
+				nvidia,pins = "hdmi_int_pn7";
+				nvidia,function = "hdmi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis I2C1 */
+			gen1_i2c_scl_pc4 {
+				nvidia,pins = "gen1_i2c_scl_pc4",
+					      "gen1_i2c_sda_pc5";
+				nvidia,function = "i2c1";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+			};
+
+			/* Apalis I2C2 (DDC) */
+			ddc_scl_pv4 {
+				nvidia,pins = "ddc_scl_pv4",
+					      "ddc_sda_pv5";
+				nvidia,function = "i2c4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
 			/* Apalis I2C3 (CAM) */
 			cam_i2c_scl_pbb1 {
 				nvidia,pins = "cam_i2c_scl_pbb1",
@@ -176,6 +238,42 @@
 				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
 
+			/* Apalis LCD1 */
+			lcd_d0_pe0 {
+				nvidia,pins = "lcd_d0_pe0",
+					      "lcd_d1_pe1",
+					      "lcd_d2_pe2",
+					      "lcd_d3_pe3",
+					      "lcd_d4_pe4",
+					      "lcd_d5_pe5",
+					      "lcd_d6_pe6",
+					      "lcd_d7_pe7",
+					      "lcd_d8_pf0",
+					      "lcd_d9_pf1",
+					      "lcd_d10_pf2",
+					      "lcd_d11_pf3",
+					      "lcd_d12_pf4",
+					      "lcd_d13_pf5",
+					      "lcd_d14_pf6",
+					      "lcd_d15_pf7",
+					      "lcd_d16_pm0",
+					      "lcd_d17_pm1",
+					      "lcd_d18_pm2",
+					      "lcd_d19_pm3",
+					      "lcd_d20_pm4",
+					      "lcd_d21_pm5",
+					      "lcd_d22_pm6",
+					      "lcd_d23_pm7",
+					      "lcd_de_pj1",
+					      "lcd_hsync_pj3",
+					      "lcd_pclk_pb3",
+					      "lcd_vsync_pj4";
+				nvidia,function = "displaya";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
 			/* Apalis MMC1 */
 			sdmmc3_clk_pa6 {
 				nvidia,pins = "sdmmc3_clk_pa6";
@@ -206,6 +304,77 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
+			/* Apalis Parallel Camera */
+			cam_mclk_pcc0 {
+				nvidia,pins = "cam_mclk_pcc0";
+				nvidia,function = "vi_alt3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			vi_vsync_pd6 {
+				nvidia,pins = "vi_d0_pt4",
+					      "vi_d1_pd5",
+					      "vi_d2_pl0",
+					      "vi_d3_pl1",
+					      "vi_d4_pl2",
+					      "vi_d5_pl3",
+					      "vi_d6_pl4",
+					      "vi_d7_pl5",
+					      "vi_d8_pl6",
+					      "vi_d9_pl7",
+					      "vi_d10_pt2",
+					      "vi_d11_pt3",
+					      "vi_hsync_pd7",
+					      "vi_pclk_pt0",
+					      "vi_vsync_pd6";
+				nvidia,function = "vi";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			/* Multiplexed and therefore disabled */
+			kb_col2_pq2 {
+				nvidia,pins = "kb_col2_pq2",
+					      "kb_col3_pq3",
+					      "kb_col4_pq4",
+					      "kb_row4_pr4";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			kb_row0_pr0 {
+				nvidia,pins = "kb_row0_pr0",
+					      "kb_row1_pr1",
+					      "kb_row2_pr2",
+					      "kb_row3_pr3";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			kb_row5_pr5 {
+				nvidia,pins = "kb_row5_pr5",
+					      "kb_row6_pr6",
+					      "kb_row7_pr7";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			/*
+			 * VI level-shifter direction
+			 * (pull-down => default direction input)
+			 */
+			vi_mclk_pt1 {
+				nvidia,pins = "vi_mclk_pt1";
+				nvidia,function = "vi_alt3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
 			/* Apalis PWM1 */
 			pu6 {
 				nvidia,pins = "pu6";
@@ -246,6 +415,15 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
+			/* Apalis SATA1_ACT# */
+			pex_l0_prsnt_n_pdd0 {
+				nvidia,pins = "pex_l0_prsnt_n_pdd0";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
 			/* Apalis SD1 */
 			sdmmc1_clk_pz0 {
 				nvidia,pins = "sdmmc1_clk_pz0";
@@ -272,6 +450,16 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
+			/* Apalis SPDIF1 */
+			spdif_out_pk5 {
+				nvidia,pins = "spdif_out_pk5",
+					      "spdif_in_pk6";
+				nvidia,function = "spdif";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
 			/* Apalis SPI1 */
 			spi1_sck_px5 {
 				nvidia,pins = "spi1_sck_px5",
@@ -294,6 +482,28 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
+			/*
+			 * Apalis TS (Low-speed type specific)
+			 * pins may be used as GPIOs
+			 */
+			kb_col5_pq5 {
+				nvidia,pins = "kb_col5_pq5";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			kb_col6_pq6 {
+				nvidia,pins = "kb_col6_pq6",
+					      "kb_col7_pq7",
+					      "kb_row8_ps0",
+					      "kb_row9_ps1";
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
 			/* Apalis UART1 */
 			ulpi_data0 {
 				nvidia,pins = "ulpi_data0_po1",
@@ -338,6 +548,24 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 
+			/* Apalis USBH_EN */
+			pex_l0_rst_n_pdd1 {
+				nvidia,pins = "pex_l0_rst_n_pdd1";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
+			/* Apalis USBH_OC# */
+			pex_l0_clkreq_n_pdd2 {
+				nvidia,pins = "pex_l0_clkreq_n_pdd2";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
 			/* Apalis USBO1_EN */
 			gen2_i2c_scl_pt5 {
 				nvidia,pins = "gen2_i2c_scl_pt5";
@@ -357,6 +585,16 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
+			/* Apalis VGA1 not supported and therefore disabled */
+			crt_hsync_pv6 {
+				nvidia,pins = "crt_hsync_pv6",
+					      "crt_vsync_pv7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
 			/* Apalis WAKE1_MICO */
 			pv1 {
 				nvidia,pins = "pv1";
@@ -391,6 +629,33 @@
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 
+			/* LAN i210/i211 DEV_OFF_N, PE_RST_N (On-module) */
+			pex_l2_prsnt_n_pdd7 {
+				nvidia,pins = "pex_l2_prsnt_n_pdd7",
+					      "pex_l2_rst_n_pcc6";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			/* LAN i210/i211 PE_WAKE_N, SDP3 (On-module) */
+			pex_wake_n_pdd3 {
+				nvidia,pins = "pex_wake_n_pdd3",
+					      "pex_l2_clkreq_n_pcc7";
+				nvidia,function = "pcie";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+			/* LAN i210/i211 SMB_ALERT_N (On-module) */
+			sys_clk_req_pz5 {
+				nvidia,pins = "sys_clk_req_pz5";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+			};
+
 			/* LVDS Transceiver Configuration */
 			pbb0 {
 				nvidia,pins = "pbb0",
@@ -413,6 +678,111 @@
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 
+			/* Not connected and therefore disabled */
+			clk_32k_out_pa0 {
+				nvidia,pins = "clk3_out_pee0",
+					      "clk3_req_pee1",
+					      "clk_32k_out_pa0",
+					      "dap4_din_pp5",
+					      "dap4_dout_pp6",
+					      "dap4_fs_pp4",
+					      "dap4_sclk_pp7";
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			dap2_fs_pa2 {
+				nvidia,pins = "dap2_fs_pa2",
+					      "dap2_sclk_pa3",
+					      "dap2_din_pa4",
+					      "dap2_dout_pa5",
+					      "lcd_dc0_pn6",
+					      "lcd_m1_pw1",
+					      "lcd_pwr1_pc1",
+					      "pex_l1_clkreq_n_pdd6",
+					      "pex_l1_prsnt_n_pdd4",
+					      "pex_l1_rst_n_pdd5";
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi_ad0_pg0 {
+				nvidia,pins = "gmi_ad0_pg0",
+					      "gmi_ad2_pg2",
+					      "gmi_ad3_pg3",
+					      "gmi_ad4_pg4",
+					      "gmi_ad5_pg5",
+					      "gmi_ad6_pg6",
+					      "gmi_ad7_pg7",
+					      "gmi_ad8_ph0",
+					      "gmi_ad9_ph1",
+					      "gmi_ad10_ph2",
+					      "gmi_ad11_ph3",
+					      "gmi_ad12_ph4",
+					      "gmi_ad13_ph5",
+					      "gmi_ad14_ph6",
+					      "gmi_ad15_ph7",
+					      "gmi_adv_n_pk0",
+					      "gmi_clk_pk1",
+					      "gmi_cs4_n_pk2",
+					      "gmi_cs2_n_pk3",
+					      "gmi_dqs_pi2",
+					      "gmi_iordy_pi5",
+					      "gmi_oe_n_pi1",
+					      "gmi_wait_pi7",
+					      "gmi_wr_n_pi0",
+					      "lcd_cs1_n_pw0",
+					      "pu0",
+					      "pu1",
+					      "pu2";
+				nvidia,function = "rsvd4";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi_cs0_n_pj0 {
+				nvidia,pins = "gmi_cs0_n_pj0",
+					      "gmi_cs1_n_pj2",
+					      "gmi_cs3_n_pk4";
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi_cs6_n_pi3 {
+				nvidia,pins = "gmi_cs6_n_pi3";
+				nvidia,function = "sata";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			gmi_cs7_n_pi6 {
+				nvidia,pins = "gmi_cs7_n_pi6";
+				nvidia,function = "gmi_alt";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			lcd_pwr0_pb2 {
+				nvidia,pins = "lcd_pwr0_pb2",
+					      "lcd_pwr2_pc6",
+					      "lcd_wr_n_pz3";
+				nvidia,function = "hdcp";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+			uart2_cts_n_pj5 {
+				nvidia,pins = "uart2_cts_n_pj5",
+					      "uart2_rts_n_pj6";
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+			};
+
 			/* Power I2C (On-module) */
 			pwr_i2c_scl_pz6 {
 				nvidia,pins = "pwr_i2c_scl_pz6",
-- 
2.14.4

