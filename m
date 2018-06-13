Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 75CC3C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 369BC208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369BC208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964874AbeFMVKs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:10:48 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:54991 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935926AbeFMVJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:09:17 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Wed, 13 Jun 2018 14:09:11 -0700
Received: from sc2-haas01-esx0118.eng.vmware.com (sc2-haas01-esx0118.eng.vmware.com [10.172.44.118])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 0435C40982;
        Wed, 13 Jun 2018 14:09:16 -0700 (PDT)
From:   Nadav Amit <namit@vmware.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Xavier Deguillard <xdeguillard@vmware.com>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Nadav Amit <namit@vmware.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: [PATCH v2 6/7] vmw_balloon: update copyright message
Date:   Wed, 13 Jun 2018 06:54:11 -0700
Message-ID: <20180613135412.81660-7-namit@vmware.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180613135412.81660-1-namit@vmware.com>
References: <20180613135412.81660-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: namit@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing the paragraph about writing to the Free Software Foundation's
mailing address from the sample GPL notice according to checkpatch
request.

In addition, updating the year and adding a license tag.

Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
Signed-off-by: Nadav Amit <nadav.amit@gmail.com>
---
 drivers/misc/vmw_balloon.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
index 400a1ccefc8e..b982059ce7b7 100644
--- a/drivers/misc/vmw_balloon.c
+++ b/drivers/misc/vmw_balloon.c
@@ -1,7 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * VMware Balloon driver.
  *
- * Copyright (C) 2000-2014, VMware, Inc. All Rights Reserved.
+ * Copyright (C) 2000-2018, VMware, Inc. All Rights Reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -13,10 +14,6 @@
  * NON INFRINGEMENT.  See the GNU General Public License for more
  * details.
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Maintained by:	Xavier Deguillard <xdeguillard@vmware.com>
  *			Philip Moltmann <moltmann@vmware.com>
  */
-- 
2.17.0

