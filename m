Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752242AbeEGNx2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 09:53:28 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35676 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751794AbeEGNxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 09:53:23 -0400
X-Google-Smtp-Source: AB8JxZpzpCZjCLSKUd/285DsjqTpVaaI7H4C19cGHN/hlJEsBvLcxp1lHU3NtZyjORcxLl0lag+AKA==
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marco Franchi <marcofrk@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Healy <Chris.Healy@zii.aero>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: fix touchscreen bindings
Date: Mon,  7 May 2018 16:53:09 +0300
Message-Id: <20180507135309.32580-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes errors in RDU1 device tree that cause touch screens not
working.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 0c99ac04ad08..6464f2560e06 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -523,7 +523,7 @@
 	};
 
 	touchscreen@20 {
-		compatible = "syna,rmi4_i2c";
+		compatible = "syna,rmi4-i2c";
 		reg = <0x20>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_ts>;
@@ -541,8 +541,8 @@
 
 		rmi4-f11@11 {
 			reg = <0x11>;
-			touch-inverted-y;
-			touch-swapped-x-y;
+			touchscreen-inverted-y;
+			touchscreen-swapped-x-y;
 			syna,sensor-type = <1>;
 		};
 	};
-- 
2.11.0
