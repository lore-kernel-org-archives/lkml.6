Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B047C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F093E20858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:13:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F093E20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbeKKA7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 19:59:04 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:50281 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbeKKA7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 19:59:03 -0500
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MV6G0-1ftLSY1P4I-00S4p9; Sat, 10 Nov 2018 16:13:20 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Eric Anholt <eric@anholt.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Simon Arlott <simon@arlott.org>,
        Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 04/17] clk: bcm2835: Switch to SPDX identifier
Date:   Sat, 10 Nov 2018 16:12:35 +0100
Message-Id: <1541862755-7034-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:n6Lte+v4ouhFUEzNQPszuaPGgc2izjdA7l8EdJPVlN9mvxlVM6w
 LDgVLhKe2rO1zeMkZfF71op+9oOJ8K+NX8V6nzZ9W2whXA4flkL0bDlvhZNLk+zZUXl1C8A
 S2Sm3jaRNx6fIoUiU8DCDcR1rgWfxJSwBO2jvAOHGu8x7/UyT7H5y0nXY4ycvLY9QTTqWOz
 FOSPYHtHMW32bl+Wu3qSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9TnLD3EJqMQ=:q8P5mb9iMWFVn4WWssTrVL
 93bIt6TLh3B9C2tWnDziNsIntReC3US+XgDoDA1z8bmWKyhXRZyVgOuivfsba2qEyeeJi9NbG
 Fo7zIHgE9MfK0Fk3IHEjkF/VC/mbRqwcol6wvo8BwfGLRbv+mGSb3qEkcqYZlapdsAsyeSiom
 ZpPQXvq9NPp1k1uPGMPOdSn0H1kpg6Lu9H96TAqpkXLUucxcE+8kL2HPq3eAFcJbDgVj9zVYF
 2UqpzUCS78ra0eqaSOydiAcGrKELu0CZsqPGBc/8X5aa6aAsbnw5/4TtdPrIzi1+0Co2GbfOr
 d5NblpvScsDPKmjiMZCgdu93aFKcvJAs/GNotRv8Bu7ywdBePtR6PIh771xiAx4wfDp1g94c3
 B6ACObzpSE3PdllnsYAKhe7qAm5Mep9ALJ+8uafr6YadJdBQ5a580lgdzZaRdzmQd32d1Ez3D
 iDTt1eHVnrhzso0RmoXDs6dGzOipAflevmDVcr6lCSWuvvR5RlzhkcoFgrNDnTEJvzfN9MfZz
 uLFZSeHu/HeLpBCJoiev5oOILEmGMCe1No6TAIrW48NVbEWuNqkGkJI7KsyDQs+pVVatckM7Q
 czfLu404pxegjz3i3AtZ+cRLNTvj1Ub2kS+HSK1Rv24aCcmtxlAF9EBtUCNz+QG3s+iULxi95
 XgJNPtuMNx/O8NA3/Z67pugb9WnEP7zU0AHEWWZplRkvx57uysYSn0Pq/kDu8JMWyq9m0jrd4
 oXPDtVa/lzkHw+OM1+fwLaveRZxyVQash2S/j7mPDGBqTGnTEWcnZLi9ZmRTuMNigVU15AzOQ
 TLr8BSYKGAbMpVOcKyMDwCRKYby6A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Cc: Simon Arlott <simon@arlott.org>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/clk/bcm/clk-bcm2835-aux.c       | 11 +----------
 drivers/clk/bcm/clk-bcm2835.c           | 12 +-----------
 include/dt-bindings/clock/bcm2835-aux.h | 10 +---------
 include/dt-bindings/clock/bcm2835.h     | 10 +---------
 4 files changed, 4 insertions(+), 39 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835-aux.c b/drivers/clk/bcm/clk-bcm2835-aux.c
index e01d557..2a2c756 100644
--- a/drivers/clk/bcm/clk-bcm2835-aux.c
+++ b/drivers/clk/bcm/clk-bcm2835-aux.c
@@ -1,15 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2015 Broadcom
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 6b6d836..9fcae93 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -1,17 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2010,2015 Broadcom
  * Copyright (C) 2012 Stephen Warren
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 /**
diff --git a/include/dt-bindings/clock/bcm2835-aux.h b/include/dt-bindings/clock/bcm2835-aux.h
index d91156e..6e608bf 100644
--- a/include/dt-bindings/clock/bcm2835-aux.h
+++ b/include/dt-bindings/clock/bcm2835-aux.h
@@ -1,14 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2015 Broadcom Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #define BCM2835_AUX_CLOCK_UART		0
diff --git a/include/dt-bindings/clock/bcm2835.h b/include/dt-bindings/clock/bcm2835.h
index a0c812b..ca7efd1 100644
--- a/include/dt-bindings/clock/bcm2835.h
+++ b/include/dt-bindings/clock/bcm2835.h
@@ -1,14 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2015 Broadcom Corporation
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #define BCM2835_PLLA			0
-- 
2.7.4

