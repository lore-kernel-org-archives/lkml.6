Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249BDC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A1921536
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A1921536
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbeHQR5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 13:57:06 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:51366 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726437AbeHQR5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 13:57:05 -0400
Received: from unknown (HELO relmlir3.idc.renesas.com) ([10.200.68.153])
  by relmlie2.idc.renesas.com with ESMTP; 17 Aug 2018 23:53:24 +0900
Received: from relmlii2.idc.renesas.com (relmlii2.idc.renesas.com [10.200.68.66])
        by relmlir3.idc.renesas.com (Postfix) with ESMTP id A80DE7C21E;
        Fri, 17 Aug 2018 23:53:24 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,251,1531753200"; 
   d="scan'208";a="289879890"
Received: from unknown (HELO fabrizio-dev.ree.adwin.renesas.com) ([10.226.36.250])
  by relmlii2.idc.renesas.com with ESMTP; 17 Aug 2018 23:53:21 +0900
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: thermal: rcar-gen3-thermal: Add r8a774a1 support
Date:   Fri, 17 Aug 2018 15:53:04 +0100
Message-Id: <1534517584-14434-3-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534517584-14434-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1534517584-14434-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
This patch applies on top of next-20180817

 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
index cfa154b..098bf95 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
@@ -7,6 +7,7 @@ inside the LSI.
 Required properties:
 - compatible		: "renesas,<soctype>-thermal",
 			  Examples with soctypes are:
+			    - "renesas,r8a774a1-thermal" (RZ/G2M)
 			    - "renesas,r8a7795-thermal" (R-Car H3)
 			    - "renesas,r8a7796-thermal" (R-Car M3-W)
 			    - "renesas,r8a77965-thermal" (R-Car M3-N)
-- 
2.7.4

