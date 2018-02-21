Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753550AbeBUKmt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:42:49 -0500
Received: from terminus.zytor.com ([198.137.202.136]:43125 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751717AbeBUKms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:42:48 -0500
Date: Wed, 21 Feb 2018 02:42:24 -0800
From: tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-621df431b0ac931e318679f54047c47eb23cfdd2@git.kernel.org>
Cc: mingo@kernel.org, akiyks@gmail.com, hpa@zytor.com,
        parri.andrea@gmail.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        torvalds@linux-foundation.org, tglx@linutronix.de
Reply-To: torvalds@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        hpa@zytor.com, parri.andrea@gmail.com, peterz@infradead.org,
        mingo@kernel.org, akiyks@gmail.com
In-Reply-To: <1519169112-20593-7-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1519169112-20593-7-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] Documentation/memory-barriers.txt:
 Cross-reference "tools/memory-model/"
Git-Commit-ID: 621df431b0ac931e318679f54047c47eb23cfdd2
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

Commit-ID:  621df431b0ac931e318679f54047c47eb23cfdd2
Gitweb:     https://git.kernel.org/tip/621df431b0ac931e318679f54047c47eb23cfdd2
Author:     Andrea Parri <parri.andrea@gmail.com>
AuthorDate: Tue, 20 Feb 2018 15:25:07 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:58:14 +0100

Documentation/memory-barriers.txt: Cross-reference "tools/memory-model/"

A memory consistency model is now available for the Linux kernel [1],
which "can (roughly speaking) be thought of as an automated version of
memory-barriers.txt" and which is (in turn) "accompanied by extensive
documentation on its use and its design".

Inform the (occasional) reader of memory-barriers.txt of these
developments.

[1] https://marc.info/?l=linux-kernel&m=151687290114799&w=2

Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
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
Cc: stern@rowland.harvard.edu
Cc: will.deacon@arm.com
Link: http://lkml.kernel.org/r/1519169112-20593-7-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/memory-barriers.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index a863009..a37d3af 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -14,7 +14,11 @@ DISCLAIMER
 This document is not a specification; it is intentionally (for the sake of
 brevity) and unintentionally (due to being human) incomplete. This document is
 meant as a guide to using the various memory barriers provided by Linux, but
-in case of any doubt (and there are many) please ask.
+in case of any doubt (and there are many) please ask.  Some doubts may be
+resolved by referring to the formal memory consistency model and related
+documentation at tools/memory-model/.  Nevertheless, even this memory
+model should be viewed as the collective opinion of its maintainers rather
+than as an infallible oracle.
 
 To repeat, this document is not a specification of what Linux expects from
 hardware.
