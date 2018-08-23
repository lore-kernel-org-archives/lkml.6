Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE20FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEB22075B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 13:35:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEB22075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbeHWRFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 13:05:01 -0400
Received: from sauhun.de ([88.99.104.3]:59960 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730151AbeHWRFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 13:05:00 -0400
Received: from localhost (p54B337EB.dip0.t-ipconnect.de [84.179.55.235])
        by pokefinder.org (Postfix) with ESMTPSA id EFEE830146B;
        Thu, 23 Aug 2018 15:35:11 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dmaengine: use SPDX identifier for Renesas drivers
Date:   Thu, 23 Aug 2018 15:34:54 +0200
Message-Id: <20180823133456.4748-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180823133456.4748-1-wsa+renesas@sang-engineering.com>
References: <20180823133456.4748-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since V1: s/GPL-2.0-or-later/GPL-2.0+/

 drivers/dma/nbpfaxi.c          | 5 +----
 drivers/dma/sh/shdma-arm.h     | 5 +----
 drivers/dma/sh/shdma-base.c    | 5 +----
 drivers/dma/sh/shdma-of.c      | 5 +----
 drivers/dma/sh/shdma-r8a73a4.c | 5 +----
 drivers/dma/sh/shdma.h         | 6 +-----
 drivers/dma/sh/shdmac.c        | 6 +-----
 drivers/dma/sh/sudmac.c        | 5 +----
 drivers/dma/sh/usb-dmac.c      | 5 +----
 9 files changed, 9 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 8c7b2e8703da..38d251b198b8 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2013-2014 Renesas Electronics Europe Ltd.
  * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  */
 
 #include <linux/bitmap.h>
diff --git a/drivers/dma/sh/shdma-arm.h b/drivers/dma/sh/shdma-arm.h
index a1b0ef45d6a2..7459f9a13b5b 100644
--- a/drivers/dma/sh/shdma-arm.h
+++ b/drivers/dma/sh/shdma-arm.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Renesas SuperH DMA Engine support
  *
  * Copyright (C) 2013 Renesas Electronics, Inc.
- *
- * This is free software; you can redistribute it and/or modify it under the
- * terms of version 2 the GNU General Public License as published by the Free
- * Software Foundation.
  */
 
 #ifndef SHDMA_ARM_H
diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 6b5626e299b2..c51de498b5b4 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Dmaengine driver base library for DMA controllers, found on SH-based SoCs
  *
@@ -7,10 +8,6 @@
  * Copyright (C) 2009 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
  * Copyright (C) 2009 Renesas Solutions, Inc. All rights reserved.
  * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
- *
- * This is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/dma/sh/shdma-of.c b/drivers/dma/sh/shdma-of.c
index f999f9b0d314..be89dd894328 100644
--- a/drivers/dma/sh/shdma-of.c
+++ b/drivers/dma/sh/shdma-of.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SHDMA Device Tree glue
  *
  * Copyright (C) 2013 Renesas Electronics Inc.
  * Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- *
- * This is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  */
 
 #include <linux/dmaengine.h>
diff --git a/drivers/dma/sh/shdma-r8a73a4.c b/drivers/dma/sh/shdma-r8a73a4.c
index 96ea3828c3eb..ddc9a3578353 100644
--- a/drivers/dma/sh/shdma-r8a73a4.c
+++ b/drivers/dma/sh/shdma-r8a73a4.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas SuperH DMA Engine support for r8a73a4 (APE6) SoCs
  *
  * Copyright (C) 2013 Renesas Electronics, Inc.
- *
- * This is free software; you can redistribute it and/or modify it under the
- * terms of version 2 the GNU General Public License as published by the Free
- * Software Foundation.
  */
 #include <linux/sh_dma.h>
 
diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
index 2c0a969adc9f..bfb69909bd19 100644
--- a/drivers/dma/sh/shdma.h
+++ b/drivers/dma/sh/shdma.h
@@ -1,14 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Renesas SuperH DMA Engine support
  *
  * Copyright (C) 2009 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
  * Copyright (C) 2009 Renesas Solutions, Inc. All rights reserved.
  *
- * This is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  */
 #ifndef __DMA_SHDMA_H
 #define __DMA_SHDMA_H
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 04a74e0a95b7..7971ea275387 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Renesas SuperH DMA Engine support
  *
@@ -8,11 +9,6 @@
  * Copyright (C) 2009 Renesas Solutions, Inc. All rights reserved.
  * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
  *
- * This is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  * - DMA of SuperH does not have Hardware DMA chain mode.
  * - MAX DMA size is 16MB.
  *
diff --git a/drivers/dma/sh/sudmac.c b/drivers/dma/sh/sudmac.c
index 69b9564dc9d9..30cc3553cb8b 100644
--- a/drivers/dma/sh/sudmac.c
+++ b/drivers/dma/sh/sudmac.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas SUDMAC support
  *
@@ -8,10 +9,6 @@
  * Copyright (C) 2009 Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
  * Copyright (C) 2009 Renesas Solutions, Inc. All rights reserved.
  * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
- *
- * This is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  */
 
 #include <linux/dmaengine.h>
diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 1bb1a8e09025..7f7184c3cf95 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas USB DMA Controller Driver
  *
@@ -6,10 +7,6 @@
  * based on rcar-dmac.c
  * Copyright (C) 2014 Renesas Electronics Inc.
  * Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
- *
- * This is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
  */
 
 #include <linux/delay.h>
-- 
2.11.0

