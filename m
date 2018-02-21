Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753495AbeBUKls (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:41:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34433 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeBUKlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:41:46 -0500
Date: Wed, 21 Feb 2018 02:40:27 -0800
From: tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-ea52d698c1ed0c4555656de0dd1f7ac5866f89e1@git.kernel.org>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        will.deacon@arm.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        parri.andrea@gmail.com
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        will.deacon@arm.com, tglx@linutronix.de, torvalds@linux-foundation.org,
        parri.andrea@gmail.com, paulmck@linux.vnet.ibm.com,
        peterz@infradead.org
In-Reply-To: <1519169112-20593-3-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1519169112-20593-3-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] MAINTAINERS: List file memory-barriers.txt
 within the LKMM entry
Git-Commit-ID: ea52d698c1ed0c4555656de0dd1f7ac5866f89e1
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

Commit-ID:  ea52d698c1ed0c4555656de0dd1f7ac5866f89e1
Gitweb:     https://git.kernel.org/tip/ea52d698c1ed0c4555656de0dd1f7ac5866f89e1
Author:     Andrea Parri <parri.andrea@gmail.com>
AuthorDate: Tue, 20 Feb 2018 15:25:03 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:58:13 +0100

MAINTAINERS: List file memory-barriers.txt within the LKMM entry

We now have a shiny new Linux-kernel memory model (LKMM) and the old
tried-and-true Documentation/memory-barrier.txt.  It would be good to
keep these automatically synchronized, but in the meantime we need at
least let people know that they are related.  Will suggested adding the
Documentation/memory-barrier.txt file to the LKMM maintainership list,
thus making the LKMM maintainers responsible for both the old and the new.
This commit follows Will's excellent suggestion.

Suggested-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
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
Cc: stern@rowland.harvard.edu
Link: http://lkml.kernel.org/r/1519169112-20593-3-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 654c6c6..42da350 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8163,6 +8163,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
 F:	tools/memory-model/
+F:	Documentation/memory-barriers.txt
 
 LINUX SECURITY MODULE (LSM) FRAMEWORK
 M:	Chris Wright <chrisw@sous-sol.org>
