Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeC2Hvy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 03:51:54 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:16928 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751398AbeC2Hvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 03:51:52 -0400
X-IronPort-AV: E=Sophos;i="5.48,375,1517842800";
   d="scan'208";a="276602239"
From: Michel Pollet <michel.pollet@bp.renesas.com>
To: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>
Cc: phil.edworthy@renesas.com, Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 3/8] DT: arm: renesas,rzn1: add the RZ/N1 SoC and RZN1D-DB board
Date: Thu, 29 Mar 2018 08:46:59 +0100
Message-Id: <1522309629-10152-4-git-send-email-michel.pollet@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1522309629-10152-1-git-send-email-michel.pollet@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This documents the RZ/N1 bindings for both the RZ/N1 and the RZN1D-DB
board.

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 Documentation/devicetree/bindings/arm/shmobile.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index d3d1df9..52368fc 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -47,7 +47,10 @@ SoCs:
     compatible = "renesas,r8a77980"
   - R-Car D3 (R8A77995)
     compatible = "renesas,r8a77995"
-
+  - RZ/N1 Family (R9A06G032 & R9A06G033)
+    compatible = "renesas,rzn1"
+  - RZ/N1D (R9A06G032)
+    compatible = "renesas,r9a06g032", "renesas,rzn1"
 
 Boards:
 
@@ -104,6 +107,8 @@ Boards:
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
