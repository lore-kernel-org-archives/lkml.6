Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7824DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5184A20870
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 06:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ETFjcXcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfAaGQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 01:16:33 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:1485 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfAaGQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 01:16:33 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5292c10000>; Wed, 30 Jan 2019 22:16:34 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 30 Jan 2019 22:16:32 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 30 Jan 2019 22:16:32 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 06:16:31 +0000
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 06:16:30 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 06:16:30 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.165.12]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c5292bd0009>; Wed, 30 Jan 2019 22:16:30 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V8 1/5] i2c: tegra: Sort all the include headers alphabetically
Date:   Wed, 30 Jan 2019 22:16:23 -0800
Message-ID: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548915394; bh=C3TTXG82kqku8JSiuXKBfY6bhWOvFOK0fGBKS3xKuvs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=ETFjcXcEafLEtvd12aJrjPZS3jGRtWPHzcM9D8EfZh8GseEJjjDwaUf5C7vLuehUk
         n4pxhiuUDSAUVPkvQ3cbgp1s6XdsY9FimYcChBk7zfl9c3AtgcFczljC/bDSXBR/8s
         CvgydQJdoikq92djxcLL+D5eZAr+vCIb9IaKWsl5n2HmqsP60ClVvJPXFpvgb8Ng5u
         PGi9YE9Jmr6o0X0iRfQ5BlZaXYHxx1lF+QOoJsmrY+yCVvchYx+wV06Tueok2RusPZ
         DYD9jyecB+yMeRYjkzsrkoJ+jt6WFbhhcNbPQmPVExUgLhodssIRo4sIp+vNu0z1Kj
         ECH8rQx2Bs0ng==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sorts all the include headers alphabetically for the
I2C tegra driver

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V3/V4/V5/V7/V8] : Removed unsued headers in tegra I2C
 [V2] : Added this in V2 to sort the headers in tegra I2C

 drivers/i2c/busses/i2c-tegra.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index e417ebf7628c..15806c984859 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -6,24 +6,21 @@
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
 
 #define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
 #define BYTES_PER_FIFO_WORD 4
-- 
2.7.4

