Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F826C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5367620850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 14:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5367620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbeH2S3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 14:29:12 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:38397 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbeH2S3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 14:29:11 -0400
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="18999106"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Aug 2018 07:31:58 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Wed, 29 Aug 2018 07:31:58 -0700
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
Subject: [PATCH 03/11] MAINTAINERS: media: change Microchip ISI, ISC maintainers
Date:   Wed, 29 Aug 2018 16:31:39 +0200
Message-ID: <f5c7302265c8d5df4398359f5056faedabfa0fb0.1535552609.git.nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <cover.1535552609.git.nicolas.ferre@microchip.com>
References: <cover.1535552609.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ISC, Songjun is not with Microchip anymore, his address shouldn't be
reachable.
For ISI, Eugen can handle the maintenance now.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 43fa2ebb292e..6eaf54960c1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2494,7 +2494,7 @@ S:	Supported
 F:	drivers/i2c/busses/i2c-at91.c
 
 ATMEL ISI DRIVER
-M:	Ludovic Desroches <ludovic.desroches@microchip.com>
+M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
 F:	drivers/media/platform/atmel/atmel-isi.c
@@ -9520,7 +9520,7 @@ S:	Maintained
 F:	drivers/crypto/atmel-ecc.*
 
 MICROCHIP / ATMEL ISC DRIVER
-M:	Songjun Wu <songjun.wu@microchip.com>
+M:	Eugen Hristev <eugen.hristev@microchip.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
 F:	drivers/media/platform/atmel/atmel-isc.c
-- 
2.17.1

