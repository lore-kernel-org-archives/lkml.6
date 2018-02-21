Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933378AbeBUKnq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:43:46 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36373 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932863AbeBUKno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:43:44 -0500
Date: Wed, 21 Feb 2018 02:43:23 -0800
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-8f7f2fbd00898deaf01e05a00095411811befd64@git.kernel.org>
Cc: akiyks@gmail.com, mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org
Reply-To: torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        peterz@infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        hpa@zytor.com, mingo@kernel.org, akiyks@gmail.com
In-Reply-To: <1519169112-20593-9-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1519169112-20593-9-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Add required herd7 version
 to README file
Git-Commit-ID: 8f7f2fbd00898deaf01e05a00095411811befd64
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

Commit-ID:  8f7f2fbd00898deaf01e05a00095411811befd64
Gitweb:     https://git.kernel.org/tip/8f7f2fbd00898deaf01e05a00095411811befd64
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Tue, 20 Feb 2018 15:25:09 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:58:15 +0100

tools/memory-model: Add required herd7 version to README file

LKMM and the herd7 tool are co-evolving, and out-of-date herd7 tools
produce inaccurate results, often with no obvious error messages.  This
commit therefore adds the required herd7 version to the LKMM README file.

Longer term, it would be good if .cat files could specify the required
version in a manner allowing herd7 to produce clear diagnostics.

Suggested-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
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
Link: http://lkml.kernel.org/r/1519169112-20593-9-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/README | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index 91414a4..ea950c5 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -20,7 +20,8 @@ that litmus test to be exercised within the Linux kernel.
 REQUIREMENTS
 ============
 
-The "herd7" and "klitmus7" tools must be downloaded separately:
+Version 7.48 of the "herd7" and "klitmus7" tools must be downloaded
+separately:
 
   https://github.com/herd/herdtools7
 
