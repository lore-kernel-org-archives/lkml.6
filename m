Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeC1JqW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 05:46:22 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36253 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751434AbeC1JqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 05:46:21 -0400
X-Google-Smtp-Source: AIpwx4979TtHrEbf8a/QNc48mcgT1W3A/L7RW1+Nw74aCVqlqIt6sokEyGLFZXwEfQJxTy5J5GKjHg==
From: Andrea Parri <andrea.parri@amarulasolutions.com>
To: Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH v2 for-4.17 0/3] Changes and clean-ups for spin_is_locked()
Date: Wed, 28 Mar 2018 11:45:53 +0200
Message-Id: <1522230353-12213-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A resend of the "arch_spin_is_locked() patches" discussed in the last
days,  together with a third patch/clean-up suggested by Will during
the review procees.  The first two patches are unmodified, except for
the inclusion of Acked-by:'s.

Cheers,
  Andrea

Andrea Parri (3):
  arm64: Remove smp_mb() from arch_spin_is_locked()
  powerpc: Remove smp_mb() from arch_spin_is_locked()
  locking: Clean-up comment and #ifndef for {,queued_}spin_is_locked()

 arch/arm64/include/asm/spinlock.h   | 5 -----
 arch/powerpc/include/asm/spinlock.h | 1 -
 include/asm-generic/qspinlock.h     | 2 --
 include/linux/mutex.h               | 3 ---
 4 files changed, 11 deletions(-)

-- 
2.7.4
