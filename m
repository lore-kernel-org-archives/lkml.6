Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17548C282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6CD21726
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="KuETsbRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfAZD54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:57:56 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15000 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfAZD54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:57:56 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4bdaa90000>; Fri, 25 Jan 2019 19:57:29 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2019 19:57:55 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 25 Jan 2019 19:57:55 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 26 Jan
 2019 03:57:54 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Sat, 26 Jan 2019 03:57:54 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c4bdac20001>; Fri, 25 Jan 2019 19:57:54 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V3 1/3] i2c: tegra: Sort all the include headers alphabetically
Date:   Fri, 25 Jan 2019 19:57:51 -0800
Message-ID: <1548475073-12408-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548475049; bh=SI6is3BSk+Mq0Ipss3GOuaE/GGtGMSzerf/cFLwsMCQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=KuETsbRHJ9608YRQra9L7V007t4f56y28FxDZu4wUKbFKp/zLHpSNw9+dCiaiV/jS
         ZgwFk2I9isU0X+eDobNZc379N0DG7Je4UgAYrg6qoi1rjKauaZ7POPl6AwRAby9qlj
         31D8yM6G2vFhtXD8XDB/xAgmmarvWXX3OeHO4b+J28BjgYR7cwDezosEeZCqai/Q+G
         lkvLWF850doJnVWtN0I6Tatcw9brXrUINdPl393Ck2Xd5y8zuohZMG5jka8rT2h7hS
         nKv8tTtKigQpEmXg7so5RQywr8GFmDmA/skBl9sexekjSQNU0e47Lo03hXUeI+xThn
         rnNzXY7/CHnkA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sorts all the include headers alphabetically for the
I2C tegra driver

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V3] : Removed unsued headers in tegra I2C
 [V2] : Added this in V2 to sort the headers in tegra I2C

 drivers/i2c/busses/i2c-tegra.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index e417ebf7628c..aec500ef9a98 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -6,24 +6,22 @@
  * Author: Colin Cross <ccross@android.com>
  */
 
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
-#include <linux/io.h>
+#include <linux/init.h>
 #include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/of_device.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/reset.h>
+#include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
-#include <linux/iopoll.h>
-
-#include <asm/unaligned.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
 
 #define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
 #define BYTES_PER_FIFO_WORD 4
-- 
2.7.4

