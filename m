Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448F3C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 09:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0119A2081D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 09:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0119A2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeLAUkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 15:40:11 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:55384 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbeLAUkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 15:40:11 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 2E297E1EBEAEC81378C5;
        Sat,  1 Dec 2018 17:28:04 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB19S1OE076430;
        Sat, 1 Dec 2018 17:28:01 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from LIN-A6CB96A0603.zte.intra ([10.90.106.118])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120117284767-14118445 ;
          Sat, 1 Dec 2018 17:28:47 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH] sched/fair: Fix typos
Date:   Sat, 1 Dec 2018 17:27:39 +0800
Message-Id: <20181201092739.28450-1-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-01 17:28:47,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-01 17:27:41
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse01.zte.com.cn wB19S1OE076430
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a few typos detected by the checkpatch script:
WARNING: 'intialized' may be misspelled - perhaps 'initialized'?
WARNING: 'Substract' may be misspelled - perhaps 'Subtract'?

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: linux-kernel@vger.kernel.org
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f19aa66f9b15..dbcb0dd7332e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -703,9 +703,9 @@ void init=5Fentity=5Frunnable=5Faverage(struct sched=5F=
entity *se)
 	memset(sa, 0, sizeof(*sa));
=20
 	/*
-	 * Tasks are intialized with full load to be seen as heavy tasks until
+	 * Tasks are initialized with full load to be seen as heavy tasks until
 	 * they get a chance to stabilize to their real load level.
-	 * Group entities are intialized with zero load to reflect the fact that
+	 * Group entities are initialized with zero load to reflect the fact that
 	 * nothing has been attached to the task group yet.
 	 */
 	if (entity=5Fis=5Ftask(se))
@@ -3977,8 +3977,8 @@ dequeue=5Fentity(struct cfs=5Frq *cfs=5Frq, struct sc=
hed=5Fentity *se, int flags)
 	/*
 	 * When dequeuing a sched=5Fentity, we must:
 	 *   - Update loads to have both entity and cfs=5Frq synced with now.
-	 *   - Substract its load from the cfs=5Frq->runnable=5Favg.
-	 *   - Substract its previous weight from cfs=5Frq->load.weight.
+	 *   - Subtract its load from the cfs=5Frq->runnable=5Favg.
+	 *   - Subtract its previous weight from cfs=5Frq->load.weight.
 	 *   - For group entity, update its weight to reflect the new share
 	 *     of its group cfs=5Frq.
 	 */
--=20
2.19.1

