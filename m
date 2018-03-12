Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751415AbeCLNPX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 09:15:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41502 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbeCLNPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 09:15:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EEF7A603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=absahu@codeaurora.org
From: Abhishek Sahu <absahu@codeaurora.org>
To: Andy Gross <andy.gross@linaro.org>, Wolfram Sang <wsa@the-dreams.de>
Cc: David Brown <david.brown@linaro.org>,
        Sricharan R <sricharan@codeaurora.org>,
        Austin Christ <austinwc@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abhishek Sahu <absahu@codeaurora.org>
Subject: [PATCH v2 01/13] i2c: qup: fix copyrights and update to SPDX identifier
Date: Mon, 12 Mar 2018 18:44:50 +0530
Message-Id: <1520860502-14886-2-git-send-email-absahu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
References: <1520860502-14886-1-git-send-email-absahu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file has been updated from 2016 to 2018 so fixed the
copyright years.

Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index 08f8e01..ac5edfa 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1,17 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2009-2013, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2009-2013, 2016-2018, The Linux Foundation. All rights reserved.
  * Copyright (c) 2014, Sony Mobile Communications AB.
  *
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 #include <linux/acpi.h>
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
