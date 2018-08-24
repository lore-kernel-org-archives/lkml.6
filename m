Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BC4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C896D2157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C896D2157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeHXLaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:30:11 -0400
Received: from relmlor3.renesas.com ([210.160.252.173]:35152 "EHLO
        relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726969AbeHXLaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:30:10 -0400
Received: from unknown (HELO relmlir1.idc.renesas.com) ([10.200.68.151])
  by relmlie2.idc.renesas.com with ESMTP; 24 Aug 2018 16:56:41 +0900
Received: from relmlii1.idc.renesas.com (relmlii1.idc.renesas.com [10.200.68.65])
        by relmlir1.idc.renesas.com (Postfix) with ESMTP id B1D5274AC5;
        Fri, 24 Aug 2018 16:56:41 +0900 (JST)
X-IronPort-AV: E=Sophos;i="5.53,281,1531753200"; 
   d="scan'208";a="288949493"
Received: from unknown (HELO fabrizio-dev.ree.adwin.renesas.com) ([10.226.36.250])
  by relmlii1.idc.renesas.com with ESMTP; 24 Aug 2018 16:56:38 +0900
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] dt-bindings: usb: renesas_usbhs: Add r8a774a1 support
Date:   Fri, 24 Aug 2018 08:56:14 +0100
Message-Id: <1535097375-5561-6-git-send-email-fabrizio.castro@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1535097375-5561-1-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
index 43960fa..087140a 100644
--- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
+++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
@@ -5,6 +5,7 @@ Required properties:
 
 	- "renesas,usbhs-r8a7743" for r8a7743 (RZ/G1M) compatible device
 	- "renesas,usbhs-r8a7745" for r8a7745 (RZ/G1E) compatible device
+	- "renesas,usbhs-r8a774a1" for r8a774a1 (RZ/G2M) compatible device
 	- "renesas,usbhs-r8a7790" for r8a7790 (R-Car H2) compatible device
 	- "renesas,usbhs-r8a7791" for r8a7791 (R-Car M2-W) compatible device
 	- "renesas,usbhs-r8a7792" for r8a7792 (R-Car V2H) compatible device
@@ -16,7 +17,7 @@ Required properties:
 	- "renesas,usbhs-r8a77995" for r8a77995 (R-Car D3) compatible device
 	- "renesas,usbhs-r7s72100" for r7s72100 (RZ/A1) compatible device
 	- "renesas,rcar-gen2-usbhs" for R-Car Gen2 or RZ/G1 compatible devices
-	- "renesas,rcar-gen3-usbhs" for R-Car Gen3 compatible device
+	- "renesas,rcar-gen3-usbhs" for R-Car Gen3 or RZ/G2 compatible devices
 	- "renesas,rza1-usbhs" for RZ/A1 compatible device
 
 	When compatible with the generic version, nodes must list the
-- 
2.7.4

