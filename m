Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ObhmJInvGFs/BwAAmS7hNA
	; Thu, 07 Jun 2018 08:41:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9C83A607DC; Thu,  7 Jun 2018 08:41:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 246CE602FC;
	Thu,  7 Jun 2018 08:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 246CE602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753572AbeFGIld (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:41:33 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36210 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753292AbeFGIl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:41:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CD7AB2073D; Thu,  7 Jun 2018 10:41:25 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 046E8207B0;
        Thu,  7 Jun 2018 10:41:12 +0200 (CEST)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/4] dt-bindings: clk: at91: Document all the PMC compatibles
Date: Thu,  7 Jun 2018 10:41:05 +0200
Message-Id: <20180607084107.4461-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
References: <20180607084107.4461-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing PMC compatibles to the list of available compatibles.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 Documentation/devicetree/bindings/clock/at91-clock.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt b/Documentation/devicetree/bindings/clock/at91-clock.txt
index 51c259a92d02..a1f591969538 100644
--- a/Documentation/devicetree/bindings/clock/at91-clock.txt
+++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
@@ -17,14 +17,13 @@ Required properties:
 	"atmel,at91sam9x5-clk-slow-rc-osc":
 		at91 internal slow RC oscillator
 
-	"atmel,at91rm9200-pmc" or
-	"atmel,at91sam9g45-pmc" or
-	"atmel,at91sam9n12-pmc" or
-	"atmel,at91sam9x5-pmc" or
-	"atmel,sama5d3-pmc":
+	"atmel,<chip>-pmc":
 		at91 PMC (Power Management Controller)
 		All at91 specific clocks (clocks defined below) must be child
 		node of the PMC node.
+		<chip> can be: at91rm9200, at91sam9260, at91sam9261,
+		at91sam9263, at91sam9g45, at91sam9n12, at91sam9rl, at91sam9x5,
+		sama5d2, sama5d3 or sama5d4.
 
 	"atmel,at91sam9x5-clk-slow" (under sckc node)
 	or
-- 
2.17.1
