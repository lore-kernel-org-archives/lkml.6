Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753621AbeDTR7n (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:59:43 -0400
Received: from foss.arm.com ([217.140.101.70]:52498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753499AbeDTR7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:59:42 -0400
Date: Fri, 20 Apr 2018 18:59:38 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 4.17-rc2
Message-ID: <20180420175935.obbvf5ype6n2odoq@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to b2d71b3cda19831ec67f49d7c6ba0214d9367b29:

  arm64: signal: don't force known signals to SIGKILL (2018-04-18 15:13:27 +0100)

----------------------------------------------------------------
arm64 fixes:

- KASan: avoid pfn_to_nid() before the page array is initialised

- Fix typo causing the "upgrade" of known signals to SIGKILL

----------------------------------------------------------------
Mark Rutland (2):
      arm64: kasan: avoid pfn_to_nid() before page array is initialized
      arm64: signal: don't force known signals to SIGKILL

 arch/arm64/kernel/traps.c  | 2 +-
 arch/arm64/mm/kasan_init.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Catalin
