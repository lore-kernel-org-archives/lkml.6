Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbeEAWsj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 18:48:39 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34065 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbeEAWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 18:48:37 -0400
X-Google-Smtp-Source: AB8JxZrqNFCpdyB1OLfXehF3teBTbArl4pyw44zxMs2PKW99uFDV8Rfh3B6ANol/qm5Ii+Jbsd6Brg==
Date: Tue, 1 May 2018 15:48:33 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: at91: sama5d4ek: use canonical compatible for
 touchscreen
Message-ID: <20180501224833.GA151132@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The canonical compatible string is "atmel,maxtouch", let's use it. Also,
change the node name to be "touchscreen" rather than driver name.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/boot/dts/at91-sama5d4ek.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
index 7887a7160a54e..0702a2f2b336c 100644
--- a/arch/arm/boot/dts/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
@@ -129,8 +129,8 @@
 					wakeup-source;
 				};
 
-				atmel_mxt_ts@4c {
-					compatible = "atmel,atmel_mxt_ts";
+				touchscreen@4c {
+					compatible = "atmel,maxtouch";
 					reg = <0x4c>;
 					interrupt-parent = <&pioE>;
 					interrupts = <24 0x0>;
-- 
2.17.0.441.gb46fe60e1d-goog


-- 
Dmitry
