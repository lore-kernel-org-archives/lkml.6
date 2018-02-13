Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934851AbeBMJuY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:50:24 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39061 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934268AbeBMJq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:46:56 -0500
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org, horms@verge.net.au, magnus.damm@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] Documentation: devicetree: renesas,sci: Add r8a77965
Date: Tue, 13 Feb 2018 10:45:55 +0100
Message-Id: <1518515162-23663-9-git-send-email-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for r8a77965 compatible string to reneass sci-serial
device tree bindings documentation.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index cf504d0..cbb418a 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -40,7 +40,9 @@ Required properties:
     - "renesas,scif-r8a7795" for R8A7795 (R-Car H3) SCIF compatible UART.
     - "renesas,hscif-r8a7795" for R8A7795 (R-Car H3) HSCIF compatible UART.
     - "renesas,scif-r8a7796" for R8A7796 (R-Car M3-W) SCIF compatible UART.
+    - "renesas,scif-r8a77965" for R8A77965 (R-Car M3-N) SCIF compatible UART.
     - "renesas,hscif-r8a7796" for R8A7796 (R-Car M3-W) HSCIF compatible UART.
+    - "renesas,hscif-r8a77965" for R8A77965 (R-Car M3-N) HSCIF compatible UART.
     - "renesas,scif-r8a77970" for R8A77970 (R-Car V3M) SCIF compatible UART.
     - "renesas,hscif-r8a77970" for R8A77970 (R-Car V3M) HSCIF compatible UART.
     - "renesas,scif-r8a77995" for R8A77995 (R-Car D3) SCIF compatible UART.
-- 
2.7.4
