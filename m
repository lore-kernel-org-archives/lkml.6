Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF53ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF172083A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF172083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbeIRHQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:16:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34531 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbeIRHQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:16:00 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C23DFBC3B122D;
        Tue, 18 Sep 2018 09:45:49 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.399.0; Tue, 18 Sep 2018
 09:45:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH bpf-next] samples/bpf: remove duplicated includes
Date:   Tue, 18 Sep 2018 09:45:34 +0800
Message-ID: <20180918014534.26128-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicated includes.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 samples/bpf/bpf_load.c                            | 1 -
 samples/bpf/sampleip_user.c                       | 1 -
 samples/bpf/test_current_task_under_cgroup_user.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
index 904e775..e6d7e0f 100644
--- a/samples/bpf/bpf_load.c
+++ b/samples/bpf/bpf_load.c
@@ -16,7 +16,6 @@
 #include <linux/netlink.h>
 #include <linux/rtnetlink.h>
 #include <linux/types.h>
-#include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/syscall.h>
 #include <sys/ioctl.h>
diff --git a/samples/bpf/sampleip_user.c b/samples/bpf/sampleip_user.c
index 60c2b73..216c7ec 100644
--- a/samples/bpf/sampleip_user.c
+++ b/samples/bpf/sampleip_user.c
@@ -9,7 +9,6 @@
  */
 #include <stdio.h>
 #include <stdlib.h>
-#include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
 #include <signal.h>
diff --git a/samples/bpf/test_current_task_under_cgroup_user.c b/samples/bpf/test_current_task_under_cgroup_user.c
index 4be4874..2259f99 100644
--- a/samples/bpf/test_current_task_under_cgroup_user.c
+++ b/samples/bpf/test_current_task_under_cgroup_user.c
@@ -11,7 +11,6 @@
 #include <unistd.h>
 #include <bpf/bpf.h>
 #include "bpf_load.h"
-#include <linux/bpf.h>
 #include "cgroup_helpers.h"
 
 #define CGROUP_PATH		"/my-cgroup"
-- 
2.7.0


