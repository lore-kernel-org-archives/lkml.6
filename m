Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755881AbeEaRLr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:11:47 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:21593 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755688AbeEaRLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:11:44 -0400
From: Suman Anna <s-anna@ti.com>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Suman Anna <s-anna@ti.com>
Subject: [PATCH 3/5] rpmsg: smd: Switch to SPDX license identifier
Date: Thu, 31 May 2018 12:11:01 -0500
Message-ID: <20180531171103.8703-4-s-anna@ti.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180531171103.8703-1-s-anna@ti.com>
References: <20180531171103.8703-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the appropriate SPDX license identifier in the rpmsg SMD backend
driver source file and drop the previous boilerplate license text.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/rpmsg/qcom_smd.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
index 5ce9bf7b897d..0819836fc178 100644
--- a/drivers/rpmsg/qcom_smd.c
+++ b/drivers/rpmsg/qcom_smd.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2015, Sony Mobile Communications AB.
  * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/interrupt.h>
-- 
2.17.0
