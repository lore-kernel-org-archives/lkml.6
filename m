Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F182C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB91220C10
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JtU9Mm7s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB91220C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390865AbeGKXs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 19:48:58 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33336 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390725AbeGKXs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 19:48:57 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6BNgFdx111267;
        Wed, 11 Jul 2018 18:42:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531352535;
        bh=52WYwM0bies9sufDnWf57+pMeIsIgAAztEw5jLhvQqs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JtU9Mm7sgnFl+b5mBlEwXYFPwAEVodJewGYOtUfnCkMRYhbbH5A4P1SlETKYZBjXE
         cX9+05GHs+8JZs/ORmauJH9oUd1Btz/aqBtyiD412RUQ6fahiWD26Dr3lyLOFmEfY3
         DfE/2BYaqQwAKgeLau6yyviT9gvmefkzWwJCXBjI=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6BNgFlu022478;
        Wed, 11 Jul 2018 18:42:15 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 11
 Jul 2018 18:42:15 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 11 Jul 2018 18:42:15 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6BNgFJL020768;
        Wed, 11 Jul 2018 18:42:15 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w6BNgFx17977;
        Wed, 11 Jul 2018 18:42:15 -0500 (CDT)
From:   Suman Anna <s-anna@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/2] mailbox/omap: switch to SPDX license identifier
Date:   Wed, 11 Jul 2018 18:42:11 -0500
Message-ID: <20180711234212.7756-2-s-anna@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180711234212.7756-1-s-anna@ti.com>
References: <20180711234212.7756-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the appropriate SPDX license identifier in the OMAP Mailbox
driver source files and drop the previous boilerplate license text.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 10 +---------
 include/linux/omap-mailbox.h   |  5 +----
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index e1e2c085e68e..97c7d9b7f46f 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * OMAP mailbox driver
  *
@@ -6,15 +7,6 @@
  *
  * Contact: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
  *          Suman Anna <s-anna@ti.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
  */
 
 #include <linux/interrupt.h>
diff --git a/include/linux/omap-mailbox.h b/include/linux/omap-mailbox.h
index c726bd833761..6dbcd2da0332 100644
--- a/include/linux/omap-mailbox.h
+++ b/include/linux/omap-mailbox.h
@@ -1,9 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * omap-mailbox: interprocessor communication module for OMAP
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #ifndef OMAP_MAILBOX_H
-- 
2.17.1

