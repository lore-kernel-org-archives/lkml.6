Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E237C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5254C20851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfAQIq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:46:59 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:47838 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725884AbfAQIq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:46:59 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 68E9B7B62F26FB58CD9D;
        Thu, 17 Jan 2019 16:46:57 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Thu, 17 Jan 2019
 16:46:51 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jaharkes@cs.cmu.edu>, <coda@cs.cmu.edu>
CC:     <linux-kernel@vger.kernel.org>, <codalist@coda.cs.cmu.edu>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] fs/coda: remove duplicated include from psdev.c
Date:   Thu, 17 Jan 2019 15:40:04 +0800
Message-ID: <20190117074004.14508-1-yuehaibing@huawei.com>
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
 fs/coda/psdev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
index c5234c2..7068618 100644
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -39,14 +39,11 @@
 #include <linux/device.h>
 #include <linux/pid_namespace.h>
 #include <asm/io.h>
-#include <linux/poll.h>
 #include <linux/uaccess.h>
-
 #include <linux/coda.h>
 #include <linux/coda_psdev.h>
 
 #include "coda_linux.h"
-
 #include "coda_int.h"
 
 /* statistics */
-- 
2.7.0


