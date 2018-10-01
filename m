Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD254C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAF020652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EAF020652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeJAQJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:09:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:31514 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728978AbeJAQJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:09:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 02:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,327,1534834800"; 
   d="scan'208";a="96414385"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 01 Oct 2018 02:31:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 6EE9D2D1; Mon,  1 Oct 2018 12:31:23 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] thunderbolt: Add Intel as copyright holder
Date:   Mon,  1 Oct 2018 12:31:22 +0300
Message-Id: <20181001093122.65833-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001093122.65833-1-mika.westerberg@linux.intel.com>
References: <20181001093122.65833-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel has done pretty major changes to the driver and we continue to do
so in the future as well. Add Intel as copyright holder of the files we
have done changes.

While there drop "Cactus Ridge" from the headers because this driver
works also with other Thunderbolt controllers.

No functional changes intended.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Yehezkel Bernat <yehezkelshb@gmail.com>
---
 drivers/thunderbolt/cap.c      | 3 ++-
 drivers/thunderbolt/ctl.c      | 3 ++-
 drivers/thunderbolt/ctl.h      | 3 ++-
 drivers/thunderbolt/eeprom.c   | 3 ++-
 drivers/thunderbolt/nhi.c      | 3 ++-
 drivers/thunderbolt/nhi.h      | 3 ++-
 drivers/thunderbolt/nhi_regs.h | 1 +
 drivers/thunderbolt/switch.c   | 3 ++-
 drivers/thunderbolt/tb.h       | 3 ++-
 drivers/thunderbolt/tb_regs.h  | 3 ++-
 10 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/thunderbolt/cap.c b/drivers/thunderbolt/cap.c
index c2277b8ee88d..9553305c63ea 100644
--- a/drivers/thunderbolt/cap.c
+++ b/drivers/thunderbolt/cap.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Thunderbolt Cactus Ridge driver - capabilities lookup
+ * Thunderbolt driver - capabilities lookup
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (C) 2018, Intel Corporation
  */
 
 #include <linux/slab.h>
diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index 7456c094e232..73b386de4d15 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Thunderbolt Cactus Ridge driver - control channel and configuration commands
+ * Thunderbolt driver - control channel and configuration commands
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (C) 2018, Intel Corporation
  */
 
 #include <linux/crc32.h>
diff --git a/drivers/thunderbolt/ctl.h b/drivers/thunderbolt/ctl.h
index 3062e0b5f71e..2f1a1e111110 100644
--- a/drivers/thunderbolt/ctl.h
+++ b/drivers/thunderbolt/ctl.h
@@ -1,8 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Thunderbolt Cactus Ridge driver - control channel and configuration commands
+ * Thunderbolt driver - control channel and configuration commands
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (C) 2018, Intel Corporation
  */
 
 #ifndef _TB_CFG
diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index d2dd40390783..81e8ac4c5805 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Thunderbolt Cactus Ridge driver - eeprom access
+ * Thunderbolt driver - eeprom access
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (C) 2018, Intel Corporation
  */
 
 #include <linux/crc32.h>
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 02379aa27120..2874f9400123 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1,10 +1,11 @@
 /*
- * Thunderbolt Cactus Ridge driver - NHI driver
+ * Thunderbolt driver - NHI driver
  *
  * The NHI (native host interface) is the pci device that allows us to send and
  * receive frames from the thunderbolt bus.
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (C) 2018, Intel Corporation
  */
 
 #include <linux/pm_runtime.h>
diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
index 1696a4560948..1b5d47ecd3ed 100644
--- a/drivers/thunderbolt/nhi.h
+++ b/drivers/thunderbolt/nhi.h
@@ -1,8 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Thunderbolt Cactus Ridge driver - NHI driver
+ * Thunderbolt driver - NHI driver
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (C) 2018, Intel Corporation
  */
 
 #ifndef DSL3510_H_
diff --git a/drivers/thunderbolt/nhi_regs.h b/drivers/thunderbolt/nhi_regs.h
index b3e49d19c01e..a60bd98c1d04 100644
--- a/drivers/thunderbolt/nhi_regs.h
+++ b/drivers/thunderbolt/nhi_regs.h
@@ -3,6 +3,7 @@
  * Thunderbolt driver - NHI registers
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (C) 2018, Intel Corporation
  */
 
 #ifndef NHI_REGS_H_
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 9f44a2924dac..52ff854f0d6c 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -1,8 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Thunderbolt Cactus Ridge driver - switch/port utility functions
+ * Thunderbolt driver - switch/port utility functions
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (C) 2018, Intel Corporation
  */
 
 #include <linux/delay.h>
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 5a99245573c0..52584c4003e3 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1,8 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Thunderbolt Cactus Ridge driver - bus logic (NHI independent)
+ * Thunderbolt driver - bus logic (NHI independent)
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (C) 2018, Intel Corporation
  */
 
 #ifndef TB_H_
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 693b0353c3fe..6f1ff04ee195 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -1,12 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Thunderbolt Cactus Ridge driver - Port/Switch config area registers
+ * Thunderbolt driver - Port/Switch config area registers
  *
  * Every thunderbolt device consists (logically) of a switch with multiple
  * ports. Every port contains up to four config regions (HOPS, PORT, SWITCH,
  * COUNTERS) which are used to configure the device.
  *
  * Copyright (c) 2014 Andreas Noever <andreas.noever@gmail.com>
+ * Copyright (C) 2018, Intel Corporation
  */
 
 #ifndef _TB_REGS
-- 
2.19.0

