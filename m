Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E42C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CE5217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfAYC7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:59:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2753 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfAYC7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:59:49 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8923CC885235640EC850;
        Fri, 25 Jan 2019 10:59:46 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Fri, 25 Jan 2019
 10:59:40 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <nikolay@cumulusnetworks.com>,
        <roopa@cumulusnetworks.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <bridge@lists.linux-foundation.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] bridge: remove duplicated include from br_multicast.c
Date:   Fri, 25 Jan 2019 10:59:09 +0800
Message-ID: <20190125025909.11924-1-yuehaibing@huawei.com>
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
 net/bridge/br_multicast.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 2c46c7a..780757b 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -35,7 +35,6 @@
 #include <net/mld.h>
 #include <net/ip6_checksum.h>
 #include <net/addrconf.h>
-#include <net/ipv6.h>
 #endif
 
 #include "br_private.h"
-- 
2.7.0


