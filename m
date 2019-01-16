Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65F2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E98F2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 09:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403991AbfAPJ55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 04:57:57 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:49626 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbfAPJ5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 04:57:54 -0500
X-IronPort-AV: E=Sophos;i="5.56,485,1539673200"; 
   d="scan'208";a="25551578"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 16 Jan 2019 02:57:53 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Wed, 16 Jan 2019 02:57:53 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sebastian Reichel <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>,
        <linux-usb@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 2/8] dt-bindings: arm: atmel: add new sam9x60 reset controller binding
Date:   Wed, 16 Jan 2019 10:57:38 +0100
Message-ID: <ed46005be5beff6efc47d40cea304185efa2bcc0.1547629763.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547629763.git.nicolas.ferre@microchip.com>
References: <cover.1547629763.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the Reset Controller's binding to add new SoC compatibility string.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 Documentation/devicetree/bindings/arm/atmel-sysregs.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
index 36952cc39993..badce6ef3ab3 100644
--- a/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-sysregs.txt
@@ -22,6 +22,7 @@ Its subnodes can be:
 RSTC Reset Controller required properties:
 - compatible: Should be "atmel,<chip>-rstc".
   <chip> can be "at91sam9260", "at91sam9g45", "sama5d3" or "samx7"
+  it also can be "microchip,sam9x60-rstc"
 - reg: Should contain registers location and length
 - clocks: phandle to input clock.
 
-- 
2.17.1

