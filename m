Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4E6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B5A206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 18:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbfAPS52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 13:57:28 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:3901 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbfAPS51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 13:57:27 -0500
Received: from localhost.localdomain (unknown [IPv6:2a02:8108:4840:8f74:a08c:f56:b2dd:7ae0])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPA id 1A742B00565;
        Wed, 16 Jan 2019 19:57:07 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-kernel@vger.kernel.org
Cc:     Alban Bedel <albeu@free.fr>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 6/6] MAINTAINERS: Add an entry for the ath79 SPI driver
Date:   Wed, 16 Jan 2019 19:55:49 +0100
Message-Id: <20190116185549.23295-6-albeu@free.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190116185549.23295-1-albeu@free.fr>
References: <20190116185549.23295-1-albeu@free.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the maintainer for the ath79 SPI driver.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 71e2965fc656..a03ab41489cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2520,6 +2520,15 @@ S:	Maintained
 F:	drivers/gpio/gpio-ath79.c
 F:	Documentation/devicetree/bindings/gpio/gpio-ath79.txt
 
+ATHEROS 71XX/9XXX SPI DRIVER
+M:	Alban Bedel <albeu@free.fr>
+W:	https://github.com/AlbanBedel/linux
+T:	git git://github.com/AlbanBedel/linux
+S:	Maintained
+F:	drivers/spi/spi-ath79.c
+F:	include/linux/platform_data/spi-ath79.h
+F:	Documentation/devicetree/bindings/spi/spi-ath79.txt
+
 ATHEROS 71XX/9XXX USB PHY DRIVER
 M:	Alban Bedel <albeu@free.fr>
 W:	https://github.com/AlbanBedel/linux
-- 
2.19.1

