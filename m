Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDF2C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5465120878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5465120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeJBQzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:55:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58483 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbeJBQzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:55:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w92ABjlV1916319
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 2 Oct 2018 03:11:45 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w92ABjvf1916316;
        Tue, 2 Oct 2018 03:11:45 -0700
Date:   Tue, 2 Oct 2018 03:11:45 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for SeongJae Park <tipbot@zytor.com>
Message-ID: <tip-3d2046a6fa2106584cf1080c2c08a6e8e79cbbb4@git.kernel.org>
Cc:     vincent.weaver@maine.edu, alexander.shishkin@linux.intel.com,
        paulmck@linux.vnet.ibm.com, acme@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, eranian@google.com, mingo@kernel.org,
        hpa@zytor.com, sj38.park@gmail.com, jolsa@redhat.com,
        stern@rowland.harvard.edu
Reply-To: acme@redhat.com, peterz@infradead.org, vincent.weaver@maine.edu,
          paulmck@linux.vnet.ibm.com, alexander.shishkin@linux.intel.com,
          jolsa@redhat.com, stern@rowland.harvard.edu, sj38.park@gmail.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, eranian@google.com,
          torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <20180926182920.27644-3-paulmck@linux.ibm.com>
References: <20180926182920.27644-3-paulmck@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Fix a README typo
Git-Commit-ID: 3d2046a6fa2106584cf1080c2c08a6e8e79cbbb4
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

Commit-ID:  3d2046a6fa2106584cf1080c2c08a6e8e79cbbb4
Gitweb:     https://git.kernel.org/tip/3d2046a6fa2106584cf1080c2c08a6e8e79cbbb4
Author:     SeongJae Park <sj38.park@gmail.com>
AuthorDate: Wed, 26 Sep 2018 11:29:18 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 2 Oct 2018 10:28:03 +0200

tools/memory-model: Fix a README typo

This commit fixes a duplicate-"the" typo in README.

Signed-off-by: SeongJae Park <sj38.park@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/20180926182920.27644-3-paulmck@linux.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/Documentation/recipes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/recipes.txt b/tools/memory-model/Documentation/recipes.txt
index af72700cc20a..7fe8d7aa3029 100644
--- a/tools/memory-model/Documentation/recipes.txt
+++ b/tools/memory-model/Documentation/recipes.txt
@@ -311,7 +311,7 @@ The smp_wmb() macro orders prior stores against later stores, and the
 smp_rmb() macro orders prior loads against later loads.  Therefore, if
 the final value of r0 is 1, the final value of r1 must also be 1.
 
-The the xlog_state_switch_iclogs() function in fs/xfs/xfs_log.c contains
+The xlog_state_switch_iclogs() function in fs/xfs/xfs_log.c contains
 the following write-side code fragment:
 
 	log->l_curr_block -= log->l_logBBsize;
