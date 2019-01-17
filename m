Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68489C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E5720657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 07:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfAQH0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 02:26:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38978 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727080AbfAQH0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 02:26:06 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AC39E42EC1010C8EEA62;
        Thu, 17 Jan 2019 15:26:03 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.408.0; Thu, 17 Jan 2019
 15:25:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] perf: remove duplicated include from perf_event.h
Date:   Thu, 17 Jan 2019 15:25:04 +0800
Message-ID: <20190117072504.14428-1-yuehaibing@huawei.com>
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
 include/linux/perf_event.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1d5c551..19baf4a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -53,7 +53,6 @@ struct perf_guest_info_callbacks {
 #include <linux/atomic.h>
 #include <linux/sysfs.h>
 #include <linux/perf_regs.h>
-#include <linux/workqueue.h>
 #include <linux/cgroup.h>
 #include <asm/local.h>
 
-- 
2.7.0


