Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEC2C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8627E2175B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eg43h/rH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbfBEWqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:46:14 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2522 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfBEWqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:46:12 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5a12140000>; Tue, 05 Feb 2019 14:45:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 05 Feb 2019 14:46:11 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 05 Feb 2019 14:46:11 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Feb
 2019 22:46:11 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 5 Feb 2019 22:46:11 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.70]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c5a12330000>; Tue, 05 Feb 2019 14:46:11 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mkarthik@nvidia.com>, <smohammed@nvidia.com>, <talho@nvidia.com>
CC:     <digetx@gmail.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V12 1/5] i2c: tegra: sort all the include headers alphabetically
Date:   Tue, 5 Feb 2019 14:46:05 -0800
Message-ID: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549406740; bh=1tNAAxaCWk/xJ+GX3e5N7lJiEbhg97aq2fTry48eO1k=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=eg43h/rHkRcsavg96+QY8nMUcd7JkO9Vd9qw9gcTjDMkMXIBuvZTz89Edv/e2FrEk
         x511l0B0UbmUutqoY89XCt4MXkDvkC++I1Nrvdy2QGJ39mkCc/+wY9Akoq9eXcEpBd
         8rNkDYiWY9O163wM+SI4ARhptsU7iKEKwvdXKKbACBtBZ77a1UBBo2d/FiXVpwOxPW
         lU0LJ5kEqCIY3WRKYwrMQf8R/LenlUqzSsYXINpg2rRvPN1G6Pqwn6W4aMEenMbXx5
         uBpoELWmzLCStYiazuxo5pfhrrLwT3QkZdmzy39ZH2JzB0s7sw5KCPoJfZ20GansBG
         7IaxCuYrSOv6A==
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
 [V9/V10/V11/V12] : Rebased to 5.0-rc4
 [V3/V4/V5/V7/V8] : Removed unsued headers in tegra I2C
 [V2] 		  : Added this in V2 to sort the headers in tegra I2C

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

