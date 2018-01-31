Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeAaVXy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 16:23:54 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:37266 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753135AbeAaVXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 16:23:53 -0500
Date: Wed, 31 Jan 2018 21:23:51 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, arch@vger.kernel.org
Subject: [git pull] asm/uaccess.h whack-a-mole
Message-ID: <20180131212351.GC30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	It's linux/uaccess.h, damnit...  Oh, well - eventually they'll stop
cropping up...

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.whack-a-mole

for you to fetch changes up to c68070d0408eb2297331a9c9ae538a7bec13fc81:

  asm-prototypes.h: use linux/uaccess.h, not asm/uaccess.h (2017-12-04 18:03:39 -0500)

----------------------------------------------------------------
Al Viro (3):
      ppc: for put_user() pull linux/uaccess.h, not asm/uaccess.h
      riscv: use linux/uaccess.h, not asm/uaccess.h...
      asm-prototypes.h: use linux/uaccess.h, not asm/uaccess.h

 arch/alpha/include/asm/asm-prototypes.h | 2 +-
 arch/ia64/include/asm/asm-prototypes.h  | 2 +-
 arch/mips/include/asm/asm-prototypes.h  | 2 +-
 arch/powerpc/kvm/book3s_xive.c          | 2 +-
 arch/riscv/kernel/process.c             | 2 +-
 arch/riscv/mm/fault.c                   | 1 -
 arch/sparc/include/asm/asm-prototypes.h | 2 +-
 7 files changed, 6 insertions(+), 7 deletions(-)
