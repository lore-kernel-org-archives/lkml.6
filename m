Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeCJJ2m (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 04:28:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36879 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbeCJJ2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 04:28:41 -0500
Date: Sat, 10 Mar 2018 01:28:16 -0800
From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Message-ID: <tip-d095c12c53c7b941ad4ea96dc229a08296b37d2e@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, hpa@zytor.com,
        stern@rowland.harvard.edu, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        mingo@kernel.org
Reply-To: paulmck@linux.vnet.ibm.com, mingo@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, hpa@zytor.com,
        stern@rowland.harvard.edu, peterz@infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1520443660-16858-2-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1520443660-16858-2-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Remove mention of
 docker/gentoo image
Git-Commit-ID: d095c12c53c7b941ad4ea96dc229a08296b37d2e
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

Commit-ID:  d095c12c53c7b941ad4ea96dc229a08296b37d2e
Gitweb:     https://git.kernel.org/tip/d095c12c53c7b941ad4ea96dc229a08296b37d2e
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Wed, 7 Mar 2018 09:27:38 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 10 Mar 2018 10:22:23 +0100

tools/memory-model: Remove mention of docker/gentoo image

Because the docker and gentoo images haven't been updated in quite some
time, they are likely to provide more confusion than help.  This commit
therefore removes mention of them from the README file.

Reported-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/1520443660-16858-2-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/README | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/tools/memory-model/README b/tools/memory-model/README
index ea950c566ffd..0b3a5f3c9ccd 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -27,21 +27,6 @@ separately:
 
 See "herdtools7/INSTALL.md" for installation instructions.
 
-Alternatively, Abhishek Bhardwaj has kindly provided a Docker image
-of these tools at "abhishek40/memory-model".  Abhishek suggests the
-following commands to install and use this image:
-
-  - Users should install Docker for their distribution.
-  - docker run -itd abhishek40/memory-model
-  - docker attach <id-emitted-from-the-previous-command>
-
-Gentoo users might wish to make use of Patrick McLean's package:
-
-  https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-util/herdtools7
-
-These packages may not be up-to-date with respect to the GitHub
-repository.
-
 
 ==================
 BASIC USAGE: HERD7
