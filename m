Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753513AbeBUKmC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:42:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36231 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753145AbeBUKlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:41:47 -0500
Date: Wed, 21 Feb 2018 02:41:23 -0800
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-62155147048f6c811b82cbb53bee246aee083774@git.kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
        mingo@kernel.org, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org
In-Reply-To: <1519169112-20593-5-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1519169112-20593-5-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] README: Fix a couple of punctuation errors
Git-Commit-ID: 62155147048f6c811b82cbb53bee246aee083774
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  62155147048f6c811b82cbb53bee246aee083774
Gitweb:     https://git.kernel.org/tip/62155147048f6c811b82cbb53bee246aee083774
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Tue, 20 Feb 2018 15:25:05 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:58:14 +0100

README: Fix a couple of punctuation errors

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: nborisov@suse.com
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/1519169112-20593-5-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/litmus-tests/README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
index 9a3bb59..dca7d823 100644
--- a/tools/memory-model/litmus-tests/README
+++ b/tools/memory-model/litmus-tests/README
@@ -23,14 +23,14 @@ IRIW+mbonceonces+OnceOnce.litmus
 	between each pairs of reads.  In other words, is smp_mb()
 	sufficient to cause two different reading processes to agree on
 	the order of a pair of writes, where each write is to a different
-	variable by a different process.
+	variable by a different process?
 
 IRIW+poonceonces+OnceOnce.litmus
 	Test of independent reads from independent writes with nothing
 	between each pairs of reads.  In other words, is anything at all
 	needed to cause two different reading processes to agree on the
 	order of a pair of writes, where each write is to a different
-	variable by a different process.
+	variable by a different process?
 
 ISA2+poonceonces.litmus
 	As below, but with store-release replaced with WRITE_ONCE()
