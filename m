Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeBTPOR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 10:14:17 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:52369 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752534AbeBTPOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 10:14:14 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/19] dt-bindings: serial: sh-sci: Add support for r8a77965 (H)SCIF
Date: Tue, 20 Feb 2018 16:12:14 +0100
Message-Id: <1519139541-18783-13-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for r8a77965 compatible string to Renesas sci-serial
device tree bindings documentation.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index cf504d0..88f947c 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -41,6 +41,8 @@ Required properties:
     - "renesas,hscif-r8a7795" for R8A7795 (R-Car H3) HSCIF compatible UART.
     - "renesas,scif-r8a7796" for R8A7796 (R-Car M3-W) SCIF compatible UART.
     - "renesas,hscif-r8a7796" for R8A7796 (R-Car M3-W) HSCIF compatible UART.
+    - "renesas,scif-r8a77965" for R8A77965 (R-Car M3-N) SCIF compatible UART.
+    - "renesas,hscif-r8a77965" for R8A77965 (R-Car M3-N) HSCIF compatible UART.
     - "renesas,scif-r8a77970" for R8A77970 (R-Car V3M) SCIF compatible UART.
     - "renesas,hscif-r8a77970" for R8A77970 (R-Car V3M) HSCIF compatible UART.
     - "renesas,scif-r8a77995" for R8A77995 (R-Car D3) SCIF compatible UART.
-- 
2.7.4
