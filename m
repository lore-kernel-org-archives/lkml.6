Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FAEC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346D320882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 13:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346D320882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeILSqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 14:46:10 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54028 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbeILSqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 14:46:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1512B20797; Wed, 12 Sep 2018 15:41:33 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id CF39420379;
        Wed, 12 Sep 2018 15:41:22 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH] clk: mvebu: use SPDX-License-Identifier
Date:   Wed, 12 Sep 2018 15:40:17 +0200
Message-Id: <20180912134017.11236-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the remaining files to SPDX license description.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/clk/mvebu/ap806-system-controller.c | 4 +---
 drivers/clk/mvebu/armada-370.c              | 4 +---
 drivers/clk/mvebu/armada-375.c              | 4 +---
 drivers/clk/mvebu/armada-37xx-tbg.c         | 5 +----
 drivers/clk/mvebu/armada-37xx-xtal.c        | 4 +---
 drivers/clk/mvebu/armada-38x.c              | 4 +---
 drivers/clk/mvebu/armada-39x.c              | 4 +---
 drivers/clk/mvebu/armada-xp.c               | 4 +---
 drivers/clk/mvebu/clk-corediv.c             | 4 +---
 drivers/clk/mvebu/clk-cpu.c                 | 4 +---
 drivers/clk/mvebu/common.c                  | 4 +---
 drivers/clk/mvebu/common.h                  | 4 +---
 drivers/clk/mvebu/cp110-system-controller.c | 4 +---
 drivers/clk/mvebu/dove.c                    | 4 +---
 drivers/clk/mvebu/kirkwood.c                | 4 +---
 drivers/clk/mvebu/mv98dx3236.c              | 4 +---
 drivers/clk/mvebu/orion.c                   | 4 +---
 17 files changed, 17 insertions(+), 52 deletions(-)

diff --git a/drivers/clk/mvebu/ap806-system-controller.c b/drivers/clk/mvebu/ap806-system-controller.c
index fa2fbd2cef4a..9fbec3eb725f 100644
--- a/drivers/clk/mvebu/ap806-system-controller.c
+++ b/drivers/clk/mvebu/ap806-system-controller.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Armada AP806 System Controller
  *
@@ -5,9 +6,6 @@
  *
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "ap806-system-controller: " fmt
diff --git a/drivers/clk/mvebu/armada-370.c b/drivers/clk/mvebu/armada-370.c
index 2c7c1085f883..7dedfaa6e152 100644
--- a/drivers/clk/mvebu/armada-370.c
+++ b/drivers/clk/mvebu/armada-370.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Armada 370 SoC clocks
  *
@@ -7,9 +8,6 @@
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  * Andrew Lunn <andrew@lunn.ch>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/clk/mvebu/armada-375.c b/drivers/clk/mvebu/armada-375.c
index c7af2242b796..a7157c690238 100644
--- a/drivers/clk/mvebu/armada-375.c
+++ b/drivers/clk/mvebu/armada-375.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Armada 375 SoC clocks
  *
@@ -7,9 +8,6 @@
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  * Andrew Lunn <andrew@lunn.ch>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
index 7ff041f73b55..71f30149e80e 100644
--- a/drivers/clk/mvebu/armada-37xx-tbg.c
+++ b/drivers/clk/mvebu/armada-37xx-tbg.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Marvell Armada 37xx SoC Time Base Generator clocks
  *
  * Copyright (C) 2016 Marvell
  *
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2 or later. This program is licensed "as is"
- * without any warranty of any kind, whether express or implied.
  */
 
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/mvebu/armada-37xx-xtal.c b/drivers/clk/mvebu/armada-37xx-xtal.c
index 612d65ede10a..e9e306d4e9af 100644
--- a/drivers/clk/mvebu/armada-37xx-xtal.c
+++ b/drivers/clk/mvebu/armada-37xx-xtal.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Armada 37xx SoC xtal clocks
  *
@@ -5,9 +6,6 @@
  *
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/mvebu/armada-38x.c b/drivers/clk/mvebu/armada-38x.c
index 9ff4ea63932d..ef2ab81f087d 100644
--- a/drivers/clk/mvebu/armada-38x.c
+++ b/drivers/clk/mvebu/armada-38x.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Armada 380/385 SoC clocks
  *
