Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B48BC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEAD22081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEAD22081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbeLIGZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 01:25:22 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:38472 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726066AbeLIGZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 01:25:22 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E0E65DF9146C1;
        Sun,  9 Dec 2018 14:25:18 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Sun, 9 Dec 2018
 14:25:11 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-audit@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] audit: remove duplicated include from audit.c
Date:   Sun, 9 Dec 2018 14:25:02 +0800
Message-ID: <20181209062502.16308-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 kernel/audit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index a0a4544..632d360 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -60,7 +60,6 @@
 #include <linux/mutex.h>
 #include <linux/gfp.h>
 #include <linux/pid.h>
-#include <linux/slab.h>
 
 #include <linux/audit.h>
 
-- 
2.7.0


