Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755202AbeBBSlH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:41:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:47241 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755061AbeBBSkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:40:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="scan'208";a="28359778"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 8/8] parport: Replace short License header by SPDX identifier
Date: Fri,  2 Feb 2018 20:39:55 +0200
Message-Id: <20180202183955.85453-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180202183955.85453-1-andriy.shevchenko@linux.intel.com>
References: <20180202183955.85453-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional changes involved.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/parport_serial.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index e71340014638..ae9e01ef7599 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -1,20 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Support for common PCI multi-I/O cards (which is most of them)
  *
  * Copyright (C) 2001  Tim Waugh <twaugh@redhat.com>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
- *
  * Multi-function PCI cards are supposed to present separate logical
  * devices on the bus.  A common thing to do seems to be to just use
  * one logical device with lots of base address registers for both
  * parallel ports and serial ports.  This driver is for dealing with
  * that.
- *
  */
 
 #include <linux/interrupt.h>
-- 
2.15.1
