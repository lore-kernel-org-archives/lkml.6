Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E30C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D4D2086E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 06:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22D4D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbeLIGaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 01:30:20 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39538 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbeLIGaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 01:30:19 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0334C21F59122;
        Sun,  9 Dec 2018 14:30:17 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Sun, 9 Dec 2018
 14:30:07 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <akpm@linux-foundation.org>, <mhocko@suse.com>,
        <ebiederm@xmission.com>, <riel@surriel.com>,
        <keescook@chromium.org>, <guro@fb.com>,
        <marcos.souza.org@gmail.com>, <sfr@canb.auug.org.au>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] fork: remove duplicated include from fork.c
Date:   Sun, 9 Dec 2018 14:29:52 +0800
Message-ID: <20181209062952.17736-1-yuehaibing@huawei.com>
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
 kernel/fork.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index aaed316..ac871e9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -77,7 +77,6 @@
 #include <linux/blkdev.h>
 #include <linux/fs_struct.h>
 #include <linux/magic.h>
-#include <linux/sched/mm.h>
 #include <linux/perf_event.h>
 #include <linux/posix-timers.h>
 #include <linux/user-return-notifier.h>
-- 
2.7.0


