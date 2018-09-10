Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AF7C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEAC20865
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 10:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEAC20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeIJPEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 11:04:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56983 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeIJPEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 11:04:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8AAAYbi1807416
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 10 Sep 2018 03:10:34 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8AAAXhB1807411;
        Mon, 10 Sep 2018 03:10:33 -0700
Date:   Mon, 10 Sep 2018 03:10:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Randy Dunlap <tipbot@zytor.com>
Message-ID: <tip-882a78a9f39f5535b209b4aa0a1741e35b8c67fb@git.kernel.org>
Cc:     hpa@zytor.com, rdunlap@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org
Reply-To: torvalds@linux-foundation.org, peterz@infradead.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
          rdunlap@infradead.org, tglx@linutronix.de
In-Reply-To: <cdda0d42-880d-4229-a9f7-5899c977a063@infradead.org>
References: <cdda0d42-880d-4229-a9f7-5899c977a063@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Fix kernel-doc notation warning
Git-Commit-ID: 882a78a9f39f5535b209b4aa0a1741e35b8c67fb
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  882a78a9f39f5535b209b4aa0a1741e35b8c67fb
Gitweb:     https://git.kernel.org/tip/882a78a9f39f5535b209b4aa0a1741e35b8c67fb
Author:     Randy Dunlap <rdunlap@infradead.org>
AuthorDate: Mon, 3 Sep 2018 12:53:17 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 10 Sep 2018 10:31:37 +0200

sched/fair: Fix kernel-doc notation warning

Fix kernel-doc warning for missing 'flags' parameter description:

../kernel/sched/fair.c:3371: warning: Function parameter or member 'flags' not described in 'attach_entity_load_avg'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: ea14b57e8a18 ("sched/cpufreq: Provide migration hint")
Link: http://lkml.kernel.org/r/cdda0d42-880d-4229-a9f7-5899c977a063@infradead.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fc9a484ef82b..f808ddf2a868 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3362,6 +3362,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
  * attach_entity_load_avg - attach this entity to its cfs_rq load avg
  * @cfs_rq: cfs_rq to attach to
  * @se: sched_entity to attach
+ * @flags: migration hints
  *
  * Must call update_cfs_rq_load_avg() before this, since we rely on
  * cfs_rq->avg.last_update_time being current.
