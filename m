Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeDQLJx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:09:53 -0400
Received: from relmlor2.renesas.com ([210.160.252.172]:64601 "EHLO
        relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752004AbeDQLJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:09:51 -0400
X-IronPort-AV: E=Sophos;i="5.48,463,1517842800";
   d="scan'208";a="278455838"
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
Subject: [PATCH v5 3/6] dt-bindings: arm: Document the RZN1D-DB board
Date: Tue, 17 Apr 2018 12:04:18 +0100
Message-Id: <1523963101-56725-4-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523963101-56725-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1523963101-56725-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents the RZ/N1 bindings for the RZN1D-DB board.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 61b486f..6efb3f1 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -51,7 +51,8 @@ SoCs:
     compatible = "renesas,r8a77990"
   - R-Car D3 (R8A77995)
     compatible = "renesas,r8a77995"
-
+  - RZ/N1D (R9A06G032)
+    compatible = "renesas,r9a06g032", "renesas,rzn1"
 
 Boards:
 
@@ -112,6 +113,8 @@ Boards:
     compatible = "renesas,porter", "renesas,r8a7791"
   - RSKRZA1 (YR0K77210C000BE)
     compatible = "renesas,rskrza1", "renesas,r7s72100"
+  - RZN1D-DB (RZ/N1D Demo Board for the RZ/N1D 400 pins package)
+    compatible = "renesas,rzn1d400-db", "renesas,r9a06g032", "renesas,rzn1"
   - Salvator-X (RTP0RC7795SIPB0010S)
     compatible = "renesas,salvator-x", "renesas,r8a7795"
   - Salvator-X (RTP0RC7796SIPB0011S)
-- 
2.7.4
