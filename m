Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeDQGkr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 02:40:47 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43628 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeDQGkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 02:40:45 -0400
X-Google-Smtp-Source: AIpwx4++i98WMdAzUlMM3z4X6nHCE59tPiZkUfhEKEj3bo/l7zKPDbOKf9NYK2e3ffh9lXeq8EId2A==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] ARM64: dts: meson-axg: add tdm pins
Date: Tue, 17 Apr 2018 08:40:35 +0200
Message-Id: <20180417064035.28776-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tdm pins to amlogic's A113 device tree

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 245 +++++++++++++++++++++++++++++
 1 file changed, 245 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b58808eb3cc8..74013965e86a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -660,6 +660,251 @@
 						function = "uart_ao_b_z";
 					};
 				};
+
+				mclk_b_pins: mclk_b {
+					mux {
+						groups = "mclk_b";
+						function = "mclk_b";
+					};
+				};
+
+				mclk_c_pins: mclk_c {
+					mux {
+						groups = "mclk_c";
+						function = "mclk_c";
+					};
+				};
+
+				tdma_sclk_pins: tdma_sclk {
+					mux {
+						groups = "tdma_sclk";
+						function = "tdma";
+					};
+				};
+
+				tdma_sclk_slv_pins: tdma_sclk_slv {
+					mux {
+						groups = "tdma_sclk_slv";
+						function = "tdma";
+					};
+				};
+
+				tdma_fs_pins: tdma_fs {
+					mux {
+						groups = "tdma_fs";
+						function = "tdma";
+					};
+				};
+
+				tdma_fs_slv_pins: tdma_fs_slv {
+					mux {
+						groups = "tdma_fs_slv";
+						function = "tdma";
+					};
+				};
+
+				tdma_din0_pins: tdma_din0 {
+					mux {
+						groups = "tdma_din0";
+						function = "tdma";
+					};
+				};
+
+				tdma_dout0_x14_pins: tdma_dout0_x14 {
+					mux {
+						groups = "tdma_dout0_x14";
+						function = "tdma";
+					};
+				};
+
+				tdma_dout0_x15_pins: tdma_dout0_x15 {
+					mux {
+						groups = "tdma_dout0_x15";
+						function = "tdma";
+					};
+				};
+
+				tdma_dout1_pins: tdma_dout1 {
+					mux {
+						groups = "tdma_dout1";
+						function = "tdma";
+					};
+				};
+
+				tdma_din1_pins: tdma_din1 {
+					mux {
+						groups = "tdma_din1";
+						function = "tdma";
+					};
+				};
+
+				tdmb_sclk_pins: tdmb_sclk {
+					mux {
+						groups = "tdmb_sclk";
+						function = "tdmb";
+					};
+				};
+
+				tdmb_sclk_slv_pins: tdmb_sclk_slv {
+					mux {
+						groups = "tdmb_sclk_slv";
+						function = "tdmb";
+					};
+				};
+
+				tdmb_fs_pins: tdmb_fs {
+					mux {
+						groups = "tdmb_fs";
+						function = "tdmb";
+					};
+				};
+
+				tdmb_fs_slv_pins: tdmb_fs_slv {
+					mux {
+						groups = "tdmb_fs_slv";
+						function = "tdmb";
+					};
+				};
+
+				tdmb_din0_pins: tdmb_din0 {
+					mux {
+						groups = "tdmb_din0";
+						function = "tdmb";
+					};
+				};
+
+				tdmb_dout0_pins: tdmb_dout0 {
+					mux {
+						groups = "tdmb_dout0";
+						function = "tdmb";
+					};
+				};
+
+				tdmb_din1_pins: tdmb_din1 {
+					mux {
+						groups = "tdmb_din1";
+						function = "tdmb";
+					};
+				};
+
+				tdmb_dout1_pins: tdmb_dout1 {
+					mux {
+						groups = "tdmb_dout1";
+						function = "tdmb";
+					};
+				};
+
+				tdmb_din2_pins: tdmb_din2 {
+					mux {
+						groups = "tdmb_din2";
+						function = "tdmb";
+					};
+				};
+
+				tdmb_dout2_pins: tdmb_dout2 {
+					mux {
+						groups = "tdmb_dout2";
+						function = "tdmb";
+					};
+				};
+
+				tdmb_din3_pins: tdmb_din3 {
+					mux {
+						groups = "tdmb_din3";
+						function = "tdmb";
+					};
+				};
+
+				tdmb_dout3_pins: tdmb_dout3 {
+					mux {
+						groups = "tdmb_dout3";
+						function = "tdmb";
+					};
+				};
+
+				tdmc_sclk_pins: tdmc_sclk {
+					mux {
+						groups = "tdmc_sclk";
+						function = "tdmc";
+					};
+				};
+
+				tdmc_sclk_slv_pins: tdmc_sclk_slv {
+					mux {
+						groups = "tdmc_sclk_slv";
+						function = "tdmc";
+					};
+				};
+
+				tdmc_fs_pins: tdmc_fs {
+					mux {
+						groups = "tdmc_fs";
+						function = "tdmc";
+					};
+				};
+
+				tdmc_fs_slv_pins: tdmc_fs_slv {
+					mux {
+						groups = "tdmc_fs_slv";
+						function = "tdmc";
+					};
+				};
+
+				tdmc_din0_pins: tdmc_din0 {
+					mux {
+						groups = "tdmc_din0";
+						function = "tdmc";
+					};
+				};
+
+				tdmc_dout0_pins: tdmc_dout0 {
+					mux {
+						groups = "tdmc_dout0";
+						function = "tdmc";
+					};
+				};
+
+				tdmc_din1_pins: tdmc_din1 {
+					mux {
+						groups = "tdmc_din1";
+						function = "tdmc";
+					};
+				};
+
+				tdmc_dout1_pins: tdmc_dout1 {
+					mux {
+						groups = "tdmc_dout1";
+						function = "tdmc";
+					};
+				};
+
+				tdmc_din2_pins: tdmc_din2 {
+					mux {
+						groups = "tdmc_din2";
+						function = "tdmc";
+					};
+				};
+
+				tdmc_dout2_pins: tdmc_dout2 {
+					mux {
+						groups = "tdmc_dout2";
+						function = "tdmc";
+					};
+				};
+
+				tdmc_din3_pins: tdmc_din3 {
+					mux {
+						groups = "tdmc_din3";
+						function = "tdmc";
+					};
+				};
+
+				tdmc_dout3_pins: tdmc_dout3 {
+					mux {
+						groups = "tdmc_dout3";
+						function = "tdmc";
+					};
+				};
 			};
 		};
 
-- 
2.14.3
