Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3589C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE68B2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE68B2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeJ3RzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:55:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38457 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3RzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:55:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9U90t3M1906775
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 30 Oct 2018 02:00:55 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9U90sCW1906771;
        Tue, 30 Oct 2018 02:00:54 -0700
Date:   Tue, 30 Oct 2018 02:00:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Colin Ian King <tipbot@zytor.com>
Message-ID: <tip-28fa741c27e6d57f6bf594ba3c444ce79e671e09@git.kernel.org>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        colin.king@canonical.com, peterz@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        namhyung@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        jolsa@redhat.com
Reply-To: hpa@zytor.com, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, acme@kernel.org,
          alexander.shishkin@linux.intel.com, peterz@infradead.org,
          colin.king@canonical.com, jolsa@redhat.com, namhyung@kernel.org,
          tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <20181029233211.21475-1-colin.king@canonical.com>
References: <20181029233211.21475-1-colin.king@canonical.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/core: Clean up inconsisent indentation
Git-Commit-ID: 28fa741c27e6d57f6bf594ba3c444ce79e671e09
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

Commit-ID:  28fa741c27e6d57f6bf594ba3c444ce79e671e09
Gitweb:     https://git.kernel.org/tip/28fa741c27e6d57f6bf594ba3c444ce79e671e09
Author:     Colin Ian King <colin.king@canonical.com>
AuthorDate: Mon, 29 Oct 2018 23:32:11 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 30 Oct 2018 09:51:58 +0100

perf/core: Clean up inconsisent indentation

Replace a bunch of spaces with tab, cleans up indentation

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-janitors@vger.kernel.org
Link: http://lkml.kernel.org/r/20181029233211.21475-1-colin.king@canonical.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5a97f34bc14c..65e90c752a91 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -750,7 +750,7 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
 	/*
 	 * Do not update time when cgroup is not active
 	 */
-       if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
+	if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
 		__update_cgrp_time(event->cgrp);
 }
 
