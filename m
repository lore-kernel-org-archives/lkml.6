Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753805AbeAaRyL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:54:11 -0500
Received: from mga07.intel.com ([134.134.136.100]:46024 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752265AbeAaRyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:54:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,441,1511856000";
   d="scan'208";a="30965835"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        AceLan Kao <acelan.kao@canonical.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] platform/x86: intel-vbtn: Remove redundant inclusions
Date: Wed, 31 Jan 2018 19:54:06 +0200
Message-Id: <20180131175407.18301-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some headers are not needed since the driver can be built as module.
Remove them.

While here, sort headers alphabetically.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel-vbtn.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index 101c100a3929..69bc39f8d61d 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -16,15 +16,13 @@
  *
  */
 
+#include <linux/acpi.h>
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/init.h>
-#include <linux/input.h>
 #include <linux/platform_device.h>
-#include <linux/input/sparse-keymap.h>
-#include <linux/acpi.h>
 #include <linux/suspend.h>
-#include <acpi/acpi_bus.h>
 
 /* When NOT in tablet mode, VGBS returns with the flag 0x40 */
 #define TABLET_MODE_FLAG 0x40
-- 
2.15.1
