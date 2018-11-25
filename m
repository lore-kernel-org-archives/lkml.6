Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A4EC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2599320865
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2599320865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbeKYUVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 15:21:41 -0500
Received: from smtprz15.163.net ([106.3.154.248]:42196 "EHLO smtp.tom.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726859AbeKYUVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 15:21:40 -0500
Received: from antispam2.tom.com (unknown [172.25.16.56])
        by freemail02.tom.com (Postfix) with ESMTP id E5681B00D87
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 17:30:49 +0800 (CST)
Received: from antispam2.tom.com (antispam2.tom.com [127.0.0.1])
        by antispam2.tom.com (Postfix) with ESMTP id E336C81519
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 17:30:49 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam2.tom.com
Received: from antispam2.tom.com ([127.0.0.1])
        by antispam2.tom.com (antispam2.tom.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 07G7lAKRyIf6 for <linux-kernel@vger.kernel.org>;
        Sun, 25 Nov 2018 17:30:49 +0800 (CST)
Received: from localhost (unknown [222.209.17.68])
        by antispam2.tom.com (Postfix) with ESMTPA id AFB5D8146C;
        Sun, 25 Nov 2018 17:30:48 +0800 (CST)
From:   Liu Xiang <liu.xiang6@zte.com.cn>
To:     linux-arch@vger.kernel.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org, liuxiang_1999@126.com,
        Liu Xiang <liu.xiang6@zte.com.cn>
Subject: [PATCH] asm-generic: Add spaces around & operator
Date:   Sun, 25 Nov 2018 17:30:45 +0800
Message-Id: <1543138245-3673-1-git-send-email-liu.xiang6@zte.com.cn>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '&' to follow kernel coding style.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
---
 include/asm-generic/fixmap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 827e4d3..d6e8da3 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -18,7 +18,7 @@
 #include <linux/bug.h>
 
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
-#define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
+#define __virt_to_fix(x)	((FIXADDR_TOP - ((x) & PAGE_MASK)) >> PAGE_SHIFT)
 
 #ifndef __ASSEMBLY__
 /*
-- 
1.9.1

