Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7377C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F7A2175E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 16:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4qVMJYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F7A2175E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390189AbeHGSge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 14:36:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:33990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730869AbeHGSge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 14:36:34 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C80F82174B;
        Tue,  7 Aug 2018 16:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533658890;
        bh=NIdj51QGKvSnDQYKIRtKCzhhA81r9A62Cf+K2+Fs3/w=;
        h=From:To:Subject:Date:From;
        b=S4qVMJYGbZP+DrbiTgvaqvDvUJZUyoig6uRWJ0eBhYB/Iy6ETGnyG3kQvtB60XCTg
         Hk9JhxW2LFQj1R9uck/NZlWTUsA7SHuZHrS5NAQEAZUSe1bFT9ZwathNEDsRG4S9FS
         pgLOuNOHSAZ1t4P1usXX1xIlH2qg+kw/5v379oFM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] power: supply: maxim: Add SPDX license identifiers
Date:   Tue,  7 Aug 2018 18:21:06 +0200
Message-Id: <20180807162106.18282-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace GPL v2.0 and v2.0+ license statements with SPDX license
identifiers.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/max14577_charger.c | 22 ++++++----------------
 drivers/power/supply/max17040_battery.c | 18 +++++++-----------
 drivers/power/supply/max17042_battery.c | 32 +++++++++-----------------------
 drivers/power/supply/max77693_charger.c | 22 ++++++----------------
 drivers/power/supply/max8997_charger.c  | 26 ++++++--------------------
 drivers/power/supply/max8998_charger.c  | 26 ++++++--------------------
 6 files changed, 40 insertions(+), 106 deletions(-)

diff --git a/drivers/power/supply/max14577_charger.c b/drivers/power/supply/max14577_charger.c
index 449fc56f09eb..8a59feac6468 100644
--- a/drivers/power/supply/max14577_charger.c
+++ b/drivers/power/supply/max14577_charger.c
@@ -1,19 +1,9 @@
-/*
- * max14577_charger.c - Battery charger driver for the Maxim 14577/77836
- *
- * Copyright (C) 2013,2014 Samsung Electronics
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
+// max14577_charger.c - Battery charger driver for the Maxim 14577/77836
+//
+// Copyright (C) 2013,2014 Samsung Electronics
+// Krzysztof Kozlowski <krzk@kernel.org>
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 33c40f79d23d..91cafc7bed30 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -1,14 +1,10 @@
-/*
- *  max17040_battery.c
- *  fuel-gauge systems for lithium-ion (Li+) batteries
- *
- *  Copyright (C) 2009 Samsung Electronics
- *  Minkyu Kang <mk7.kang@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+//  max17040_battery.c
+//  fuel-gauge systems for lithium-ion (Li+) batteries
+//
+//  Copyright (C) 2009 Samsung Electronics
+//  Minkyu Kang <mk7.kang@samsung.com>
 
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 1a568df383db..2a8d75e5e930 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1,26 +1,12 @@
-/*
- * Fuel gauge driver for Maxim 17042 / 8966 / 8997
- *  Note that Maxim 8966 and 8997 are mfd and this is its subdevice.
- *
- * Copyright (C) 2011 Samsung Electronics
- * MyungJoo Ham <myungjoo.ham@samsung.com>
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
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- * This driver is based on max17040_battery.c
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Fuel gauge driver for Maxim 17042 / 8966 / 8997
+//  Note that Maxim 8966 and 8997 are mfd and this is its subdevice.
+//
+// Copyright (C) 2011 Samsung Electronics
+// MyungJoo Ham <myungjoo.ham@samsung.com>
+//
+// This driver is based on max17040_battery.c
 
 #include <linux/acpi.h>
 #include <linux/init.h>
diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 6c78884bad5e..b4cc5b807d53 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -1,19 +1,9 @@
-/*
- * max77693_charger.c - Battery charger driver for the Maxim 77693
- *
- * Copyright (C) 2014 Samsung Electronics
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
+// max77693_charger.c - Battery charger driver for the Maxim 77693
+//
+// Copyright (C) 2014 Samsung Electronics
+// Krzysztof Kozlowski <krzk@kernel.org>
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/drivers/power/supply/max8997_charger.c b/drivers/power/supply/max8997_charger.c
index c73fb4221695..f5e84cd47924 100644
--- a/drivers/power/supply/max8997_charger.c
+++ b/drivers/power/supply/max8997_charger.c
@@ -1,23 +1,9 @@
-/*
- * max8997_charger.c - Power supply consumer driver for the Maxim 8997/8966
- *
- *  Copyright (C) 2011 Samsung Electronics
- *  MyungJoo Ham <myungjoo.ham@samsung.com>
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
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// max8997_charger.c - Power supply consumer driver for the Maxim 8997/8966
+//
+//  Copyright (C) 2011 Samsung Electronics
+//  MyungJoo Ham <myungjoo.ham@samsung.com>
 
 #include <linux/err.h>
 #include <linux/module.h>
diff --git a/drivers/power/supply/max8998_charger.c b/drivers/power/supply/max8998_charger.c
index cad7d1a8feec..95292381c3de 100644
--- a/drivers/power/supply/max8998_charger.c
+++ b/drivers/power/supply/max8998_charger.c
@@ -1,23 +1,9 @@
-/*
- * max8998_charger.c - Power supply consumer driver for the Maxim 8998/LP3974
- *
- *  Copyright (C) 2009-2010 Samsung Electronics
- *  MyungJoo Ham <myungjoo.ham@samsung.com>
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
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
+// SPDX-License-Identifier: GPL-2.0+
+//
+// max8998_charger.c - Power supply consumer driver for the Maxim 8998/LP3974
+//
+//  Copyright (C) 2009-2010 Samsung Electronics
+//  MyungJoo Ham <myungjoo.ham@samsung.com>
 
 #include <linux/err.h>
 #include <linux/module.h>
-- 
2.14.1

