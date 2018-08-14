Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAE7C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3409D215E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 12:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3409D215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbeHNPTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 11:19:46 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:8750 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728978AbeHNPTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 11:19:46 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie2.idc.renesas.com with ESMTP; 14 Aug 2018 21:32:45 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id 204A471D19;
        Tue, 14 Aug 2018 21:32:45 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,238,1531753200"; 
   d="scan'208";a="289646637"
Received: from unknown (HELO fabrizio-dev.ree.adwin.renesas.com) ([10.226.36.250])
  by relmlii2.idc.renesas.com with ESMTP; 14 Aug 2018 21:32:41 +0900
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: gpio: rcar: Add r8a774a1 (RZ/G2M) support
Date:   Tue, 14 Aug 2018 13:32:37 +0100
Message-Id: <1534249957-15543-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Renesas' RZ/G2M (R8A774A1) GPIO blocks compatibility within the
relevant dt-bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
index 4018ee5..e82144a 100644
--- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
+++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
@@ -6,6 +6,7 @@ Required Properties:
     - "renesas,gpio-r8a7743": for R8A7743 (RZ/G1M) compatible GPIO controller.
     - "renesas,gpio-r8a7745": for R8A7745 (RZ/G1E) compatible GPIO controller.
     - "renesas,gpio-r8a77470": for R8A77470 (RZ/G1C) compatible GPIO controller.
+    - "renesas,gpio-r8a774a1": for R8A774A1 (RZ/G2M) compatible GPIO controller.
     - "renesas,gpio-r8a7778": for R8A7778 (R-Car M1) compatible GPIO controller.
     - "renesas,gpio-r8a7779": for R8A7779 (R-Car H1) compatible GPIO controller.
     - "renesas,gpio-r8a7790": for R8A7790 (R-Car H2) compatible GPIO controller.
@@ -22,7 +23,7 @@ Required Properties:
     - "renesas,gpio-r8a77995": for R8A77995 (R-Car D3) compatible GPIO controller.
     - "renesas,rcar-gen1-gpio": for a generic R-Car Gen1 GPIO controller.
     - "renesas,rcar-gen2-gpio": for a generic R-Car Gen2 or RZ/G1 GPIO controller.
-    - "renesas,rcar-gen3-gpio": for a generic R-Car Gen3 GPIO controller.
+    - "renesas,rcar-gen3-gpio": for a generic R-Car Gen3 or RZ/G2 GPIO controller.
     - "renesas,gpio-rcar": deprecated.
 
     When compatible with the generic version nodes must list the
-- 
2.7.4

