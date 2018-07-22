Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECA6C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 11:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DBA12086A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 11:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBA12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeGVMuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 08:50:12 -0400
Received: from smtprz14.163.net ([106.3.154.247]:59361 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727778AbeGVMuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 08:50:12 -0400
Received: from antispam2.tom.com (unknown [172.25.16.56])
        by freemail02.tom.com (Postfix) with ESMTP id 6A9ADB00D3E
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 17:58:41 +0800 (CST)
Received: from antispam2.tom.com (antispam2.tom.com [127.0.0.1])
        by antispam2.tom.com (Postfix) with ESMTP id 881EB812C1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 17:58:40 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam2.tom.com
Received: from antispam2.tom.com ([127.0.0.1])
        by antispam2.tom.com (antispam2.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Sw2h_yIaoYyA for <linux-kernel@vger.kernel.org>;
        Sun, 22 Jul 2018 17:58:37 +0800 (CST)
Received: from localhost (unknown [222.209.18.46])
        by antispam2.tom.com (Postfix) with ESMTPA id 499BF8121A;
        Sun, 22 Jul 2018 17:58:37 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     afd@ti.com
Cc:     pali.rohar@gmail.com, sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuxiang_1999@126.com,
        Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] power: supply: bq27xxx: Update comments
Date:   Sun, 22 Jul 2018 17:58:24 +0800
Message-Id: <1532253504-17563-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The URL of bq27441-g1 and bq27426 are missing and bq27520-g4 is duplicated.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 drivers/power/supply/bq27xxx_battery.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index d44ed8e..f022e1b 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -26,7 +26,6 @@
  * http://www.ti.com/product/bq27510-g1
  * http://www.ti.com/product/bq27510-g2
  * http://www.ti.com/product/bq27510-g3
- * http://www.ti.com/product/bq27520-g4
  * http://www.ti.com/product/bq27520-g1
  * http://www.ti.com/product/bq27520-g2
  * http://www.ti.com/product/bq27520-g3
@@ -40,7 +39,9 @@
  * http://www.ti.com/product/bq27545-g1
  * http://www.ti.com/product/bq27421-g1
  * http://www.ti.com/product/bq27425-g1
+ * http://www.ti.com/product/bq27426
  * http://www.ti.com/product/bq27411-g1
+ * http://www.ti.com/product/bq27441-g1
  * http://www.ti.com/product/bq27621-g1
  */
 
-- 
1.9.1

