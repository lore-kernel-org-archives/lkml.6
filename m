Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbeDAQmX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 1 Apr 2018 12:42:23 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:43030 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753672AbeDAQmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Apr 2018 12:42:22 -0400
X-Google-Smtp-Source: AIpwx48P3Q1/wgOLTI9JUXnMlAn0dKNeRLNthHeTQuiMCHnzts4cXAS9WLME3NligWroL+vzHZfdzQ==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v3 0/3] Changes, clean-ups and documentation for spin_is_locked()
Date: Sun,  1 Apr 2018 18:41:49 +0200
Message-Id: <1522600912-6208-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

This series gathers the change to the arm64 implementation of spin_is_locked()
and the clean-up to the generic (q)spinlock presented in [1] together with the
patch adding the docbook header to spin_is_locked() [2].

Apart from minor adjustments to the commit messages, the patches are unchanged.

Cheers,
  Andrea

[1] https://marc.info/?l=linux-kernel&m=152223038924258&w=2
[2] https://marc.info/?l=linux-kernel&m=151981440005264&w=2

Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>

Andrea Parri (3):
  arm64: Remove smp_mb() from arch_spin_is_locked()
  locking: Clean-up comment and #ifndef for {,queued_}spin_is_locked()
  Documentation/locking: Document the semantics of spin_is_locked()

 arch/arm64/include/asm/spinlock.h |  5 -----
 include/asm-generic/qspinlock.h   |  2 --
 include/linux/mutex.h             |  3 ---
 include/linux/spinlock.h          | 11 +++++++++++
 4 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.7.4
