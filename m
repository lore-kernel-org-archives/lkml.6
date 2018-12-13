Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD81C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14AF2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14AF2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbeLMUZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:25:56 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:49278 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726533AbeLMUZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:25:56 -0500
X-IronPort-AV: E=Sophos;i="5.56,349,1539615600"; 
   d="scan'208";a="2555658"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Dec 2018 05:20:51 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.37.69])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 13F6540F76C2;
        Fri, 14 Dec 2018 05:20:47 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH] dt-bindings: display: renesas: du: Document r8a774c0 bindings
Date:   Thu, 13 Dec 2018 20:20:45 +0000
Message-Id: <1544732445-6588-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the RZ/G2E (a.k.a. r8a774c0) SoC in the R-Car DU bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/display/renesas,du.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/renesas,du.txt b/Documentation/devicetree/bindings/display/renesas,du.txt
index 3c855d9..aedb22b 100644
--- a/Documentation/devicetree/bindings/display/renesas,du.txt
+++ b/Documentation/devicetree/bindings/display/renesas,du.txt
@@ -7,6 +7,7 @@ Required Properties:
     - "renesas,du-r8a7744" for R8A7744 (RZ/G1N) compatible DU
     - "renesas,du-r8a7745" for R8A7745 (RZ/G1E) compatible DU
     - "renesas,du-r8a77470" for R8A77470 (RZ/G1C) compatible DU
+    - "renesas,du-r8a774c0" for R8A774C0 (RZ/G2E) compatible DU
     - "renesas,du-r8a7779" for R8A7779 (R-Car H1) compatible DU
     - "renesas,du-r8a7790" for R8A7790 (R-Car H2) compatible DU
     - "renesas,du-r8a7791" for R8A7791 (R-Car M2-W) compatible DU
@@ -57,6 +58,7 @@ corresponding to each DU output.
  R8A7744 (RZ/G1N)       DPAD 0         LVDS 0         -              -
  R8A7745 (RZ/G1E)       DPAD 0         DPAD 1         -              -
  R8A77470 (RZ/G1C)      DPAD 0         DPAD 1         LVDS 0         -
+ R8A774C0 (RZ/G2E)      DPAD 0         LVDS 0         LVDS 1         -
  R8A7779 (R-Car H1)     DPAD 0         DPAD 1         -              -
  R8A7790 (R-Car H2)     DPAD 0         LVDS 0         LVDS 1         -
  R8A7791 (R-Car M2-W)   DPAD 0         LVDS 0         -              -
-- 
2.7.4

