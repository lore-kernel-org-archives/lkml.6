Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619DBC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3273F20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 20:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3273F20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbeLMUXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:23:05 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:13226 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726900AbeLMUXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 15:23:04 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Dec 2018 15:23:03 EST
X-IronPort-AV: E=Sophos;i="5.56,349,1539615600"; 
   d="scan'208";a="2555482"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Dec 2018 05:18:00 +0900
Received: from fabrizio-dev.ree.adwin.renesas.com (unknown [10.226.37.69])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 94A0D40F76A0;
        Fri, 14 Dec 2018 05:17:57 +0900 (JST)
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] serial: sh-sci: Document r8a774c0 bindings
Date:   Thu, 13 Dec 2018 20:17:54 +0000
Message-Id: <1544732274-5904-1-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RZ/G2E (R8A774C0) SoC also has the R-Car Gen3 compatible SCIF and
HSCIF ports, so document the SoC specific bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---

This patch depends on:
https://patchwork.kernel.org/patch/10565543/
---
 Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index 21526e8..20232ad 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -26,6 +26,8 @@ Required properties:
     - "renesas,hscif-r8a77470" for R8A77470 (RZ/G1C) HSCIF compatible UART.
     - "renesas,scif-r8a774a1" for R8A774A1 (RZ/G2M) SCIF compatible UART.
     - "renesas,hscif-r8a774a1" for R8A774A1 (RZ/G2M) HSCIF compatible UART.
+    - "renesas,scif-r8a774c0" for R8A774C0 (RZ/G2E) SCIF compatible UART.
+    - "renesas,hscif-r8a774c0" for R8A774C0 (RZ/G2E) HSCIF compatible UART.
     - "renesas,scif-r8a7778" for R8A7778 (R-Car M1) SCIF compatible UART.
     - "renesas,scif-r8a7779" for R8A7779 (R-Car H1) SCIF compatible UART.
     - "renesas,scif-r8a7790" for R8A7790 (R-Car H2) SCIF compatible UART.
-- 
2.7.4

