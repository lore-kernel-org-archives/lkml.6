Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeEKRD4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 13:03:56 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:44040 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751839AbeEKRDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 13:03:44 -0400
From: Suman Anna <s-anna@ti.com>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>,
        "Mathieu J . Poirier" <mathieu.poirier@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/6] hwspinlock/u8500: Switch to SPDX license identifier
Date: Fri, 11 May 2018 12:03:20 -0500
Message-ID: <20180511170321.2452-6-s-anna@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180511170321.2452-1-s-anna@ti.com>
References: <20180511170321.2452-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the appropriate SPDX license identifier in the U8500 HWSEM
driver source file and drop the previous boilerplate license text.

Cc: Mathieu J. Poirier <mathieu.poirier@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/hwspinlock/u8500_hsem.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/hwspinlock/u8500_hsem.c b/drivers/hwspinlock/u8500_hsem.c
index e93eabbd660f..84a92d424e8d 100644
--- a/drivers/hwspinlock/u8500_hsem.c
+++ b/drivers/hwspinlock/u8500_hsem.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * u8500 HWSEM driver
  *
@@ -10,15 +11,6 @@
  *   Simon Que <sque@ti.com>
  *   Hari Kanigeri <h-kanigeri2@ti.com>
  *   Ohad Ben-Cohen <ohad@wizery.com>
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
 
 #include <linux/module.h>
-- 
2.17.0
