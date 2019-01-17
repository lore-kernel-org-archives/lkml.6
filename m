Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6698BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FF320657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbfAQHaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:30:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725952AbfAQHaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:30:15 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E63A58EA5B97F5CBDACF;
        Thu, 17 Jan 2019 15:30:12 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Thu, 17 Jan 2019
 15:30:07 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <mst@redhat.com>, <jasowang@redhat.com>,
        <john.fastabend@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ptr_ring: remove duplicated include from ptr_ring.h
Date:   Thu, 17 Jan 2019 15:28:57 +0800
Message-ID: <20190117072857.13728-1-yuehaibing@huawei.com>
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
 include/linux/ptr_ring.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
index 186cd8e..8da46ac 100644
--- a/include/linux/ptr_ring.h
+++ b/include/linux/ptr_ring.h
@@ -26,7 +26,6 @@
 #include <linux/cache.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
-#include <linux/cache.h>
 #include <linux/slab.h>
 #include <asm/errno.h>
 #endif
-- 
2.7.0


