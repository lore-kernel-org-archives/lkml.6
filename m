Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F35C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689472087A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689472087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbeHNPUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:20:35 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:17586 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729560AbeHNPUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:20:34 -0400
Received: from unknown (HELO relmlir2.idc.renesas.com) ([10.200.68.152])
  by relmlie3.idc.renesas.com with ESMTP; 14 Aug 2018 21:33:35 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir2.idc.renesas.com (Postfix) with ESMTP id 2B8E468D81;
        Tue, 14 Aug 2018 21:33:35 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,238,1531753200"; 
   d="scan'208";a="289646677"
Received: from unknown (HELO fabrizio-dev.ree.adwin.renesas.com) ([10.226.36.250])
  by relmlii2.idc.renesas.com with ESMTP; 14 Aug 2018 21:33:31 +0900
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: irqchip: renesas-irqc: Document r8a774a1 support
Date:   Tue, 14 Aug 2018 13:33:28 +0100
Message-Id: <1534250008-15680-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
index 697ca2f2..a046ed3 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
@@ -13,6 +13,7 @@ Required properties:
     - "renesas,irqc-r8a7792" (R-Car V2H)
     - "renesas,irqc-r8a7793" (R-Car M2-N)
     - "renesas,irqc-r8a7794" (R-Car E2)
+    - "renesas,intc-ex-r8a774a1" (RZ/G2M)
     - "renesas,intc-ex-r8a7795" (R-Car H3)
     - "renesas,intc-ex-r8a7796" (R-Car M3-W)
     - "renesas,intc-ex-r8a77965" (R-Car M3-N)
-- 
2.7.4

