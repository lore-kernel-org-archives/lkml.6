Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6B1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACC820867
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACC820867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbeH2S3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:29:46 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:6476 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeH2S3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:29:46 -0400
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="18915878"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Aug 2018 07:32:17 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Wed, 29 Aug 2018 07:32:17 -0700
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <miquel.raynal@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Cristian Birsan <cristian.birsan@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Boris BREZILLON <boris.brezillon@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 11/11] MAINTAINERS: sdhci: move the Microchip entry to proper location
Date:   Wed, 29 Aug 2018 16:31:47 +0200
Message-ID: <a0db2ae9552536582cf154bc8b4cdf2a023d2700.1535552609.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <cover.1535552609.git.nicolas.ferre@microchip.com>
References: <cover.1535552609.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All SDHCI controller drivers are gathered at the same place, add the
Microchip one there.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 78044223d90f..df2f61548308 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2483,12 +2483,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/input/atmel,maxtouch.txt
 F:	drivers/input/touchscreen/atmel_mxt_ts.c
 
-ATMEL SDMMC DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
-L:	linux-mmc@vger.kernel.org
-S:	Supported
-F:	drivers/mmc/host/sdhci-of-at91.c
-
 ATMEL WIRELESS DRIVER
 M:	Simon Kelley <simon@thekelleys.org.uk>
 L:	linux-wireless@vger.kernel.org
@@ -13006,6 +13000,12 @@ L:	linux-mmc@vger.kernel.org
 S:	Maintained
 F:	drivers/mmc/host/sdhci-pci-dwc-mshc.c
 
+SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER
+M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+L:	linux-mmc@vger.kernel.org
+S:	Supported
+F:	drivers/mmc/host/sdhci-of-at91.c
+
 SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER
 M:	Ben Dooks <ben-linux@fluff.org>
 M:	Jaehoon Chung <jh80.chung@samsung.com>
-- 
2.17.1

