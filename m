Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579A7C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAD72082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v40JcD12"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAD72082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbeLHQBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:01:21 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57582 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeLHQBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:01:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB8G15x2091133;
        Sat, 8 Dec 2018 10:01:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544284865;
        bh=sY2sV7/chXYlVUK8DwH7LJ50V9BiGNC+4KDwZRLqBkM=;
        h=From:To:CC:Subject:Date;
        b=v40JcD120HBJoHIwM6aslcLxNFuJMcf158n9ePkeTbAe9ZQUBLfM5WnF12uLJ8vY5
         InWznLm9weEZRKDmCJLnaUr6nwEEYuR3dE4zxdWIEy5Y7P94qsifvcYpNK3YwDivzL
         DcboovWf3+uJwrCDm3wpLoVpPSCh/4NHk+Mh29vo=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB8G15Sp118681
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 8 Dec 2018 10:01:05 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sat, 8
 Dec 2018 10:01:04 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sat, 8 Dec 2018 10:01:04 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB8G14AL027014;
        Sat, 8 Dec 2018 10:01:04 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Kevin Hilman <khilman@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] PM / AVS: SmartReflex: Switch to SPDX Licence ID
Date:   Sat, 8 Dec 2018 10:00:42 -0600
Message-ID: <20181208160042.32587-1-nm@ti.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec057f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up licensing to be inline with Linux conventions.

Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/power/avs/smartreflex.c   | 5 +----
 include/linux/power/smartreflex.h | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
index 536d99dc0008..82fda4d050ce 100644
--- a/drivers/power/avs/smartreflex.c
+++ b/drivers/power/avs/smartreflex.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * OMAP SmartReflex Voltage Control
  *
@@ -11,10 +12,6 @@
  *
  * Copyright (C) 2007 Texas Instruments, Inc.
  * Lesly A M <x0080970@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/module.h>
diff --git a/include/linux/power/smartreflex.h b/include/linux/power/smartreflex.h
index a586976f4784..d0b37e937037 100644
--- a/include/linux/power/smartreflex.h
+++ b/include/linux/power/smartreflex.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * OMAP Smartreflex Defines and Routines
  *
@@ -11,10 +12,6 @@
  *
  * Copyright (C) 2007 Texas Instruments, Inc.
  * Lesly A M <x0080970@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef __POWER_SMARTREFLEX_H
-- 
2.19.0.271.gfe8321ec057f

