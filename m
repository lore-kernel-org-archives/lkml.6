Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F3BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FE621530
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36FE621530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbeIZXGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:06:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:45007 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbeIZXGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:06:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 09:52:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,307,1534834800"; 
   d="scan'208";a="76404448"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga008.jf.intel.com with ESMTP; 26 Sep 2018 09:52:25 -0700
Received: from andy by smile with local (Exim 4.91)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1g5D32-00055O-FD; Wed, 26 Sep 2018 19:52:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alex Hung <alex.hung@canonical.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 25/28] platform/x86: intel_telemetry: Convert to use SPDX identifier
Date:   Wed, 26 Sep 2018 19:52:20 +0300
Message-Id: <20180926165223.19390-25-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926165223.19390-1-andriy.shevchenko@linux.intel.com>
References: <20180926165223.19390-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce size of duplicated comments by switching to use SPDX identifier.

No functional change.

While here, correct MODULE_LICENSE() string to be aligned with license text.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel_telemetry_core.c    | 12 ++----------
 drivers/platform/x86/intel_telemetry_debugfs.c | 12 ++----------
 drivers/platform/x86/intel_telemetry_pltdrv.c  | 12 ++----------
 3 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/platform/x86/intel_telemetry_core.c b/drivers/platform/x86/intel_telemetry_core.c
index f378621b5fe9..d4040bb222b4 100644
--- a/drivers/platform/x86/intel_telemetry_core.c
+++ b/drivers/platform/x86/intel_telemetry_core.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel SoC Core Telemetry Driver
  * Copyright (C) 2015, Intel Corporation.
  * All Rights Reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
  * Telemetry Framework provides platform related PM and performance statistics.
  * This file provides the core telemetry API implementation.
  */
@@ -460,4 +452,4 @@ module_exit(telemetry_module_exit);
 
 MODULE_AUTHOR("Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>");
 MODULE_DESCRIPTION("Intel SoC Telemetry Interface");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
index ffd0474b0531..badd1682f9c1 100644
--- a/drivers/platform/x86/intel_telemetry_debugfs.c
+++ b/drivers/platform/x86/intel_telemetry_debugfs.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel SOC Telemetry debugfs Driver: Currently supports APL
  * Copyright (c) 2015, Intel Corporation.
  * All Rights Reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
  * This file provides the debugfs interfaces for telemetry.
  * /sys/kernel/debug/telemetry/pss_info: Shows Primary Control Sub-Sys Counters
  * /sys/kernel/debug/telemetry/ioss_info: Shows IO Sub-System Counters
@@ -1037,4 +1029,4 @@ module_exit(telemetry_debugfs_exit);
 MODULE_AUTHOR("Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>");
 MODULE_DESCRIPTION("Intel SoC Telemetry debugfs Interface");
 MODULE_VERSION(DRIVER_VERSION);
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/intel_telemetry_pltdrv.c b/drivers/platform/x86/intel_telemetry_pltdrv.c
index 2f889d6c270e..62531d2524d8 100644
--- a/drivers/platform/x86/intel_telemetry_pltdrv.c
+++ b/drivers/platform/x86/intel_telemetry_pltdrv.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel SOC Telemetry Platform Driver: Currently supports APL
  * Copyright (c) 2015, Intel Corporation.
  * All Rights Reserved.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
  * This file provides the platform specific telemetry implementation for APL.
  * It used the PUNIT and PMC IPC interfaces for configuring the counters.
  * The accumulated results are fetched from SRAM.
@@ -1242,4 +1234,4 @@ module_exit(telemetry_module_exit);
 MODULE_AUTHOR("Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>");
 MODULE_DESCRIPTION("Intel SoC Telemetry Platform Driver");
 MODULE_VERSION(DRIVER_VERSION);
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.19.0

