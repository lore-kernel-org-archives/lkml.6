Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C323C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA852175E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UclXYsPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA852175E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403767AbeHGShD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:37:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730869AbeHGShD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:37:03 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E50212174B;
        Tue,  7 Aug 2018 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533658920;
        bh=rI2hdT68yn9mWVbQjq85sSHzfql9X3ekY3qdQ5kdCgQ=;
        h=From:To:Subject:Date:From;
        b=UclXYsPsTIYtNBVFSIAXtDnNYJD372Ldoa89yVjyWL52lzOFRAw6FPFZ6muIW1R84
         cRFaKoGv/fRgk7VJZdk+xGUCYP+vqkx9b/3OngY3XA1NDDtji+pq/FuxIwRIplakCS
         hGahBCZINT7IZidTFAS8+O5MbaecV6r/eaXVxNDk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] extcon: maxim: Add SPDX license identifiers
Date:   Tue,  7 Aug 2018 18:21:22 +0200
Message-Id: <20180807162122.19614-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace GPL v2.0+ license statements with SPDX license identifiers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/extcon/extcon-max14577.c | 24 +++++++-----------------
 drivers/extcon/extcon-max77693.c | 22 ++++++----------------
 drivers/extcon/extcon-max77843.c | 19 +++++++------------
 drivers/extcon/extcon-max8997.c  | 22 ++++++----------------
 4 files changed, 26 insertions(+), 61 deletions(-)

diff --git a/drivers/extcon/extcon-max14577.c b/drivers/extcon/extcon-max14577.c
index b871836da8a4..22d2feb1f8bc 100644
--- a/drivers/extcon/extcon-max14577.c
+++ b/drivers/extcon/extcon-max14577.c
@@ -1,20 +1,10 @@
-/*
- * extcon-max14577.c - MAX14577/77836 extcon driver to support MUIC
- *
- * Copyright (C) 2013,2014 Samsung Electronics
- * Chanwoo Choi <cw00.choi@samsung.com>
- * Krzysztof Kozlowski <krzk@kernel.org>
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
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// extcon-max14577.c - MAX14577/77836 extcon driver to support MUIC
+//
+// Copyright (C) 2013,2014 Samsung Electronics
+// Chanwoo Choi <cw00.choi@samsung.com>
+// Krzysztof Kozlowski <krzk@kernel.org>
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
index 227651ff9666..a79537ebb671 100644
--- a/drivers/extcon/extcon-max77693.c
+++ b/drivers/extcon/extcon-max77693.c
@@ -1,19 +1,9 @@
-/*
- * extcon-max77693.c - MAX77693 extcon driver to support MAX77693 MUIC
- *
- * Copyright (C) 2012 Samsung Electrnoics
- * Chanwoo Choi <cw00.choi@samsung.com>
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
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// extcon-max77693.c - MAX77693 extcon driver to support MAX77693 MUIC
+//
+// Copyright (C) 2012 Samsung Electrnoics
+// Chanwoo Choi <cw00.choi@samsung.com>
 
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/extcon/extcon-max77843.c b/drivers/extcon/extcon-max77843.c
index c9fcd6cd41cb..b98cbd0362f5 100644
--- a/drivers/extcon/extcon-max77843.c
+++ b/drivers/extcon/extcon-max77843.c
@@ -1,15 +1,10 @@
-/*
- * extcon-max77843.c - Maxim MAX77843 extcon driver to support
- *			MUIC(Micro USB Interface Controller)
- *
- * Copyright (C) 2015 Samsung Electronics
- * Author: Jaewon Kim <jaewon02.kim@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// extcon-max77843.c - Maxim MAX77843 extcon driver to support
+//			MUIC(Micro USB Interface Controller)
+//
+// Copyright (C) 2015 Samsung Electronics
+// Author: Jaewon Kim <jaewon02.kim@samsung.com>
 
 #include <linux/extcon-provider.h>
 #include <linux/i2c.h>
diff --git a/drivers/extcon/extcon-max8997.c b/drivers/extcon/extcon-max8997.c
index 9f30f4929b72..bdabb2479e0d 100644
--- a/drivers/extcon/extcon-max8997.c
+++ b/drivers/extcon/extcon-max8997.c
@@ -1,19 +1,9 @@
-/*
- * extcon-max8997.c - MAX8997 extcon driver to support MAX8997 MUIC
- *
- *  Copyright (C) 2012 Samsung Electronics
- *  Donggeun Kim <dg77.kim@samsung.com>
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
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// extcon-max8997.c - MAX8997 extcon driver to support MAX8997 MUIC
+//
+//  Copyright (C) 2012 Samsung Electronics
+//  Donggeun Kim <dg77.kim@samsung.com>
 
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.14.1

