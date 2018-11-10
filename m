Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C2DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A090720854
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A090720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeKKBka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 20:40:30 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:59367 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeKKBka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 20:40:30 -0500
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MMXcP-1g2STU3gRj-00JWa5; Sat, 10 Nov 2018 16:54:43 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>, Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Simon Arlott <simon@arlott.org>
Subject: [PATCH 09/17] irqchip: bcm283x: Switch to SPDX identifier
Date:   Sat, 10 Nov 2018 16:54:23 +0100
Message-Id: <1541865263-7571-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:j2zVgGWPeNsrV3MW07zCmv8+RnUWeNIPIF2FLbhL48r6WpWY++/
 MX5+SsvUNOXlLY+4VoJj1fsMusFCveIs63c6jOgh75KQaVxjlJgUTNGH5Iu02Yy/ST6TThY
 rYz/ckmrbhGTVMiMXKpPTHu9f2BjQd/5xEFbDCkr/XmsKLGAS0dmptFNLd3sRK1nGv6P6Xa
 g2ADk2itA8YvlDzkkIXFA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AdJNtho/TfM=:YGHMsxQ556jecZvKrSuh87
 TYsCVXjzFAZQQxvOqbW/xOw1aKKB1kcWkkR2rrdfAJmo+a2oqKgMN8oa+PfFrf1ie6JZnKava
 LsEZwdasT+vbgUlmZPI+6+LnOMi6MIJXsudKSqf/pmwVtG9I34Kh6vGkuHsgzf++YAll3/jyZ
 VXa2KmnGgapdASiNcCuep8bUtKBna70l99l0Ns6j1BF9bl5VuGBLxlhJMRYhnRfdjRs78n/xI
 wvXuqotFggKVEp3QwdQIIVzhThp9bOwGOYKU27GPQPRU5ysgSdwQ7pcj8HjUmEqKcTXESI6vu
 wOBbFV3oXfXMI6PIt0BhJvB7iQQSqgSpnzPKDeZc//kw5fIp29hzRVPdi86ZWSU2Fpw7j8Oj3
 c1n25Vuys2E06pDE/z1Ra2DireB7c0PuSUF4KSwHO/aCpkjOK9zba8sz82PUV541o0gnswes6
 1Tco02Yd3Yef7B7rkvJrB4xLArZYMCv3YPK615zrTimGIz+QQYX0gNsCDtEn0AVBDlJxaRPOS
 MmSJrEYi+3Y8hNfi1ZYtj3huAhVfoUeJJrkok+T2aGXWBshgXpruz4yVx2iSlbp5prD4KVNDn
 kmFbtt6sPCSpgk78wL0NVn10d+jE9wZz4AoKRK98PYgs2JQzsPoXrGpQaw/Ax2uwKp//J0wFS
 QwExwIdxbES6kAbl4DDeqj+B8O0UG4ioFFjV+uSRiW581DeG607QXKhY6PtM30xUsUG73XdL/
 U97av/m2032A061uZ9gTX9FLHmLDdHcWQdivI7pNwsNjYFtyvpRa+8xHmBwtZuOBgJ++TpEwQ
 YV7U19954oABv4xKEqaQTnY/835xQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Cc: Simon Arlott <simon@arlott.org>
Cc: Eric Anholt <eric@anholt.net>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/irqchip/irq-bcm2835.c | 11 +----------
 drivers/irqchip/irq-bcm2836.c | 11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c
index d2da8a1..418245d 100644
--- a/drivers/irqchip/irq-bcm2835.c
+++ b/drivers/irqchip/irq-bcm2835.c
@@ -1,17 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright 2010 Broadcom
  * Copyright 2012 Simon Arlott, Chris Boot, Stephen Warren
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  * Quirk 1: Shortcut interrupts don't set the bank 1/2 register pending bits
  *
  * If an interrupt fires on bank 1 that isn't in the shortcuts list, bit 8
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index dfe4a46..2038693 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -1,17 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Root interrupt controller for the BCM2836 (Raspberry Pi 2).
  *
  * Copyright 2015 Broadcom
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/cpu.h>
-- 
2.7.4

