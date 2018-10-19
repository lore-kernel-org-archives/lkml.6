Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2583BECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CEF2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:00:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CEF2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeJTBHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:07:00 -0400
Received: from mail115-95.sinamail.sina.com.cn ([218.30.115.95]:56994 "HELO
        mail115-95.sinamail.sina.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1727885AbeJTBHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:07:00 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Oct 2018 21:07:00 EDT
Received: from unknown (HELO localhost.localdomain)([139.204.56.122])
        by sina.com with ESMTP
        id 5BCA0A080000EF7D; Fri, 20 Oct 2018 00:45:03 +0800 (CST)
X-Sender: penghao122@sina.com.cn
X-Auth-ID: penghao122@sina.com.cn
X-SMAIL-MID: 601841132275
From:   Peng Hao <penghao122@sina.com.cn>
To:     mingo@redhat.com, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  sched/fair : modify comment of fbq_type description
Date:   Fri, 19 Oct 2018 12:44:54 -0400
Message-Id: <1539967494-12493-1-git-send-email-penghao122@sina.com.cn>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peng Hao <peng.hao2@zte.com.cn>

for type 'all', the comment 'there is no distinction' is vague.
make it clearer.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f808ddf..3a0543f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8304,7 +8304,7 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		 * We classify groups/runqueues into three groups:
 		 *  - regular: there are !numa tasks
 		 *  - remote:  there are numa tasks that run on the 'wrong' node
-		 *  - all:     there is no distinction
+		 *  - all:     there are numa tasks that run on the 'right' node
 		 *
 		 * In order to avoid migrating ideally placed numa tasks,
 		 * ignore those when there's better options.
-- 
1.8.3.1


