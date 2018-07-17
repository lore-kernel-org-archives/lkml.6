Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08DCECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6472A20C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6472A20C10
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731748AbeGQOgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:36:54 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:49858 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeGQOgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:36:53 -0400
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="16331393"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 17 Jul 2018 07:04:04 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.76.4) by
 chn-sv-exch07.mchp-main.com (10.10.76.108) with Microsoft SMTP Server id
 14.3.352.0; Tue, 17 Jul 2018 07:04:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2] ARM: dts: at91: fix typos for SSC TD functions
Date:   Tue, 17 Jul 2018 17:03:53 +0300
Message-ID: <1531836233-31536-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo for TD function of pins PIN_PB22 and PIN_PC14

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---

Changes in v2:
- fix typo also for PC14 pin
- change patch subject to reflect new changes

 arch/arm/boot/dts/sama5d2-pinfunc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2-pinfunc.h b/arch/arm/boot/dts/sama5d2-pinfunc.h
index e57191fb83de..1c01a6f843d8 100644
--- a/arch/arm/boot/dts/sama5d2-pinfunc.h
+++ b/arch/arm/boot/dts/sama5d2-pinfunc.h
@@ -375,7 +375,7 @@
 #define PIN_PB22__GPIO			PINMUX_PIN(PIN_PB22, 0, 0)
 #define PIN_PB22__LCDDAT11		PINMUX_PIN(PIN_PB22, 1, 1)
 #define PIN_PB22__A11			PINMUX_PIN(PIN_PB22, 2, 1)
-#define PIN_PB22__TDO			PINMUX_PIN(PIN_PB22, 3, 1)
+#define PIN_PB22__TD0			PINMUX_PIN(PIN_PB22, 3, 1)
 #define PIN_PB22__TIOA2			PINMUX_PIN(PIN_PB22, 4, 2)
 #define PIN_PB22__FLEXCOM3_IO1		PINMUX_PIN(PIN_PB22, 5, 3)
 #define PIN_PB22__GMDC			PINMUX_PIN(PIN_PB22, 6, 3)
@@ -556,7 +556,7 @@
 #define PIN_PC14__LCDDAT6		PINMUX_PIN(PIN_PC14, 1, 2)
 #define PIN_PC14__GRX0			PINMUX_PIN(PIN_PC14, 2, 1)
 #define PIN_PC14__ISC_D5		PINMUX_PIN(PIN_PC14, 3, 1)
-#define PIN_PC14__TDO			PINMUX_PIN(PIN_PC14, 5, 2)
+#define PIN_PC14__TD0			PINMUX_PIN(PIN_PC14, 5, 2)
 #define PIN_PC14__A3			PINMUX_PIN(PIN_PC14, 6, 2)
 #define PIN_PC15			79
 #define PIN_PC15__GPIO			PINMUX_PIN(PIN_PC15, 0, 0)
-- 
2.7.4

