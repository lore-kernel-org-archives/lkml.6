Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753581AbeFDPI5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:08:57 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:34634 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753372AbeFDPI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:08:56 -0400
X-Google-Smtp-Source: ADUXVKJaO8p6NmTSjbwieqDDPi01ZmLY9rh+k82HqIq3qTGw9Fo+y2trpDef+qrUVl5CZpZ80VYrhQ==
Date: Mon, 4 Jun 2018 17:08:52 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cleanups for v4.18
Message-ID: <20180604150852.GA30857@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cleanups-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-for-linus

   # HEAD: 844ea8f62619ac2a5e47d13e3449ac197067b414 x86/apm: Fix spelling mistake: "caculate" -> "calculate"

Misc cleanups.

 Thanks,

	Ingo

------------------>
Colin Ian King (1):
      x86/apm: Fix spelling mistake: "caculate" -> "calculate"

Ingo Molnar (1):
      x86/bpf: Clean up non-standard comments, to make the code more readable

Joe Perches (3):
      x86/early-quirks: Rename duplicate define of dev_err
      x86: Remove pr_fmt duplicate logging prefixes
      x86/mtrr: Rename main.c to mtrr.c and remove duplicate prefixes


 arch/x86/events/amd/ibs.c                   |   2 +-
 arch/x86/kernel/apm_32.c                    |   2 +-
 arch/x86/kernel/cpu/mtrr/Makefile           |   2 +-
 arch/x86/kernel/cpu/mtrr/{main.c => mtrr.c} |  33 ++--
 arch/x86/kernel/e820.c                      |  32 ++--
 arch/x86/kernel/early-quirks.c              |   8 +-
 arch/x86/kernel/hpet.c                      |   5 +-
 arch/x86/kernel/uprobes.c                   |   4 +-
 arch/x86/mm/numa.c                          |  22 +--
 arch/x86/net/bpf_jit_comp.c                 | 233 ++++++++++++++++------------
 10 files changed, 188 insertions(+), 155 deletions(-)
 rename arch/x86/kernel/cpu/mtrr/{main.c => mtrr.c} (96%)
