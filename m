Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC27C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB486208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 10:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB486208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935417AbeFRKHz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 06:07:55 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:44760 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934967AbeFRKHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 06:07:53 -0400
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="scan'208";a="15346670"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Jun 2018 03:07:52 -0700
Received: from m19893.microchip.com (10.10.76.4) by
 chn-sv-exch05.mchp-main.com (10.10.76.106) with Microsoft SMTP Server id
 14.3.352.0; Mon, 18 Jun 2018 03:07:51 -0700
From:   Radu Pirea <radu.pirea@microchip.com>
To:     <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <lee.jones@linaro.org>,
        <richard.genoud@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-serial@vger.kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v8 4/6] MAINTAINERS: add at91 usart spi driver
Date:   Mon, 18 Jun 2018 13:08:27 +0300
Message-ID: <20180618100829.13875-5-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618100829.13875-1-radu.pirea@microchip.com>
References: <20180618100829.13875-1-radu.pirea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added entry for at91 usart mfd driver.

Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 12203d07c6af..dae31df711fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9201,6 +9201,13 @@ F:	drivers/mfd/at91-usart.c
 F:	include/dt-bindings/mfd/at91-usart.h
 F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
 
+MICROCHIP AT91 USART SPI DRIVER
+M:	Radu Pirea <radu.pirea@microchip.com>
+L:	linux-spi@vger.kernel.org
+S:	Supported
+F:	drivers/spi/spi-at91-usart.c
+F:	Documentation/devicetree/bindings/mfd/atmel-usart.txt
+
 MICROCHIP KSZ SERIES ETHERNET SWITCH DRIVER
 M:	Woojung Huh <Woojung.Huh@microchip.com>
 M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
-- 
2.17.1

