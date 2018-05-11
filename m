Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeEKREk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 13:04:40 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:62515 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeEKRDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 13:03:41 -0400
From: Suman Anna <s-anna@ti.com>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        Wei Chen <wei.chen@csr.com>, Barry Song <baohua@kernel.org>
Subject: [PATCH 4/6] hwspinlock/sirf: Switch to SPDX license identifier
Date: Fri, 11 May 2018 12:03:19 -0500
Message-ID: <20180511170321.2452-5-s-anna@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511170321.2452-1-s-anna@ti.com>
References: <20180511170321.2452-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the appropriate SPDX license identifier in the CSR's SIRF hardware
spinlock driver source file and drop the previous boilerplate license text.

Cc: Wei Chen <wei.chen@csr.com>
Cc: Barry Song <baohua@kernel.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/hwspinlock/sirf_hwspinlock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hwspinlock/sirf_hwspinlock.c b/drivers/hwspinlock/sirf_hwspinlock.c
index 16018544d431..02ef6e543cd1 100644
--- a/drivers/hwspinlock/sirf_hwspinlock.c
+++ b/drivers/hwspinlock/sirf_hwspinlock.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SIRF hardware spinlock driver
  *
  * Copyright (c) 2015 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2.
  */
 
 #include <linux/kernel.h>
-- 
2.17.0
