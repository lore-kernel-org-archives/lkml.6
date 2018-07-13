Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8615ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC2C2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABC2C2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbeGMPKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:10:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35776 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729670AbeGMPKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:10:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2E7CC207C8; Fri, 13 Jul 2018 16:55:12 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-27-161.w90-88.abo.wanadoo.fr [90.88.147.161])
        by mail.bootlin.com (Postfix) with ESMTPSA id F3497203EC;
        Fri, 13 Jul 2018 16:55:01 +0200 (CEST)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, maxime.chevallier@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, oferh@marvell.com, igall@marvell.com
Subject: [PATCH] crypto: inside-secure - switch to SPDX identifiers
Date:   Fri, 13 Jul 2018 16:51:37 +0200
Message-Id: <20180713145138.987-1-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the appropriate SPDX license identifiers and drop the license text.
This patch is only cosmetic.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/crypto/inside-secure/safexcel.c        | 5 +----
 drivers/crypto/inside-secure/safexcel.h        | 5 +----
 drivers/crypto/inside-secure/safexcel_cipher.c | 5 +----
 drivers/crypto/inside-secure/safexcel_hash.c   | 5 +----
 drivers/crypto/inside-secure/safexcel_ring.c   | 5 +----
 5 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 4e86f864a952..d34ee5097739 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017 Marvell
  *
  * Antoine Tenart <antoine.tenart@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/crypto/inside-secure/safexcel.h b/drivers/crypto/inside-secure/safexcel.h
index 8b3ee9b59f53..4121479a3b32 100644
--- a/drivers/crypto/inside-secure/safexcel.h
+++ b/drivers/crypto/inside-secure/safexcel.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (C) 2017 Marvell
  *
  * Antoine Tenart <antoine.tenart@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __SAFEXCEL_H__
diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
index 6bb60fda2043..f20bc14e3454 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017 Marvell
  *
  * Antoine Tenart <antoine.tenart@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/device.h>
diff --git a/drivers/crypto/inside-secure/safexcel_hash.c b/drivers/crypto/inside-secure/safexcel_hash.c
index c77b0e1655a8..7ddd540fc1fd 100644
--- a/drivers/crypto/inside-secure/safexcel_hash.c
+++ b/drivers/crypto/inside-secure/safexcel_hash.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017 Marvell
  *
  * Antoine Tenart <antoine.tenart@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <crypto/hmac.h>
diff --git a/drivers/crypto/inside-secure/safexcel_ring.c b/drivers/crypto/inside-secure/safexcel_ring.c
index c9d2a8716b5b..471355a9c5b8 100644
--- a/drivers/crypto/inside-secure/safexcel_ring.c
+++ b/drivers/crypto/inside-secure/safexcel_ring.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017 Marvell
  *
  * Antoine Tenart <antoine.tenart@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/dma-mapping.h>
-- 
2.17.1

