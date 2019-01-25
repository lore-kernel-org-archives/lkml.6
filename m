Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC246C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FE7218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfAYCrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:47:17 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2669 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726107AbfAYCrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:47:17 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EFAF96ECD5FDF2D6CC60;
        Fri, 25 Jan 2019 10:47:14 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Fri, 25 Jan 2019
 10:47:08 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <netdev@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] selftests: bpf: remove duplicated include
Date:   Fri, 25 Jan 2019 10:46:34 +0800
Message-ID: <20190125024634.14580-1-yuehaibing@huawei.com>
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
 tools/testing/selftests/bpf/test_flow_dissector.c | 2 --
 tools/testing/selftests/bpf/test_maps.c           | 1 -
 tools/testing/selftests/bpf/test_sockmap.c        | 1 -
 3 files changed, 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_flow_dissector.c b/tools/testing/selftests/bpf/test_flow_dissector.c
index 12b784a..01f0c63 100644
--- a/tools/testing/selftests/bpf/test_flow_dissector.c
+++ b/tools/testing/selftests/bpf/test_flow_dissector.c
@@ -16,7 +16,6 @@
 #include <errno.h>
 #include <linux/if_packet.h>
 #include <linux/if_ether.h>
-#include <linux/if_packet.h>
 #include <linux/ipv6.h>
 #include <netinet/ip.h>
 #include <netinet/in.h>
@@ -25,7 +24,6 @@
 #include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index e2b9eee..1dfef77 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -633,7 +633,6 @@ static void test_stackmap(int task, void *data)
 	close(fd);
 }
 
-#include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <arpa/inet.h>
 #include <sys/select.h>
diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index e85a771..3845144 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -10,7 +10,6 @@
 #include <unistd.h>
 #include <string.h>
 #include <errno.h>
-#include <sys/ioctl.h>
 #include <stdbool.h>
 #include <signal.h>
 #include <fcntl.h>
-- 
2.7.0


