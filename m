Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE74C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63783218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 10:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbeLSKGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 05:06:37 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:21788 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728880AbeLSKGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 05:06:35 -0500
X-IronPort-AV: E=Sophos;i="5.56,372,1539615600"; 
   d="scan'208";a="3048602"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 Dec 2018 19:06:33 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.37.69])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id E1FF14038F5A;
        Wed, 19 Dec 2018 19:06:30 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: serial: sh-sci: Document r8a774a1 bindings
Date:   Wed, 19 Dec 2018 10:06:24 +0000
Message-Id: <1545213985-30341-2-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545213985-30341-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1545213985-30341-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RZ/G2M (R8A774A1) SoC also has the R-Car Gen3 compatible SCIF and
HSCIF ports, so document the SoC specific bindings. While at it,
update the RZ/G1 and RZ/G2 family specific strings description as
outdated.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

---
v1->v2:
* Prepended "dt-bindings: " to the title

 .../devicetree/bindings/serial/renesas,sci-serial.txt      | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index e52e16c..21526e8 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -24,6 +24,8 @@ Required properties:
     - "renesas,hscif-r8a7745" for R8A7745 (RZ/G1E) HSCIF compatible UART.
     - "renesas,scif-r8a77470" for R8A77470 (RZ/G1C) SCIF compatible UART.
     - "renesas,hscif-r8a77470" for R8A77470 (RZ/G1C) HSCIF compatible UART.
+    - "renesas,scif-r8a774a1" for R8A774A1 (RZ/G2M) SCIF compatible UART.
+    - "renesas,hscif-r8a774a1" for R8A774A1 (RZ/G2M) HSCIF compatible UART.
     - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART.
     - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
     - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
@@ -61,13 +63,13 @@ Required properties:
     - "renesas,scifa-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFA compatible UART.
     - "renesas,scifb-sh73a0" for SH73A0 (SH-Mobile AG5) SCIFB compatible UART.
     - "renesas,rcar-gen1-scif" for R-Car Gen1 SCIF compatible UART,
-    - "renesas,rcar-gen2-scif" for R-Car Gen2 SCIF compatible UART,
-    - "renesas,rcar-gen3-scif" for R-Car Gen3 SCIF compatible UART,
-    - "renesas,rcar-gen2-scifa" for R-Car Gen2 SCIFA compatible UART,
-    - "renesas,rcar-gen2-scifb" for R-Car Gen2 SCIFB compatible UART,
+    - "renesas,rcar-gen2-scif" for R-Car Gen2 and RZ/G1 SCIF compatible UART,
+    - "renesas,rcar-gen3-scif" for R-Car Gen3 and RZ/G2 SCIF compatible UART,
+    - "renesas,rcar-gen2-scifa" for R-Car Gen2 and RZ/G1 SCIFA compatible UART,
+    - "renesas,rcar-gen2-scifb" for R-Car Gen2 and RZ/G1 SCIFB compatible UART,
     - "renesas,rcar-gen1-hscif" for R-Car Gen1 HSCIF compatible UART,
-    - "renesas,rcar-gen2-hscif" for R-Car Gen2 HSCIF compatible UART,
-    - "renesas,rcar-gen3-hscif" for R-Car Gen3 HSCIF compatible UART,
+    - "renesas,rcar-gen2-hscif" for R-Car Gen2 and RZ/G1 HSCIF compatible UART,
+    - "renesas,rcar-gen3-hscif" for R-Car Gen3 and RZ/G2 HSCIF compatible UART,
     - "renesas,scif" for generic SCIF compatible UART.
     - "renesas,scifa" for generic SCIFA compatible UART.
     - "renesas,scifb" for generic SCIFB compatible UART.
-- 
2.7.4

