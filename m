Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104EEC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A852087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A852087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeJKQG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 12:06:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34371 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeJKQG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 12:06:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w9B8dpdk1824100
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 11 Oct 2018 01:39:51 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w9B8doAV1824097;
        Thu, 11 Oct 2018 01:39:50 -0700
Date:   Thu, 11 Oct 2018 01:39:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for John Garry <tipbot@zytor.com>
Message-ID: <tip-7b6abce7e1e69b6d8dc5d40a8cb9ddaeb400427c@git.kernel.org>
Cc:     john.garry@huawei.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
Reply-To: tglx@linutronix.de, torvalds@linux-foundation.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          peterz@infradead.org, john.garry@huawei.com, mingo@kernel.org
In-Reply-To: <1539183392-239389-1-git-send-email-john.garry@huawei.com>
References: <1539183392-239389-1-git-send-email-john.garry@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/completions/Documentation: Fix a couple of
 punctuation nits
Git-Commit-ID: 7b6abce7e1e69b6d8dc5d40a8cb9ddaeb400427c
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

Commit-ID:  7b6abce7e1e69b6d8dc5d40a8cb9ddaeb400427c
Gitweb:     https://git.kernel.org/tip/7b6abce7e1e69b6d8dc5d40a8cb9ddaeb400427c
Author:     John Garry <john.garry@huawei.com>
AuthorDate: Wed, 10 Oct 2018 22:56:32 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 11 Oct 2018 10:36:22 +0200

sched/completions/Documentation: Fix a couple of punctuation nits

This patch fixes a couple of punctuation nits which can make the document
more correct and readable.

Also missing "()" are added to some function references for consistency.

Signed-off-by: John Garry <john.garry@huawei.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: corbet@lwn.net
Cc: linux-doc@vger.kernel.org
Link: http://lkml.kernel.org/r/1539183392-239389-1-git-send-email-john.garry@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/scheduler/completion.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/scheduler/completion.txt b/Documentation/scheduler/completion.txt
index 656cf803c006..108bd0f264b3 100644
--- a/Documentation/scheduler/completion.txt
+++ b/Documentation/scheduler/completion.txt
@@ -116,7 +116,7 @@ A typical usage scenario is:
 This is not implying any temporal order on wait_for_completion() and the
 call to complete() - if the call to complete() happened before the call
 to wait_for_completion() then the waiting side simply will continue
-immediately as all dependencies are satisfied if not it will block until
+immediately as all dependencies are satisfied; if not, it will block until
 completion is signaled by complete().
 
 Note that wait_for_completion() is calling spin_lock_irq()/spin_unlock_irq(),
@@ -131,7 +131,7 @@ wait_for_completion():
 The default behavior is to wait without a timeout and to mark the task as
 uninterruptible. wait_for_completion() and its variants are only safe
 in process context (as they can sleep) but not in atomic context,
-interrupt context, with disabled irqs. or preemption is disabled - see also
+interrupt context, with disabled irqs, or preemption is disabled - see also
 try_wait_for_completion() below for handling completion in atomic/interrupt
 context.
 
@@ -224,7 +224,7 @@ queue spinlock. Any such concurrent calls to complete() or complete_all()
 probably are a design bug.
 
 Signaling completion from hard-irq context is fine as it will appropriately
-lock with spin_lock_irqsave/spin_unlock_irqrestore and it will never sleep.
+lock with spin_lock_irqsave()/spin_unlock_irqrestore() and it will never sleep.
 
 
 try_wait_for_completion()/completion_done():
