Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751989AbeEKRDx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 13:03:53 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:44041 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751850AbeEKRDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 13:03:44 -0400
From: Suman Anna <s-anna@ti.com>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Baolin Wang <baolin.wang@spreadtrum.com>
Subject: [PATCH 6/6] hwspinlock: sprd: Switch to SPDX license identifier
Date: Fri, 11 May 2018 12:03:21 -0500
Message-ID: <20180511170321.2452-7-s-anna@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511170321.2452-1-s-anna@ti.com>
References: <20180511170321.2452-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the appropriate SPDX license identifiers in the Spreadtrum hardware
spinlock driver source file and drop the previous boilerplate license text.

Cc: Baolin Wang <baolin.wang@spreadtrum.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/hwspinlock/sprd_hwspinlock.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/hwspinlock/sprd_hwspinlock.c b/drivers/hwspinlock/sprd_hwspinlock.c
index 638e64ac18f5..dc42bf51f3e6 100644
--- a/drivers/hwspinlock/sprd_hwspinlock.c
+++ b/drivers/hwspinlock/sprd_hwspinlock.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Spreadtrum hardware spinlock driver
  * Copyright (C) 2017 Spreadtrum  - http://www.spreadtrum.com
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
  */
 
 #include <linux/bitops.h>
-- 
2.17.0
