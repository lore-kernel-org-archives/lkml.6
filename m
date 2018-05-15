Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbeEOGhB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:37:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50685 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbeEOGg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:36:59 -0400
Date: Mon, 14 May 2018 23:36:18 -0700
From: tip-bot for Andrea Parri <tipbot@zytor.com>
Message-ID: <tip-99c12749b172758f6973fc023484f2fc8b91cd5a@git.kernel.org>
Cc: tglx@linutronix.de, boqun.feng@gmail.com, stern@rowland.harvard.edu,
        will.deacon@arm.com, akpm@linux-foundation.org,
        paulmck@linux.vnet.ibm.com, mingo@kernel.org, luc.maranget@inria.fr,
        hpa@zytor.com, akiyks@gmail.com, peterz@infradead.org,
        npiggin@gmail.com, j.alglave@ucl.ac.uk, dhowells@redhat.com,
        andrea.parri@amarulasolutions.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, boqun.feng@gmail.com, stern@rowland.harvard.edu,
        akpm@linux-foundation.org, will.deacon@arm.com, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, luc.maranget@inria.fr, akiyks@gmail.com,
        peterz@infradead.org, npiggin@gmail.com, hpa@zytor.com,
        andrea.parri@amarulasolutions.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1526340837-12222-19-git-send-email-paulmck@linux.vnet.ibm.com>
References: <1526340837-12222-19-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] tools/memory-model: Add reference for
 'Simplifying ARM concurrency'
Git-Commit-ID: 99c12749b172758f6973fc023484f2fc8b91cd5a
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

Commit-ID:  99c12749b172758f6973fc023484f2fc8b91cd5a
Gitweb:     https://git.kernel.org/tip/99c12749b172758f6973fc023484f2fc8b91cd5a
Author:     Andrea Parri <andrea.parri@amarulasolutions.com>
AuthorDate: Mon, 14 May 2018 16:33:57 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 15 May 2018 08:11:19 +0200

tools/memory-model: Add reference for 'Simplifying ARM concurrency'

The paper discusses the revised ARMv8 memory model; such revision
had an important impact on the design of the LKMM.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: parri.andrea@gmail.com
Link: http://lkml.kernel.org/r/1526340837-12222-19-git-send-email-paulmck@linux.vnet.ibm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/memory-model/Documentation/references.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.txt
index 74f448f2616a..b177f3e4a614 100644
--- a/tools/memory-model/Documentation/references.txt
+++ b/tools/memory-model/Documentation/references.txt
@@ -63,6 +63,12 @@ o	Shaked Flur, Susmit Sarkar, Christopher Pulte, Kyndylan Nienhuis,
 	Principles of Programming Languages (POPL 2017). ACM, New York,
 	NY, USA, 429–442.
 
+o	Christopher Pulte, Shaked Flur, Will Deacon, Jon French,
+	Susmit Sarkar, and Peter Sewell. 2018. "Simplifying ARM concurrency:
+	multicopy-atomic axiomatic and operational models for ARMv8". In
+	Proceedings of the ACM on Programming Languages, Volume 2, Issue
+	POPL, Article No. 19. ACM, New York, NY, USA.
+
 
 Linux-kernel memory model
 =========================
