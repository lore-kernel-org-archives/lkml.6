Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD77BC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FBBD2080F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 08:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PoV1y1RA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbfBEI43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 03:56:29 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10562 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfBEI43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 03:56:29 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c594fbf0000>; Tue, 05 Feb 2019 00:56:31 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 05 Feb 2019 00:56:28 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 05 Feb 2019 00:56:28 -0800
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Feb
 2019 08:56:27 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Feb
 2019 08:56:28 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 5 Feb 2019 08:56:28 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.175.36]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c594fbb0000>; Tue, 05 Feb 2019 00:56:27 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <digetx@gmail.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        "Sowjanya Komatineni" <skomatineni@nvidia.com>
Subject: [PATCH V11 1/5] i2c: tegra: sort all the include headers alphabetically
Date:   Tue, 5 Feb 2019 00:56:21 -0800
Message-ID: <1549356985-25726-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549356991; bh=R27/nAX0FDPhNLFmdgIsheCagv0n7NryJjjxsPpw/o0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=PoV1y1RALSUUFBTVREyjC+uk1k+L3SknwddGltpywKEui0EobAmWywIo7/ON/BhEe
         axpB/qNOg+TKYWuIHPn2Ufj+uvn6WvA1FMgBVkQOSkNEGexfIRIYl04Dt9OAalzxxy
         6J1g2kfsonHTgby091ymSozDBqQq4LD0tIN2h1WdG8K9v9B/4fTv2fZM7TSUVOK6uF
         ROear/WDMFwOoYrKiAVRmSLFLbYqPlx/UFIdgtBLbdBTluv2P8fyaqyQxqT748oRhv
         R5fSX1otK8kOGaiD8v4pzWnQImzvw0gCRRLBIyInIAV8IxbY4NPvRmp+KcDh7zAvyD
         8iFgCWvfoIeSw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch sorts all the include headers alphabetically for the
I2C Tegra driver.

Acked-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 [V9/V10/V11] : Rebased to 5.0-rc4
 [V3/V4/V5/V7/V8] : Removed unsued headers in tegra I2C
 [V2] : Added this in V2 to sort the headers in tegra I2C

 drivers/i2c/busses/i2c-tegra.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index c77adbbea0c7..79c6aa87499b 100644
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

