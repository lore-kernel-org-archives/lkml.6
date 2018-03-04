Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeCDOwv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 09:52:51 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:57573 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbeCDOwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 09:52:49 -0500
Date: Sun, 4 Mar 2018 15:52:43 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] irq udpate for 4.16
Message-ID: <alpine.DEB.2.21.1803041550210.2394@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-for-linus

Just a documentation update for the missing device tree property of the
R-Car M3N interrupt controller.

Thanks,

	tglx

------------------>
Geert Uytterhoeven (1):
      dt-bindings/irqchip/renesas-irqc: Document R-Car M3-N support


 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
index 33c9a10fdc91..20f121daa910 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
@@ -14,6 +14,7 @@ Required properties:
     - "renesas,irqc-r8a7794" (R-Car E2)
     - "renesas,intc-ex-r8a7795" (R-Car H3)
     - "renesas,intc-ex-r8a7796" (R-Car M3-W)
+    - "renesas,intc-ex-r8a77965" (R-Car M3-N)
     - "renesas,intc-ex-r8a77970" (R-Car V3M)
     - "renesas,intc-ex-r8a77995" (R-Car D3)
 - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
