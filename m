Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8683CC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FF8F2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=upb.ro header.i=@upb.ro header.b="OEotLCjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF8F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=upb.ro
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbeIDPpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:45:00 -0400
Received: from mail-sender220.upb.ro ([141.85.13.220]:56680 "EHLO mx.upb.ro"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727024AbeIDPpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:45:00 -0400
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2018 11:44:58 EDT
Received: from mx.upb.ro (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTPS id CE26DB560055;
        Tue,  4 Sep 2018 14:13:20 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTP id A2887B560060;
        Tue,  4 Sep 2018 14:13:20 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.upb.ro A2887B560060
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=upb.ro;
        s=96342B8A-77E4-11E5-BA93-D93D0963A2DF; t=1536059600;
        bh=GizGxiIYDY1aiH2NIckjJ2QnXBxpCUyGdy4bR3YGWFQ=;
        h=From:To:Date:Message-Id;
        b=OEotLCjRxFLEr1ceWvNq1Tz6eVyyneVNC0ME5eG9ScsmFLnsToTdYh6i+QNs0rHPa
         lrSbcGGpQTcr6Kgx398GkSlpb+HhBrnGmAr6HUuVTki1cjE43B568oFIZSlt3a2Aad
         GCz8vf/uc7Dva64gVgJwnvviCtDgTZDjU+QvHx7I=
Received: from mx.upb.ro ([127.0.0.1])
        by localhost (mx.upb.ro [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ax-OS_qEvFl1; Tue,  4 Sep 2018 14:13:20 +0300 (EEST)
Received: from asus-rog.localdomain (arh.pub.ro [141.85.160.17])
        by mx.upb.ro (Postfix) with ESMTPSA id 7AFC7B560055;
        Tue,  4 Sep 2018 14:13:20 +0300 (EEST)
From:   Radu Pirea <radu_nicolae.pirea@upb.ro>
To:     lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        gregkh@linuxfoundation.org, broonie@kernel.org, jslaby@suse.com,
        richard.genoud@gmail.com, davem@davemloft.net,
        mchehab+samsung@kernel.org, akpm@linux-foundation.org,
        arnd@arndb.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v12 1/6] MAINTAINERS: add at91 usart mfd driver
Date:   Tue,  4 Sep 2018 14:13:05 +0300
Message-Id: <20180904111310.4049-2-radu_nicolae.pirea@upb.ro>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
References: <20180904111310.4049-1-radu_nicolae.pirea@upb.ro>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radu Pirea <radu.pirea@microchip.com>

Added entry for at91 usart mfd driver.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 544cac829cf4..8aeaa2cc3e14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9322,6 +9322,7 @@ M:	Richard Genoud <richard.genoud@gmail.com>
 S:	Maintained
 F:	drivers/tty/serial/atmel_serial.c
 F:	drivers/tty/serial/atmel_serial.h
+F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
 
 MICROCHIP / ATMEL DMA DRIVER
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
@@ -9354,6 +9355,14 @@ S:	Supported
 F:	drivers/mtd/nand/raw/atmel/*
 F:	Documentation/devicetree/bindings/mtd/atmel-nand.txt
 
+MICROCHIP AT91 USART MFD DRIVER
+M:	Radu Pirea <radu_nicolae.pirea@upb.ro>
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

