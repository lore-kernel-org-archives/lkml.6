Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbeEQJbZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:31:25 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46189 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752237AbeEQJbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:31:19 -0400
X-Google-Smtp-Source: AB8JxZqesmOwrvWMld+trW7yZSo3n44eUIVYdE32oXLt09mHBdmm+bNyW7jxiMFGe8uotQgwLRg7wQ==
From: Jerome Brunet <jbrunet@baylibre.com>
To: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] ARM64: dts: meson-axg: add i2c AO pins
Date: Thu, 17 May 2018 11:30:59 +0200
Message-Id: <20180517093100.22225-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180517093100.22225-1-jbrunet@baylibre.com>
References: <20180517093100.22225-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pins related to the i2c AO controller of the meson-axg platform

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 42 ++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index d213ab715e03..e315701cb6ac 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1046,6 +1046,48 @@
 					gpio-ranges = <&pinctrl_aobus 0 0 15>;
 				};
 
+				i2c_ao_sck_4_pins: i2c_ao_sck_4 {
+					mux {
+						groups = "i2c_ao_sck_4";
+						function = "i2c_ao";
+					};
+				};
+
+				i2c_ao_sck_8_pins: i2c_ao_sck_8 {
+					mux {
+						groups = "i2c_ao_sck_8";
+						function = "i2c_ao";
+					};
+				};
+
+				i2c_ao_sck_10_pins: i2c_ao_sck_10 {
+					mux {
+						groups = "i2c_ao_sck_10";
+						function = "i2c_ao";
+					};
+				};
+
+				i2c_ao_sda_5_pins: i2c_ao_sda_5 {
+					mux {
+						groups = "i2c_ao_sda_5";
+						function = "i2c_ao";
+					};
+				};
+
+				i2c_ao_sda_9_pins: i2c_ao_sda_9 {
+					mux {
+						groups = "i2c_ao_sda_9";
+						function = "i2c_ao";
+					};
+				};
+
+				i2c_ao_sda_11_pins: i2c_ao_sda_11 {
+					mux {
+						groups = "i2c_ao_sda_11";
+						function = "i2c_ao";
+					};
+				};
+
 				remote_input_ao_pins: remote_input_ao {
 					mux {
 						groups = "remote_input_ao";
-- 
2.14.3
