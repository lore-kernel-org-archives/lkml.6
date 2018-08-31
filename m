Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3BFC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61D242083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 13:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61D242083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbeHaRsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 13:48:03 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:36750 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbeHaRsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 13:48:02 -0400
X-IronPort-AV: E=Sophos;i="5.53,311,1531810800"; 
   d="scan'208";a="18767363"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Aug 2018 06:40:29 -0700
Received: from m19893.microchip.com (10.10.76.4) by
 chn-sv-exch02.mchp-main.com (10.10.76.38) with Microsoft SMTP Server id
 14.3.352.0; Fri, 31 Aug 2018 06:40:28 -0700
From:   Radu Pirea <radu.pirea@microchip.com>
To:     <richard.genoud@gmail.com>, <pirea.radu@gmail.com>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <gregkh@linuxfoundation.org>,
        <jslaby@suse.com>, <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>
Subject: [RESEND PATCH v11 1/6] MAINTAINERS: add at91 usart mfd driver
Date:   Fri, 31 Aug 2018 16:41:36 +0300
Message-ID: <20180831134141.9335-2-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831134141.9335-1-radu.pirea@microchip.com>
References: <20180831134141.9335-1-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added entry for at91 usart mfd driver.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..94b37382cd2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9502,6 +9502,7 @@ M:	Richard Genoud <richard.genoud@gmail.com>
 S:	Maintained
 F:	drivers/tty/serial/atmel_serial.c
 F:	drivers/tty/serial/atmel_serial.h
+F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
 
 MICROCHIP / ATMEL DMA DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
@@ -9533,6 +9534,14 @@ S:	Supported
 F:	drivers/mtd/nand/raw/atmel/*
 F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
 
+MICROCHIP AT91 USART MFD DRIVER
+M:	Radu Pirea <pirea.radu@gmail.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/mfd/at91-usart.c
+F:	include/dt-bindings/mfd/at91-usart.h
+F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
+
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
 M:	Woojung Huh <Woojung.Huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
-- 
2.18.0

