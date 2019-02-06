Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EFAC282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93804218E0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfBFR42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:56:28 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:39941 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730908AbfBFR40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:56:26 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="26382903"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Feb 2019 10:56:23 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Wed, 6 Feb 2019 10:56:23 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v2 2/3] net/macb: bindings doc: add sam9x60 binding
Date:   Wed, 6 Feb 2019 18:56:09 +0100
Message-ID: <20190206175610.26773-2-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206175610.26773-1-nicolas.ferre@microchip.com>
References: <20190206175610.26773-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the compatibility sting documentation for sam9x60 10/100 interface.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Hi Rob,

Your tag is missing for this patch.

 Documentation/devicetree/bindings/net/macb.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
index f5c414b10e27..174f292d8a3e 100644
--- a/Documentation/devicetree/bindings/net/macb.txt
+++ b/Documentation/devicetree/bindings/net/macb.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible: Should be "cdns,[<chip>-]{macb|gem}"
   Use "cdns,at91rm9200-emac" Atmel at91rm9200 SoC.
   Use "cdns,at91sam9260-macb" for Atmel at91sam9 SoCs.
+  Use "cdns,sam9x60-macb" for Microchip sam9x60 SoC.
   Use "cdns,np4-macb" for NP4 SoC devices.
   Use "cdns,at32ap7000-macb" for other 10/100 usage or use the generic form: "cdns,macb".
   Use "cdns,pc302-gem" for Picochip picoXcell pc302 and later devices based on
-- 
2.17.1

