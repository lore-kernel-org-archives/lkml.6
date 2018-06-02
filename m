Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeFBMfl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 08:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751423AbeFBMfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 08:35:40 -0400
Date: Sat, 2 Jun 2018 14:35:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 4.17-rc8
Message-ID: <20180602123517.GB15904@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/ tags/char-misc-4.17-rc8

for you to fetch changes up to 806e30873f0e74d9d41b0ef761bd4d3e55c7d510:

  hwtracing: stm: fix build error on some arches (2018-05-26 08:49:24 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 4.17-rc8

Here are 4 small bugfixes for some char/misc drivers.  Well, really 3
fixes and one fix for one of those fixes due to problems found by 0-day.

This resolves some reported issues with the hwtracing drivers, and a
reported regression for the thunderbolt subsystem.  All of these have
been in linux-next for a while now with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Shishkin (2):
      stm class: Use vmalloc for the master map
      intel_th: Use correct device when freeing buffers

Greg Kroah-Hartman (1):
      hwtracing: stm: fix build error on some arches

Mika Westerberg (1):
      thunderbolt: Handle NULL boot ACL entries properly

 drivers/hwtracing/intel_th/msu.c | 6 +++---
 drivers/hwtracing/stm/core.c     | 7 ++++---
 drivers/thunderbolt/icm.c        | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)
