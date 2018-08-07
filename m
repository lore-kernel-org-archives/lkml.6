Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9DBC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BF921987
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="19QBzgtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BF921987
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389550AbeHGScn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:56472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389182AbeHGScn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:32:43 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E06332175E;
        Tue,  7 Aug 2018 16:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533658661;
        bh=udzwmb6/D8iOz/RXREUhibuVldPZPZ+WhrMP7WPxHZw=;
        h=From:To:Subject:Date:From;
        b=19QBzgtqI7zB3vPHAflvfsqb36KE4vQCr+ackIVj5/u/kh/8H66muA/kPeoem4GpN
         KDaRh2wamddgiVJ8yFg/XQb6XOL9jZH1uEdrT0XAXjMjqLb4q0JpEwDYz/ZSPQslqn
         GwbQ0W4KXbwoARgYj9yj4oJ1GYCDR4ljZ2c6Mus0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/3] clk: max77686: Add SPDX license identifiers
Date:   Tue,  7 Aug 2018 18:17:11 +0200
Message-Id: <20180807161713.28073-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace GPL v2.0 and v2.0+ license statements with SPDX license
identifiers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/clk-max77686.c                 | 27 ++++++---------------------
 include/dt-bindings/clock/maxim,max77686.h |  5 +----
 include/dt-bindings/clock/maxim,max77802.h |  5 +----
 3 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index eb953d3b0b69..02551fe4b87c 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -1,24 +1,9 @@
-/*
- * clk-max77686.c - Clock driver for Maxim 77686/MAX77802
- *
- * Copyright (C) 2012 Samsung Electornics
- * Jonghwa Lee <jonghwa3.lee@samsung.com>
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// clk-max77686.c - Clock driver for Maxim 77686/MAX77802
+//
+// Copyright (C) 2012 Samsung Electornics
+// Jonghwa Lee <jonghwa3.lee@samsung.com>
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/include/dt-bindings/clock/maxim,max77686.h b/include/dt-bindings/clock/maxim,max77686.h
index 7b28b0905869..af8261dcace1 100644
--- a/include/dt-bindings/clock/maxim,max77686.h
+++ b/include/dt-bindings/clock/maxim,max77686.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2014 Google, Inc
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants clocks for the Maxim 77686 PMIC.
  */
 
diff --git a/include/dt-bindings/clock/maxim,max77802.h b/include/dt-bindings/clock/maxim,max77802.h
index 997312edcbb5..51adcbaed697 100644
--- a/include/dt-bindings/clock/maxim,max77802.h
+++ b/include/dt-bindings/clock/maxim,max77802.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2014 Google, Inc
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Device Tree binding constants clocks for the Maxim 77802 PMIC.
  */
 
-- 
2.14.1