@@ -7,9 +8,6 @@
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  * Andrew Lunn <andrew@lunn.ch>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/clk/mvebu/armada-39x.c b/drivers/clk/mvebu/armada-39x.c
index 4fdfd32247a9..674ccfd6236e 100644
--- a/drivers/clk/mvebu/armada-39x.c
+++ b/drivers/clk/mvebu/armada-39x.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Armada 39x SoC clocks
  *
@@ -8,9 +9,6 @@
  * Andrew Lunn <andrew@lunn.ch>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/clk/mvebu/armada-xp.c b/drivers/clk/mvebu/armada-xp.c
index 0ec44ae9a2a2..e8f03293ec83 100644
--- a/drivers/clk/mvebu/armada-xp.c
+++ b/drivers/clk/mvebu/armada-xp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Armada XP SoC clocks
  *
@@ -7,9 +8,6 @@
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  * Andrew Lunn <andrew@lunn.ch>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/clk/mvebu/clk-corediv.c b/drivers/clk/mvebu/clk-corediv.c
index 68f05c53d40e..1fc84b0e72ee 100644
--- a/drivers/clk/mvebu/clk-corediv.c
+++ b/drivers/clk/mvebu/clk-corediv.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * MVEBU Core divider clock
  *
@@ -5,9 +6,6 @@
  *
  * Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index 072aa38374ce..d1a715767364 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell MVEBU CPU clock handling.
  *
@@ -5,9 +6,6 @@
  *
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/kernel.h>
 #include <linux/slab.h>
diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
index 472c88b90256..6ab3c2e627c7 100644
--- a/drivers/clk/mvebu/common.c
+++ b/drivers/clk/mvebu/common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell EBU SoC common clock handling
  *
@@ -7,9 +8,6 @@
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  * Andrew Lunn <andrew@lunn.ch>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/clk/mvebu/common.h b/drivers/clk/mvebu/common.h
index f0de6c8a494a..d1ab79b43105 100644
--- a/drivers/clk/mvebu/common.h
+++ b/drivers/clk/mvebu/common.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Marvell EBU SoC common clock handling
  *
@@ -7,9 +8,6 @@
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  * Andrew Lunn <andrew@lunn.ch>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __CLK_MVEBU_COMMON_H_
diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
index 75bf7b8f282f..9781b1bf5998 100644
--- a/drivers/clk/mvebu/cp110-system-controller.c
+++ b/drivers/clk/mvebu/cp110-system-controller.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Armada CP110 System Controller
  *
@@ -5,9 +6,6 @@
  *
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 /*
diff --git a/drivers/clk/mvebu/dove.c b/drivers/clk/mvebu/dove.c
index 59fad9546c84..e0dd99f36bf4 100644
--- a/drivers/clk/mvebu/dove.c
+++ b/drivers/clk/mvebu/dove.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Dove SoC clocks
  *
@@ -7,9 +8,6 @@
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  * Andrew Lunn <andrew@lunn.ch>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/clk/mvebu/kirkwood.c b/drivers/clk/mvebu/kirkwood.c
index a2a8d614039d..6f784167bda4 100644
--- a/drivers/clk/mvebu/kirkwood.c
+++ b/drivers/clk/mvebu/kirkwood.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Kirkwood SoC clocks
  *
@@ -7,9 +8,6 @@
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  * Andrew Lunn <andrew@lunn.ch>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/clk/mvebu/mv98dx3236.c b/drivers/clk/mvebu/mv98dx3236.c
index 6e203af73cac..0a74cf7a7725 100644
--- a/drivers/clk/mvebu/mv98dx3236.c
+++ b/drivers/clk/mvebu/mv98dx3236.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell MV98DX3236 SoC clocks
  *
@@ -7,9 +8,6 @@
  * Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
  * Andrew Lunn <andrew@lunn.ch>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/clk/mvebu/orion.c b/drivers/clk/mvebu/orion.c
index a6e5bee23385..f681a65be20a 100644
--- a/drivers/clk/mvebu/orion.c
+++ b/drivers/clk/mvebu/orion.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Marvell Orion SoC clocks
  *
@@ -5,9 +6,6 @@
  *
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
-- 
2.18.0

