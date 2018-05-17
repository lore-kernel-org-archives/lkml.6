Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeEQTTg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 15:19:36 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46466 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeEQTTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 15:19:34 -0400
X-Google-Smtp-Source: AB8JxZp+jQdZ33kguSkrw4L1R2SdJxBCjKDva3uTJfVLhihWxSUcP6Hbd8GCjyNOloQIhC/Af6dCqQ==
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>, Chris Healy <cphealy@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Marco Franchi <marcofrk@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] ARM: dts: imx51-zii-rdu1: add rave-sp subdevices
Date: Thu, 17 May 2018 22:19:23 +0300
Message-Id: <20180517191923.16212-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds rave-sp powerbutton and backlight devices to RDU1 device tree.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 arch/arm/boot/dts/imx51-zii-rdu1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 0c99ac04ad08..98cc107098e0 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -581,6 +581,14 @@
 		watchdog {
 			compatible = "zii,rave-sp-watchdog";
 		};
+
+		backlight {
+			compatible = "zii,rave-sp-backlight";
+		};
+
+		pwrbutton {
+			compatible = "zii,rave-sp-pwrbutton";
+		};
 	};
 };
 
-- 
2.11.0
