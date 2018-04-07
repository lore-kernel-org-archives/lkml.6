Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeDGUui (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 16:50:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:35348 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbeDGUuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 16:50:37 -0400
Date: Sat, 7 Apr 2018 21:50:36 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [git pull] alpha syscall stuff
Message-ID: <20180407205036.GD30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	a couple of SYSCALL_DEFINE conversions and removal of
pointless (and bitrotten) piece stuck in ret_from_kernel_thread
since the kernel_exceve/kernel_thread conversions six years ago.

The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git misc.compat

for you to fetch changes up to 206b1c6012a8a3792948ed699f3973d7be13f6db:

  alpha: get rid of pointless insn in ret_from_kernel_thread (2018-03-28 08:58:27 -0400)

----------------------------------------------------------------
Al Viro (2):
      alpha: switch pci syscalls to SYSCALL_DEFINE
      alpha: get rid of pointless insn in ret_from_kernel_thread

 arch/alpha/kernel/entry.S    |  1 -
 arch/alpha/kernel/pci-noop.c | 15 +++++++--------
 arch/alpha/kernel/pci.c      |  5 +++--
 3 files changed, 10 insertions(+), 11 deletions(-)
