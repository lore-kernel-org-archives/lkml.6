Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6008BC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D362187A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D362187A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeHQSCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:02:25 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:10409 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726544AbeHQSCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:02:25 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie2.idc.renesas.com with ESMTP; 17 Aug 2018 23:58:42 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 769107C373;
        Fri, 17 Aug 2018 23:58:42 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,251,1531753200"; 
   d="scan'208";a="289880029"
Received: from unknown (HELO fabrizio-dev.ree.adwin.renesas.com) ([10.226.36.250])
  by relmlii2.idc.renesas.com with ESMTP; 17 Aug 2018 23:58:39 +0900
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: sh-msiof: Add r8a774a1 support
Date:   Fri, 17 Aug 2018 15:58:34 +0100
Message-Id: <1534517914-15406-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
This patch applies on top of next-20180817

 Documentation/devicetree/bindings/spi/sh-msiof.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
index bfbc203..8f7bb6a 100644
--- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -3,6 +3,7 @@ Renesas MSIOF spi controller
 Required properties:
 - compatible           : "renesas,msiof-r8a7743" (RZ/G1M)
 			 "renesas,msiof-r8a7745" (RZ/G1E)
+			 "renesas,msiof-r8a774a1" (RZ/G2M)
 			 "renesas,msiof-r8a7790" (R-Car H2)
 			 "renesas,msiof-r8a7791" (R-Car M2-W)
 			 "renesas,msiof-r8a7792" (R-Car V2H)
@@ -14,7 +15,7 @@ Required properties:
 			 "renesas,msiof-sh73a0" (SH-Mobile AG5)
 			 "renesas,sh-mobile-msiof" (generic SH-Mobile compatibile device)
 			 "renesas,rcar-gen2-msiof" (generic R-Car Gen2 and RZ/G1 compatible device)
-			 "renesas,rcar-gen3-msiof" (generic R-Car Gen3 compatible device)
+			 "renesas,rcar-gen3-msiof" (generic R-Car Gen3 and RZ/G2 compatible device)
 			 "renesas,sh-msiof"      (deprecated)
 
 			 When compatible with the generic version, nodes
-- 
2.7.4

