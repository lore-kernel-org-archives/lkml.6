Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753060AbeDTQbH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:31:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45938 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbeDTQbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:31:04 -0400
X-Google-Smtp-Source: AIpwx4+sFZhSWqdAfWA8mW51Z15c83lnxmt2a9biAVbof/XduDWJ888E7nuzWlijsDseJGUo38GviA==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH 2/2] tools/memory-model: Add reference for 'Simplifying ARM concurrency'
Date: Fri, 20 Apr 2018 18:30:13 +0200
Message-Id: <1524241813-14045-3-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524241813-14045-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1524241813-14045-1-git-send-email-andrea.parri@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The paper discusses the revised ARMv8 memory model; such revision
had an important impact on the design of the LKMM.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
---
 tools/memory-model/Documentation/references.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.txt
index 74f448f2616a3..b177f3e4a614d 100644
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
-- 
2.7.4
