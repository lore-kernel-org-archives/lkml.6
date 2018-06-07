Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wqaCGATwGFtOCgAAmS7hNA
	; Thu, 07 Jun 2018 08:42:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D978B60928; Thu,  7 Jun 2018 08:42:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DB4E460915;
	Thu,  7 Jun 2018 08:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB4E460915
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932668AbeFGIlb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:41:31 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36207 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753269AbeFGIl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:41:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C9308207CA; Thu,  7 Jun 2018 10:41:25 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id B83002073D;
        Thu,  7 Jun 2018 10:41:11 +0200 (CEST)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/4] dt-bindings: arm: remove PMC bindings
Date: Thu,  7 Jun 2018 10:41:04 +0200
Message-Id: <20180607084107.4461-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
References: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMC bindings are fully described in
Documentation/devicetree/bindings/clock/at91-clock.txt. Remove the
duplicate and incomplete documentation.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../devicetree/bindings/arm/atmel-pmc.txt          | 14 --------------
 1 file changed, 14 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/atmel-pmc.txt

diff --git a/Documentation/devicetree/bindings/arm/atmel-pmc.txt b/Documentation/devicetree/bindings/arm/atmel-pmc.txt
deleted file mode 100644
index 795cc78543fe..000000000000
--- a/Documentation/devicetree/bindings/arm/atmel-pmc.txt
+++ /dev/null
@@ -1,14 +0,0 @@
-* Power Management Controller (PMC)
-
-Required properties:
-- compatible: Should be "atmel,<chip>-pmc".
-	<chip> can be: at91rm9200, at91sam9260, at91sam9g45, at91sam9n12,
-	at91sam9x5, sama5d3
-
-- reg: Should contain PMC registers location and length
-
-Examples:
-	pmc: pmc@fffffc00 {
-		compatible = "atmel,at91rm9200-pmc";
-		reg = <0xfffffc00 0x100>;
-	};
-- 
2.17.1
