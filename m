Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755544AbeEAP7G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 11:59:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58048 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751071AbeEAP7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 11:59:04 -0400
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
        Ian Ray <ian.ray@ge.com>, Ken Lin <ken.lin@advantech.com.tw>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH] ARM: dts: imx: ba16: add "mfg" Q7 SPI-NOR partition
Date: Tue,  1 May 2018 17:58:48 +0200
Message-Id: <20180501155848.16354-1-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ken Lin <ken.lin@advantech.com.tw>

Add the 4th partiton named "mfg" with a block size 64K to store
manufacturing data.

Signed-off-by: Ken Lin <ken.lin@advantech.com.tw>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 arch/arm/boot/dts/imx6q-ba16.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-ba16.dtsi b/arch/arm/boot/dts/imx6q-ba16.dtsi
index bf4bdb385de9..e903c488287b 100644
--- a/arch/arm/boot/dts/imx6q-ba16.dtsi
+++ b/arch/arm/boot/dts/imx6q-ba16.dtsi
@@ -157,7 +157,12 @@
 
 		partition@d0000 {
 			label = "spare";
-			reg = <0xd0000 0x130000>;
+			reg = <0xd0000 0x320000>;
+		};
+
+		partition@3f0000 {
+			label = "mfg";
+			reg = <0x3f0000 0x10000>;
 		};
 	};
 };
-- 
2.17.0
