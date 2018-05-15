Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbeEOG3Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:29:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60703 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752232AbeEOG3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:29:22 -0400
Date: Mon, 14 May 2018 23:28:45 -0700
From: tip-bot for Paolo Bonzini <tipbot@zytor.com>
Message-ID: <tip-a839195186a2bca1b2b46e57619e9ad5b8d42426@git.kernel.org>
Cc: pbonzini@redhat.com, torvalds@linux-foundation.org,
        peterz@infradead.org, will.deacon@arm.com, hpa@zytor.com,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Reply-To: torvalds@linux-foundation.org, pbonzini@redhat.com,
        peterz@infradead.org, hpa@zytor.com, will.deacon@arm.com,
        paulmck@linux.vnet.ibm.com, tglx@linutronix.de, mingo@kernel.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
In-Reply-To: <1526340837-12222-4-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526340837-12222-4-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Fix cheat sheet typo
Git-Commit-ID: a839195186a2bca1b2b46e57619e9ad5b8d42426
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

Commit-ID:  a839195186a2bca1b2b46e57619e9ad5b8d42426
Gitweb:     https://git.kernel.org/tip/a839195186a2bca1b2b46e57619e9ad5b8d42426
Author:     Paolo Bonzini <pbonzini@redhat.com>
AuthorDate: Mon, 14 May 2018 16:33:42 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:16 +0200

tools/memory-model: Fix cheat sheet typo

"RWM" should be "RMW".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: akiyks@gmail.com
Cc: boqun.feng@gmail.com
Cc: dhowells@redhat.com
Cc: j.alglave@ucl.ac.uk
Cc: linux-arch@vger.kernel.org
Cc: luc.maranget@inria.fr
Cc: npiggin@gmail.com
Cc: parri.andrea@gmail.com
Cc: stern@rowland.harvard.edu
Link: http://lkml.kernel.org/r/1526340837-12222-4-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/Documentation/cheatsheet.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index 956b1ae4aafb..c0eafdaddfa4 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -1,6 +1,6 @@
                                   Prior Operation     Subsequent Operation
                                   ---------------  ---------------------------
-                               C  Self  R  W  RWM  Self  R  W  DR  DW  RMW  SV
+                               C  Self  R  W  RMW  Self  R  W  DR  DW  RMW  SV
                               --  ----  -  -  ---  ----  -  -  --  --  ---  --
 
 Store, e.g., WRITE_ONCE()            Y                                       Y
