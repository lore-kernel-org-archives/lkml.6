Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753529AbeBUKmV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:42:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41503 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbeBUKmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:42:20 -0500
Date: Wed, 21 Feb 2018 02:41:54 -0800
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-65b65f8e8b941785b0a08cf24ffd7084c8df327c@git.kernel.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        peterz@infradead.org, mingo@kernel.org, torvalds@linux-foundation.org,
        paulmck@linux.vnet.ibm.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org
In-Reply-To: <1519169112-20593-6-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1519169112-20593-6-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] MAINTAINERS: Add Akira Yokosawa as an LKMM
 reviewer
Git-Commit-ID: 65b65f8e8b941785b0a08cf24ffd7084c8df327c
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

Commit-ID:  65b65f8e8b941785b0a08cf24ffd7084c8df327c
Gitweb:     https://git.kernel.org/tip/65b65f8e8b941785b0a08cf24ffd7084c8df327c
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Tue, 20 Feb 2018 15:25:06 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:58:14 +0100

MAINTAINERS: Add Akira Yokosawa as an LKMM reviewer

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
Link: http://lkml.kernel.org/r/1519169112-20593-6-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42da350..1dd9cc2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8159,6 +8159,7 @@ M:	David Howells <dhowells@redhat.com>
 M:	Jade Alglave <j.alglave@ucl.ac.uk>
 M:	Luc Maranget <luc.maranget@inria.fr>
 M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
+R:	Akira Yokosawa <akiyks@gmail.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
