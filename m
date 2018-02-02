Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932086AbeBBSl7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:41:59 -0500
Received: from mga17.intel.com ([192.55.52.151]:51444 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755051AbeBBSkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:40:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="scan'208";a="171221081"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nikola Ciprich <nikola.ciprich@linuxbox.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 7/8] parport: Sort headers alphabetically
Date: Fri,  2 Feb 2018 20:39:54 +0200
Message-Id: <20180202183955.85453-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180202183955.85453-1-andriy.shevchenko@linux.intel.com>
References: <20180202183955.85453-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While here, remove init.h inclusion since we are not using it directly and
module.h will do this for us.

No functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/parport/parport_serial.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/parport/parport_serial.c b/drivers/parport/parport_serial.c
index be28cc1fa37e..e71340014638 100644
--- a/drivers/parport/parport_serial.c
+++ b/drivers/parport/parport_serial.c
@@ -17,14 +17,14 @@
  *
  */
 
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <linux/pci.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/parport.h>
 #include <linux/parport_pc.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
 #include <linux/8250_pci.h>
 
 enum parport_pc_pci_cards {
-- 
2.15.1
