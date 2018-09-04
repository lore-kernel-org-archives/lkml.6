Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB34C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 433B92075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=upb.ro header.i=@upb.ro header.b="NmH+FLjE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433B92075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=upb.ro
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbeIDPpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:45:03 -0400
Received: from mail.upb.ro ([141.85.13.5]:56730 "EHLO mx.upb.ro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727155AbeIDPpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:45:01 -0400
Received: from mx.upb.ro (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTPS id 38190B560063;
        Tue,  4 Sep 2018 14:13:21 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTP id 0B0B6B56004E;
        Tue,  4 Sep 2018 14:13:21 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.upb.ro 0B0B6B56004E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=upb.ro;
        s=96342B8A-77E4-11E5-BA93-D93D0963A2DF; t=1536059601;
        bh=m2cNARCUorh6KCNClXDwKYpSezqKekzdGlO4BaXoQ0E=;
        h=From:To:Date:Message-Id;
        b=NmH+FLjE/KnsuALlz62r7nEuETUaQ0apm0Z6sRmjDyYoj0mFpUcM+VELmyjAgTwI2
         7yNpaZeSiTC+9NqvlXrQ+iMuoFP5PuNZp5x+QYlJiiyh2+52Dnpt5gQJa0EKX3UGE4
         75mkpyaQnEh1N0Zd/rp8THyNQreDiXBiVtVmC2ZI=
Received: from mx.upb.ro ([127.0.0.1])
        by localhost (mx.upb.ro [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u0Z0p4TTq8px; Tue,  4 Sep 2018 14:13:20 +0300 (EEST)
Received: from asus-rog.localdomain (arh.pub.ro [141.85.160.17])
        by mx.upb.ro (Postfix) with ESMTPSA id D0099B560062;
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
Subject: [PATCH v12 4/6] MAINTAINERS: add at91 usart spi driver
Date:   Tue,  4 Sep 2018 14:13:08 +0300
Message-Id: <20180904111310.4049-5-radu_nicolae.pirea@upb.ro>
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
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8aeaa2cc3e14..1bb477aab33b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9363,6 +9363,13 @@ F:	drivers/mfd/at91-usart.c
 F:	include/dt-bindings/mfd/at91-usart.h
 F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
 
+MICROCHIP AT91 USART SPI DRIVER
+M:	Radu Pirea <radu_nicolae.pirea@upb.ro>
+L:	linux-spi@vger.kernel.org
+S:	Supported
+F:	drivers/spi/spi-at91-usart.c
+F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
+
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
 M:	Woojung Huh <Woojung.Huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
-- 
2.18.0

