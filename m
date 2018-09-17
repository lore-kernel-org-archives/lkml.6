Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3C9ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825292088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825292088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbeIQSkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:40:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52440 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726865AbeIQSkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:40:51 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DAB7556A72109;
        Mon, 17 Sep 2018 21:13:29 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Mon, 17 Sep 2018
 21:13:24 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <vbabka@suse.cz>, <jack@suse.cz>, <rppt@linux.vnet.ibm.com>,
        <dan.j.williams@intel.com>, <shakeelb@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] mm: swap: remove duplicated include from swap.c
Date:   Mon, 17 Sep 2018 21:13:08 +0800
Message-ID: <20180917131308.16420-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated include linux/memremap.h

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 mm/swap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 26fc9b5..87a54c8 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -29,7 +29,6 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/backing-dev.h>
-#include <linux/memremap.h>
 #include <linux/memcontrol.h>
 #include <linux/gfp.h>
 #include <linux/uio.h>
-- 
2.7.0


