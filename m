Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbeBUAEN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 19:04:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:15029 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751772AbeBUAED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 19:04:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,542,1511856000";
   d="scan'208";a="19064728"
From: Rajmohan Mani <rajmohan.mani@intel.com>
To: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>
Subject: [PATCH 3/3] ACPI / PMIC: Update to SPDX license identifier
Date: Tue, 20 Feb 2018 15:54:09 -0800
Message-Id: <1519170849-28802-4-git-send-email-rajmohan.mani@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519170849-28802-1-git-send-email-rajmohan.mani@intel.com>
References: <1519170849-28802-1-git-send-email-rajmohan.mani@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the GPL v2 license boilerplate and update with
the SPDX license identifier.

Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
---
 drivers/acpi/pmic/tps68470_pmic.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/acpi/pmic/tps68470_pmic.c b/drivers/acpi/pmic/tps68470_pmic.c
index 7f3c567..a083de5 100644
--- a/drivers/acpi/pmic/tps68470_pmic.c
+++ b/drivers/acpi/pmic/tps68470_pmic.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * TI TPS68470 PMIC operation region driver
  *
@@ -5,15 +6,6 @@
  *
  * Author: Rajmohan Mani <rajmohan.mani@intel.com>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License version
- * 2 as published by the Free Software Foundation.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  * Based on drivers/acpi/pmic/intel_pmic* drivers
  */
 
-- 
1.9.1
