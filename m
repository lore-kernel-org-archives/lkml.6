Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8974C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879A321854
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 22:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 879A321854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeHVBYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:24:54 -0400
Received: from sauhun.de ([88.99.104.3]:45346 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbeHVBYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:24:53 -0400
Received: from localhost (p54B3375F.dip0.t-ipconnect.de [84.179.55.95])
        by pokefinder.org (Postfix) with ESMTPSA id AF7872DA3F0;
        Wed, 22 Aug 2018 00:02:54 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] soc: renesas: use SPDX identifier for Renesas drivers
Date:   Wed, 22 Aug 2018 00:02:22 +0200
Message-Id: <20180821220233.9202-10-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

To be applied individually per subsystem tree. Morimoto-san, could you maybe
ack this with your Renesas address?

 drivers/soc/renesas/r8a7743-sysc.c  |  5 +----
 drivers/soc/renesas/r8a7745-sysc.c  |  5 +----
 drivers/soc/renesas/r8a7779-sysc.c  |  5 +----
 drivers/soc/renesas/r8a7790-sysc.c  |  5 +----
 drivers/soc/renesas/r8a7791-sysc.c  |  5 +----
 drivers/soc/renesas/r8a7792-sysc.c  |  5 +----
 drivers/soc/renesas/r8a7794-sysc.c  |  5 +----
 drivers/soc/renesas/r8a7795-sysc.c  |  5 +----
 drivers/soc/renesas/r8a7796-sysc.c  |  5 +----
 drivers/soc/renesas/r8a77970-sysc.c |  5 +----
 drivers/soc/renesas/r8a77995-sysc.c |  5 +----
 drivers/soc/renesas/rcar-sysc.h     |  5 +----
 drivers/soc/renesas/renesas-soc.c   | 10 +---------
 13 files changed, 13 insertions(+), 57 deletions(-)

diff --git a/drivers/soc/renesas/r8a7743-sysc.c b/drivers/soc/renesas/r8a7743-sysc.c
index 9583a327d90c..edf6436e879f 100644
--- a/drivers/soc/renesas/r8a7743-sysc.c
+++ b/drivers/soc/renesas/r8a7743-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas RZ/G1M System Controller
  *
  * Copyright (C) 2016 Cogent Embedded Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation; of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a7745-sysc.c b/drivers/soc/renesas/r8a7745-sysc.c
index d17887c08aa1..65dc6b09cc85 100644
--- a/drivers/soc/renesas/r8a7745-sysc.c
+++ b/drivers/soc/renesas/r8a7745-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas RZ/G1E System Controller
  *
  * Copyright (C) 2016 Cogent Embedded Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation; of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a7779-sysc.c b/drivers/soc/renesas/r8a7779-sysc.c
index 9e8e6b7faa04..517aa40fa6e6 100644
--- a/drivers/soc/renesas/r8a7779-sysc.c
+++ b/drivers/soc/renesas/r8a7779-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car H1 System Controller
  *
  * Copyright (C) 2016 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a7790-sysc.c b/drivers/soc/renesas/r8a7790-sysc.c
index 7a567ad0ff73..9b5a6bb62152 100644
--- a/drivers/soc/renesas/r8a7790-sysc.c
+++ b/drivers/soc/renesas/r8a7790-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car H2 System Controller
  *
  * Copyright (C) 2016 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a7791-sysc.c b/drivers/soc/renesas/r8a7791-sysc.c
index 03b9f41a34e6..acf545cdebfb 100644
--- a/drivers/soc/renesas/r8a7791-sysc.c
+++ b/drivers/soc/renesas/r8a7791-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car M2-W/N System Controller
  *
  * Copyright (C) 2016 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a7792-sysc.c b/drivers/soc/renesas/r8a7792-sysc.c
index ca7467d7b7ec..05b78525cc43 100644
--- a/drivers/soc/renesas/r8a7792-sysc.c
+++ b/drivers/soc/renesas/r8a7792-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car V2H (R8A7792) System Controller
  *
  * Copyright (C) 2016 Cogent Embedded Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a7794-sysc.c b/drivers/soc/renesas/r8a7794-sysc.c
index c4da2941e06c..0d42637fa662 100644
--- a/drivers/soc/renesas/r8a7794-sysc.c
+++ b/drivers/soc/renesas/r8a7794-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car E2 System Controller
  *
  * Copyright (C) 2016 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a7795-sysc.c b/drivers/soc/renesas/r8a7795-sysc.c
index 7412666187b3..cda27a67de98 100644
--- a/drivers/soc/renesas/r8a7795-sysc.c
+++ b/drivers/soc/renesas/r8a7795-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car H3 System Controller
  *
  * Copyright (C) 2016-2017 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a7796-sysc.c b/drivers/soc/renesas/r8a7796-sysc.c
index f700c842b9e1..1b06f868b6e8 100644
--- a/drivers/soc/renesas/r8a7796-sysc.c
+++ b/drivers/soc/renesas/r8a7796-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car M3-W System Controller
  *
  * Copyright (C) 2016 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a77970-sysc.c b/drivers/soc/renesas/r8a77970-sysc.c
index caf894f193ed..35b30d6a8958 100644
--- a/drivers/soc/renesas/r8a77970-sysc.c
+++ b/drivers/soc/renesas/r8a77970-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car V3M System Controller
  *
  * Copyright (C) 2017 Cogent Embedded Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/r8a77995-sysc.c b/drivers/soc/renesas/r8a77995-sysc.c
index 1b2ef415bbe1..6243aaaf60fb 100644
--- a/drivers/soc/renesas/r8a77995-sysc.c
+++ b/drivers/soc/renesas/r8a77995-sysc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas R-Car D3 System Controller
  *
  * Copyright (C) 2017 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 
 #include <linux/bug.h>
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index a22e7cf25e30..a3d495229784 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Renesas R-Car System Controller
  *
  * Copyright (C) 2016 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
  */
 #ifndef __SOC_RENESAS_RCAR_SYSC_H__
 #define __SOC_RENESAS_RCAR_SYSC_H__
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index ce19b2732433..9e244206d2dd 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas SoC Identification
  *
  * Copyright (C) 2014-2016 Glider bvba
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; version 2 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/io.h>
-- 
2.11.0

