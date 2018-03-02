Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428407AbeCBN5Q (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:57:16 -0500
Received: from laurent.telenet-ops.be ([195.130.137.89]:41032 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424694AbeCBN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:56:39 -0500
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>, Chanho Min <chanho.min@lge.com>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v4 4/4] dt-bindings: net: btusb: DT fix s/interrupt-name/interrupt-names/
Date: Fri,  2 Mar 2018 14:56:33 +0100
Message-Id: <1519998993-14398-5-git-send-email-geert+renesas@glider.be>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519998993-14398-1-git-send-email-geert+renesas@glider.be>
References: <1519998993-14398-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: fd913ef7ce619467 ("Bluetooth: btusb: Add out-of-band wakeup support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
---
v4:
  - Add Acked-by,

v3:
  - New.
---
 Documentation/devicetree/bindings/net/btusb.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/btusb.txt b/Documentation/devicetree/bindings/net/btusb.txt
index 9c5e663fa1afccaf..828a04695e1be517 100644
--- a/Documentation/devicetree/bindings/net/btusb.txt
+++ b/Documentation/devicetree/bindings/net/btusb.txt
@@ -36,7 +36,7 @@ Following example uses irq pin number 3 of gpio0 for out of band wake-on-bt:
 	compatible = "usb1286,204e";
 	reg = <1>;
 	interrupt-parent = <&gpio0>;
-	interrupt-name = "wakeup";
+	interrupt-names = "wakeup";
 	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
     };
 };
-- 
2.7.4
