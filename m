Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2212AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08A4217FF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08A4217FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeHVBZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:25:02 -0400
Received: from sauhun.de ([88.99.104.3]:45362 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbeHVBYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:24:55 -0400
Received: from localhost (p54B3375F.dip0.t-ipconnect.de [84.179.55.95])
        by pokefinder.org (Postfix) with ESMTPSA id C295B2DA3F4;
        Wed, 22 Aug 2018 00:02:56 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] watchdog: use SPDX identifier for Renesas drivers
Date:   Wed, 22 Aug 2018 00:02:24 +0200
Message-Id: <20180821220233.9202-12-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

To be applied individually per subsystem tree. Morimoto-san, could you maybe
ack this with your Renesas address?

 drivers/watchdog/renesas_wdt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 88d81feba4e6..84bb9d328180 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Watchdog driver for Renesas WDT watchdog
  *
  * Copyright (C) 2015-17 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
  * Copyright (C) 2015-17 Renesas Electronics Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 #include <linux/bitops.h>
 #include <linux/clk.h>
-- 
2.11.0

