Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA52ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229092084A
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 11:29:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229092084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbeGNLsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 07:48:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51856 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbeGNLsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 07:48:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D22AA207E8; Sat, 14 Jul 2018 13:29:36 +0200 (CEST)
Received: from localhost.localdomain (ABordeaux-654-1-198-104.w90-55.abo.wanadoo.fr [90.55.201.104])
        by mail.bootlin.com (Postfix) with ESMTPSA id 808A5203EC;
        Sat, 14 Jul 2018 13:29:36 +0200 (CEST)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v2 1/5] net: mvpp2: switch to SPDX identifiers
Date:   Sat, 14 Jul 2018 13:29:24 +0200
Message-Id: <20180714112928.14246-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180714112928.14246-1-maxime.chevallier@bootlin.com>
References: <20180714112928.14246-1-maxime.chevallier@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>

Use the appropriate SPDX license identifiers and drop the license text.
This patch is only cosmetic.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h      | 5 +----
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c  | 5 +----
 drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h  | 5 +----
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 5 +----
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c  | 5 +----
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h  | 5 +----
 6 files changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 749d9720bf5e..3e470d6fcf64 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Definitions for Marvell PPv2 network controller for Armada 375 SoC.
  *
  * Copyright (C) 2014 Marvell
  *
  * Marcin Wojtas <mw@semihalf.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #ifndef _MVPP2_H_
 #define _MVPP2_H_
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
index 723d0ba6f78d..125466c66f1a 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * RSS and Classifier helpers for Marvell PPv2 Network Controller
  *
  * Copyright (C) 2014 Marvell
  *
  * Marcin Wojtas <mw@semihalf.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include "mvpp2.h"
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
index 151d791a91b6..e159489a20ea 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * RSS and Classifier definitions for Marvell PPv2 Network Controller
  *
  * Copyright (C) 2014 Marvell
  *
  * Marcin Wojtas <mw@semihalf.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef _MVPP2_CLS_H_
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 2283be12d700..2d690b082b89 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for Marvell PPv2 network controller for Armada 375 SoC.
  *
  * Copyright (C) 2014 Marvell
  *
  * Marcin Wojtas <mw@semihalf.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/acpi.h>
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
index acf9f78d5f80..2a8d25139a8f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Header Parser helpers for Marvell PPv2 Network Controller
  *
  * Copyright (C) 2014 Marvell
  *
  * Marcin Wojtas <mw@semihalf.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h
index 368e90b54477..eb81db1a301f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Header Parser definitions for Marvell PPv2 Network Controller
  *
  * Copyright (C) 2014 Marvell
  *
  * Marcin Wojtas <mw@semihalf.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #ifndef _MVPP2_PRS_H_
 #define _MVPP2_PRS_H_
-- 
2.11.0

