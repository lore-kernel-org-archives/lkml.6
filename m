Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62501C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 03:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0937023C32
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 03:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0937023C32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965233AbeF2Ddm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 23:33:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9137 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932140AbeF2Ddl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 23:33:41 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8FF0AD8E3989;
        Fri, 29 Jun 2018 11:33:28 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.382.0; Fri, 29 Jun 2018
 11:33:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <keescook@chromium.org>,
        <mawilcox@microsoft.com>, <kstewart@linuxfoundation.org>,
        <aryabinin@virtuozzo.com>, <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] lib/string.c: fix a typo in comment: 'iff' -->'if'
Date:   Fri, 29 Jun 2018 11:33:03 +0800
Message-ID: <20180629033303.13012-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 lib/string.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/string.c b/lib/string.c
index 2c0900a..23ed944 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -609,7 +609,7 @@ EXPORT_SYMBOL(strsep);
  * @s1: one string
  * @s2: another string
  *
- * This routine returns true iff two strings are equal, treating both
+ * This routine returns true if two strings are equal, treating both
  * NUL and newline-then-NUL as equivalent string terminations.  It's
  * geared for use with sysfs input strings, which generally terminate
  * with newlines but are compared against values without newlines.
-- 
2.7.0


