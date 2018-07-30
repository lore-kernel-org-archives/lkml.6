Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D51C13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5549B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5549B20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbeG3Oh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:37:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60044 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729315AbeG3Oh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:37:56 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 756D3207F4; Mon, 30 Jul 2018 15:03:00 +0200 (CEST)
Received: from localhost.localdomain (AAubervilliers-681-1-89-120.w90-88.abo.wanadoo.fr [90.88.30.120])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2DA9620712;
        Mon, 30 Jul 2018 15:03:00 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     netdev@vger.kernel.org, alexandre.belloni@bootlin.com,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH 2/4] dt-bindings: net: phy: mscc: vsc8531: remove compatible from required properties
Date:   Mon, 30 Jul 2018 15:02:34 +0200
Message-Id: <20180730130236.3837-2-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180730130236.3837-1-quentin.schulz@bootlin.com>
References: <20180730130236.3837-1-quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compatible isn't a required property for PHYs so let's remove it from
the binding DT of the VSC8531 PHYs.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
index 0eedabe22cc3..664d9d0543fc 100644
--- a/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
+++ b/Documentation/devicetree/bindings/net/mscc-phy-vsc8531.txt
@@ -1,10 +1,5 @@
 * Microsemi - vsc8531 Giga bit ethernet phy
 
-Required properties:
-- compatible	: Should contain phy id as "ethernet-phy-idAAAA.BBBB"
-		  The PHY device uses the binding described in
-		  Documentation/devicetree/bindings/net/phy.txt
-
 Optional properties:
 - vsc8531,vddmac	: The vddmac in mV. Allowed values is listed
 			  in the first row of Table 1 (below).
-- 
2.17.1

