Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbeDJVbp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 17:31:45 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:58258 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752482AbeDJVbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 17:31:44 -0400
From: Richard Weinberger <richard@nod.at>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Cc: linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] UBI/UBIFS changes for 4.17-rc1
Date: Tue, 10 Apr 2018 23:31:42 +0200
Message-ID: <2714108.Bbh5W41enc@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 0adb32858b0bddf4ada5f364a84ed60b196dbcda:

  Linux 4.16 (2018-04-01 14:20:27 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-ubifs.git tags/upstream-4.17-rc1

for you to fetch changes up to b5094b7f135be34630e3ea8a98fa215715d0f29d:

  ubi: Reject MLC NAND (2018-04-04 23:48:11 +0200)

----------------------------------------------------------------
This pull request contains updates for both UBI and UBIFS:
- Minor bug fixes and improvements

----------------------------------------------------------------
Jiang Biao (2):
      ubifs: Constify struct ubifs_lprops in scan_for_leb_for_idx
      ubifs: Remove useless parameter of lpt_heap_replace

Richard Weinberger (3):
      ubifs: Check ubifs_wbuf_sync() return code
      ubi: fastmap: Don't flush fastmap work on detach
      ubi: Reject MLC NAND

Romain Izard (1):
      ubi: Fix error for write access

Stefan Agner (1):
      ubifs: remove unnecessary assignment

 drivers/mtd/ubi/block.c      |  2 +-
 drivers/mtd/ubi/build.c      | 11 +++++++++++
 drivers/mtd/ubi/fastmap-wl.c |  1 -
 fs/ubifs/find.c              |  2 +-
 fs/ubifs/lprops.c            |  4 +---
 fs/ubifs/scan.c              |  1 -
 fs/ubifs/super.c             | 14 ++++++++++----
 7 files changed, 24 insertions(+), 11 deletions(-)
