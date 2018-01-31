Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932360AbeAaRyX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:54:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:18760 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753539AbeAaRyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:54:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,441,1511856000";
   d="scan'208";a="27792557"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        AceLan Kao <acelan.kao@canonical.com>, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] platform/x86: intel-vbtn: Replace License by SDPX identifier
Date: Wed, 31 Jan 2018 19:54:07 +0200
Message-Id: <20180131175407.18301-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180131175407.18301-1-andriy.shevchenko@linux.intel.com>
References: <20180131175407.18301-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace License short header by SPDX identifier.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel-vbtn.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index 69bc39f8d61d..b703d6f5b099 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -1,19 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Intel Virtual Button driver for Windows 8.1+
  *
  *  Copyright (C) 2016 AceLan Kao <acelan.kao@canonical.com>
  *  Copyright (C) 2016 Alex Hung <alex.hung@canonical.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
  */
 
 #include <linux/acpi.h>
-- 
2.15.1
