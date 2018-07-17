Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A21ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E18B720852
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:29:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18B720852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbeGQKBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:01:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47957 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728089AbeGQKBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:01:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6H9T78j1462491
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 17 Jul 2018 02:29:07 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6H9T78P1462488;
        Tue, 17 Jul 2018 02:29:07 -0700
Date:   Tue, 17 Jul 2018 02:29:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-24675bb554f9e3d0e2bd61f6a7d8da50d224c8ff@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, akiyks@gmail.com,
        peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org
Reply-To: peterz@infradead.org, hpa@zytor.com, akiyks@gmail.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          paulmck@linux.vnet.ibm.com, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20180716180605.16115-7-paulmck@linux.vnet.ibm.com>
References: <20180716180605.16115-7-paulmck@linux.vnet.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Make scripts executable
Git-Commit-ID: 24675bb554f9e3d0e2bd61f6a7d8da50d224c8ff
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

Commit-ID:  24675bb554f9e3d0e2bd61f6a7d8da50d224c8ff
Gitweb:     https://git.kernel.org/tip/24675bb554f9e3d0e2bd61f6a7d8da50d224c8ff
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Mon, 16 Jul 2018 11:05:58 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 17 Jul 2018 09:30:17 +0200

tools/memory-model: Make scripts executable

This commit makes the scripts executable to avoid the need for everyone
to do so manually in their archive.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Akira Yokosawa <akiyks@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/20180716180605.16115-7-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/scripts/checkalllitmus.sh | 2 +-
 tools/memory-model/scripts/checklitmus.sh    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
old mode 100644
new mode 100755
index af0aa15ab84e..ca528f9a24d4
--- a/tools/memory-model/scripts/checkalllitmus.sh
+++ b/tools/memory-model/scripts/checkalllitmus.sh
@@ -9,7 +9,7 @@
 # appended.
 #
 # Usage:
-#	sh checkalllitmus.sh [ directory ]
+#	checkalllitmus.sh [ directory ]
 #
 # The LINUX_HERD_OPTIONS environment variable may be used to specify
 # arguments to herd, whose default is defined by the checklitmus.sh script.
diff --git a/tools/memory-model/scripts/checklitmus.sh b/tools/memory-model/scripts/checklitmus.sh
old mode 100644
new mode 100755
index e2e477472844..bf12a75c0719
--- a/tools/memory-model/scripts/checklitmus.sh
+++ b/tools/memory-model/scripts/checklitmus.sh
@@ -8,7 +8,7 @@
 # with ".out" appended.
 #
 # Usage:
-#	sh checklitmus.sh file.litmus
+#	checklitmus.sh file.litmus
 #
 # The LINUX_HERD_OPTIONS environment variable may be used to specify
 # arguments to herd, which default to "-conf linux-kernel.cfg".  Thus,
