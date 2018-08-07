Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779FCC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DF521987
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJ24YSyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DF521987
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390168AbeHGSes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388948AbeHGSes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:34:48 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B2832174B;
        Tue,  7 Aug 2018 16:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533658785;
        bh=rvx1UarfMkclw9Z8+ewIS6f747pXS+df6StLRUDuQ7Y=;
        h=From:To:Subject:Date:From;
        b=DJ24YSyVq5jcabfoZg30pTIL0WnG36NgEtGcR84756F/8Scv2L/MzoFILdEcwgIkH
         CSSQAXDdQ+nueb8ZNSOgnGLhr4gugREyvx1j/ibSOtBPIwaaPnABHamTBdLzX1UgcX
         83A83ZtAB7lGlRkdZLcKl7eMTrZHg+EY0cX1vQ44=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sangbeom Kim <sbkim73@samsung.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 1/2] rtc: maxim: Add SPDX license identifiers
Date:   Tue,  7 Aug 2018 18:19:18 +0200
Message-Id: <20180807161919.7827-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace GPL v2.0+ license statements with SPDX license
identifiers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/rtc/rtc-max77686.c | 20 +++++++-------------
 drivers/rtc/rtc-max8997.c  | 20 +++++++-------------
 drivers/rtc/rtc-max8998.c  | 20 +++++++-------------
 3 files changed, 21 insertions(+), 39 deletions(-)

diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index cefde273fae6..8a60900d6b8b 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -1,16 +1,10 @@
-/*
- * RTC driver for Maxim MAX77686 and MAX77802
- *
- * Copyright (C) 2012 Samsung Electronics Co.Ltd
- *
- *  based on rtc-max8997.c
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// RTC driver for Maxim MAX77686 and MAX77802
+//
+// Copyright (C) 2012 Samsung Electronics Co.Ltd
+//
+//  based on rtc-max8997.c
 
 #include <linux/i2c.h>
 #include <linux/slab.h>
diff --git a/drivers/rtc/rtc-max8997.c b/drivers/rtc/rtc-max8997.c
index e8cee123e8aa..08c661a332ec 100644
--- a/drivers/rtc/rtc-max8997.c
+++ b/drivers/rtc/rtc-max8997.c
@@ -1,16 +1,10 @@
-/*
- * RTC driver for Maxim MAX8997
- *
- * Copyright (C) 2013 Samsung Electronics Co.Ltd
- *
- *  based on rtc-max8998.c
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// RTC driver for Maxim MAX8997
+//
+// Copyright (C) 2013 Samsung Electronics Co.Ltd
+//
+//  based on rtc-max8998.c
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
diff --git a/drivers/rtc/rtc-max8998.c b/drivers/rtc/rtc-max8998.c
index d8c0f9b3f87d..c873b4509b3c 100644
--- a/drivers/rtc/rtc-max8998.c
+++ b/drivers/rtc/rtc-max8998.c
@@ -1,16 +1,10 @@
-/*
- * RTC driver for Maxim MAX8998
- *
- * Copyright (C) 2010 Samsung Electronics Co.Ltd
- * Author: Minkyu Kang <mk7.kang@samsung.com>
- * Author: Joonyoung Shim <jy0922.shim@samsung.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// RTC driver for Maxim MAX8998
+//
+// Copyright (C) 2010 Samsung Electronics Co.Ltd
+// Author: Minkyu Kang <mk7.kang@samsung.com>
+// Author: Joonyoung Shim <jy0922.shim@samsung.com>
 
 #include <linux/module.h>
 #include <linux/i2c.h>
-- 
2.14.1

