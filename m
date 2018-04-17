Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeDQLJn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:09:43 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:21485 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752004AbeDQLJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:09:40 -0400
X-IronPort-AV: E=Sophos;i="5.48,463,1517842800";
   d="scan'208";a="278455825"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 2/6] dt-bindings: reset: renesas,rzn1-reboot: document RZ/N1 reboot driver
Date: Tue, 17 Apr 2018 12:04:17 +0100
Message-Id: <1523963101-56725-3-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523963101-56725-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1523963101-56725-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Renesas RZ/N1 Family (Part #R9A06G0xx) requires a driver
as part of the sysctrl MFD to handle rebooting the CA7 cores.
This documents the driver bindings.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 .../devicetree/bindings/power/renesas,rzn1-reboot.txt   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt

diff --git a/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
new file mode 100644
index 0000000..a553864
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/renesas,rzn1-reboot.txt
@@ -0,0 +1,17 @@
+DT bindings for the Renesas RZ/N1 Reboot Driver
+
+== Reboot Driver Node ==
+
+The reboot driver allows restarting the RZ/N1.
+
+Bindings:
++ Required:
+	compatible = "renesas,r9a06g032-reboot", "renesas,rzn1-reboot";
+
+Example:
+	reboot@4000c120 {
+		compatible = "renesas,r9a06g032-reboot",
+				"renesas,rzn1-reboot";
+		reg = <0x4000c120 4>,
+			<0x4000c198 4>;
+	};
-- 
2.7.4
