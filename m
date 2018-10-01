Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A68FC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60ED208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60ED208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbeJAQI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:08:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:24188 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729148AbeJAQI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 12:08:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 02:31:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,327,1534834800"; 
   d="scan'208";a="78875546"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 01 Oct 2018 02:31:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 63A452A4; Mon,  1 Oct 2018 12:31:23 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] thunderbolt: Convert rest of the driver files to use SPDX identifier
Date:   Mon,  1 Oct 2018 12:31:21 +0300
Message-Id: <20181001093122.65833-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001093122.65833-1-mika.westerberg@linux.intel.com>
References: <20181001093122.65833-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This gets rid of the licence boilerplate duplicated in each file. While
there fix doubled space in domain.c author line.

No functional changes intended.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Yehezkel Bernat <yehezkelshb@gmail.com>
---
 drivers/thunderbolt/dma_port.c | 5 +----
 drivers/thunderbolt/dma_port.h | 5 +----
 drivers/thunderbolt/domain.c   | 7 ++-----
 drivers/thunderbolt/icm.c      | 5 +----
 drivers/thunderbolt/property.c | 5 +----
 drivers/thunderbolt/tb_msgs.h  | 5 +----
 drivers/thunderbolt/xdomain.c  | 5 +----
 include/linux/thunderbolt.h    | 5 +----
 8 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/thunderbolt/dma_port.c b/drivers/thunderbolt/dma_port.c
index f2701194f810..847dd07a7b17 100644
--- a/drivers/thunderbolt/dma_port.c
+++ b/drivers/thunderbolt/dma_port.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Thunderbolt DMA configuration based mailbox support
  *
  * Copyright (C) 2017, Intel Corporation
  * Authors: Michael Jamet <michael.jamet@intel.com>
  *          Mika Westerberg <mika.westerberg@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/thunderbolt/dma_port.h b/drivers/thunderbolt/dma_port.h
index c4a69e0fbff7..7deadd97ce31 100644
--- a/drivers/thunderbolt/dma_port.h
+++ b/drivers/thunderbolt/dma_port.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Thunderbolt DMA configuration based mailbox support
  *
  * Copyright (C) 2017, Intel Corporation
  * Authors: Michael Jamet <michael.jamet@intel.com>
  *          Mika Westerberg <mika.westerberg@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef DMA_PORT_H_
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 092381e2accf..93e562f18d40 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Thunderbolt bus support
  *
  * Copyright (C) 2017, Intel Corporation
- * Author:  Mika Westerberg <mika.westerberg@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
+ * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
 #include <linux/device.h>
diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index e1e264a9a4c7..533068651f90 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Internal Thunderbolt Connection Manager. This is a firmware running on
  * the Thunderbolt host controller performing most of the low-level
@@ -6,10 +7,6 @@
  * Copyright (C) 2017, Intel Corporation
  * Authors: Michael Jamet <michael.jamet@intel.com>
  *          Mika Westerberg <mika.westerberg@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index 8fe913a95b4a..b2f0d6386cee 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Thunderbolt XDomain property support
  *
  * Copyright (C) 2017, Intel Corporation
  * Authors: Michael Jamet <michael.jamet@intel.com>
  *          Mika Westerberg <mika.westerberg@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/err.h>
diff --git a/drivers/thunderbolt/tb_msgs.h b/drivers/thunderbolt/tb_msgs.h
index 2487e162c885..02c84aa3d018 100644
--- a/drivers/thunderbolt/tb_msgs.h
+++ b/drivers/thunderbolt/tb_msgs.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Thunderbolt control channel messages
  *
  * Copyright (C) 2014 Andreas Noever <andreas.noever@gmail.com>
  * Copyright (C) 2017, Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef _TB_MSGS
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index db8bece63327..e27dd8beb94b 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Thunderbolt XDomain discovery protocol support
  *
  * Copyright (C) 2017, Intel Corporation
  * Authors: Michael Jamet <michael.jamet@intel.com>
  *          Mika Westerberg <mika.westerberg@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/device.h>
diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
index a3ed26082bc1..bf6ec83e60ee 100644
--- a/include/linux/thunderbolt.h
+++ b/include/linux/thunderbolt.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Thunderbolt service API
  *
@@ -5,10 +6,6 @@
  * Copyright (C) 2017, Intel Corporation
  * Authors: Michael Jamet <michael.jamet@intel.com>
  *          Mika Westerberg <mika.westerberg@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef THUNDERBOLT_H_
-- 
2.19.0

