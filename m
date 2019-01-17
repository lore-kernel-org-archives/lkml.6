Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9D9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D699920657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfAQM5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:57:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2187 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbfAQM5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:57:38 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 13B2AA33480F568096C7;
        Thu, 17 Jan 2019 20:57:36 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Thu, 17 Jan 2019
 20:57:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <jon.maloy@ericsson.com>,
        <ying.xue@windriver.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <tipc-discussion@lists.sourceforge.net>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] tipc: remove unneeded semicolon in trace.c
Date:   Thu, 17 Jan 2019 20:57:08 +0800
Message-ID: <20190117125708.14952-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unneeded semicolon

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/tipc/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/trace.c b/net/tipc/trace.c
index 9648238..265f6a2 100644
--- a/net/tipc/trace.c
+++ b/net/tipc/trace.c
@@ -111,7 +111,7 @@ int tipc_skb_dump(struct sk_buff *skb, bool more, char *buf)
 			break;
 		default:
 			break;
-		};
+		}
 		i += scnprintf(buf + i, sz - i, " | %u",
 			       msg_src_droppable(hdr));
 		i += scnprintf(buf + i, sz - i, " %u",
@@ -122,7 +122,7 @@ int tipc_skb_dump(struct sk_buff *skb, bool more, char *buf)
 	default:
 		/* need more? */
 		break;
-	};
+	}
 
 	i += scnprintf(buf + i, sz - i, "\n");
 	if (!more)
-- 
2.7.0


