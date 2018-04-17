Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752306AbeDQJk6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:40:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42409 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbeDQJky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:40:54 -0400
X-Google-Smtp-Source: AIpwx49or+1BbvBe9/TCTVIR1sV5lkLnzOxpdPy+p5DC0IEycnm68ZxUy/suex46MvU5dkOR0Pf8HQ==
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S . Miller" <davem@davemloft.net>,
        Holger Brunck <holger.brunck@keymile.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH 3/3] powerpc: dts: use a correct at24 compatible fallback in ac14xx
Date: Tue, 17 Apr 2018 11:40:30 +0200
Message-Id: <20180417094030.7224-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417094030.7224-1-brgl@bgdev.pl>
References: <20180417094030.7224-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using 'at24' as fallback is now deprecated - use the full
'atmel,<model>' string.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/powerpc/boot/dts/ac14xx.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/boot/dts/ac14xx.dts b/arch/powerpc/boot/dts/ac14xx.dts
index 83bcfd865167..0be5c4f3265d 100644
--- a/arch/powerpc/boot/dts/ac14xx.dts
+++ b/arch/powerpc/boot/dts/ac14xx.dts
@@ -176,12 +176,12 @@
 			clock-frequency = <400000>;
 
 			at24@30 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x30>;
 			};
 
 			at24@31 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x31>;
 			};
 
@@ -191,42 +191,42 @@
 			};
 
 			at24@50 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x50>;
 			};
 
 			at24@51 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x51>;
 			};
 
 			at24@52 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x52>;
 			};
 
 			at24@53 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x53>;
 			};
 
 			at24@54 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x54>;
 			};
 
 			at24@55 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x55>;
 			};
 
 			at24@56 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x56>;
 			};
 
 			at24@57 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x57>;
 			};
 
-- 
2.17.0
