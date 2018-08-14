Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0A2C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD94215E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD94215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbeHNPTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:19:33 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:20749 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732450AbeHNPTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:19:33 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie3.idc.renesas.com with ESMTP; 14 Aug 2018 21:32:33 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id 201E783547;
        Tue, 14 Aug 2018 21:32:33 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,238,1531753200"; 
   d="scan'208";a="288116118"
Received: from unknown (HELO fabrizio-dev.ree.adwin.renesas.com) ([10.226.36.250])
  by relmlii1.idc.renesas.com with ESMTP; 14 Aug 2018 21:32:30 +0900
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dmaengine: rcar-dmac: Document R8A774A1 bindings
Date:   Tue, 14 Aug 2018 13:32:15 +0100
Message-Id: <1534249935-15496-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renesas' RZ/G2M (R8A774A1) SoC has DMA controllers compatible
with this driver, therefore document RZ/G2M specific bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
index 946229c..2de2eed 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
@@ -1,6 +1,6 @@
 * Renesas R-Car (RZ/G) DMA Controller Device Tree bindings
 
-Renesas R-Car Generation 2 SoCs have multiple multi-channel DMA
+Renesas R-Car (Gen 2/3) and RZ/G SoCs have multiple multi-channel DMA
 controller instances named DMAC capable of serving multiple clients. Channels
 can be dedicated to specific clients or shared between a large number of
 clients.
@@ -19,6 +19,7 @@ Required Properties:
 		- "renesas,dmac-r8a7743" (RZ/G1M)
 		- "renesas,dmac-r8a7745" (RZ/G1E)
 		- "renesas,dmac-r8a77470" (RZ/G1C)
+		- "renesas,dmac-r8a774a1" (RZ/G2M)
 		- "renesas,dmac-r8a7790" (R-Car H2)
 		- "renesas,dmac-r8a7791" (R-Car M2-W)
 		- "renesas,dmac-r8a7792" (R-Car V2H)
-- 
2.7.4

