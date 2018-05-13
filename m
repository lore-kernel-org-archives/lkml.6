Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752052AbeEMX0n (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 19:26:43 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45370 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbeEMX0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 19:26:42 -0400
X-Google-Smtp-Source: AB8JxZpd2sk0599KVyqAYGGCGRM4pqd+vGIMkDSkX0u4WrPv587w1DijQhfba/j/ow9b/U7olpOKiA==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: shawnguo@kernel.org
Cc: s.hauer@pengutronix.de, kernel@pengutronix.de, fabio.estevam@nxp.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH] ARM: dts: imx53-qsb: Use IRQ_TYPE specifier
Date: Sun, 13 May 2018 20:26:28 -0300
Message-Id: <1526253988-3848-1-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace magic number with the proper IRQ_TYPE specifier to improve DT
readability.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/imx53-qsb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index d3d662e..dca6c32 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -23,7 +23,7 @@
 		compatible = "dlg,da9053-aa", "dlg,da9052";
 		reg = <0x48>;
 		interrupt-parent = <&gpio7>;
-		interrupts = <11 0x8>; /* low-level active IRQ at GPIO7_11 */
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>; /* low-level active IRQ at GPIO7_11 */
 
 		regulators {
 			buck1_reg: buck1 {
-- 
2.7.4
