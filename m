Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752638AbeDKHHt convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:07:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:22571 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752212AbeDKHHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:07:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,435,1517904000";
   d="scan'208";a="45251335"
Message-ID: <1523430464.123441.5.camel@intel.com>
Subject: [GIT PULL] arch/nios2 update for v4.17-rc1
From: Ley Foon Tan <ley.foon.tan@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "lftan.linux@gmail.com" <lftan.linux@gmail.com>
Date: Wed, 11 Apr 2018 15:07:44 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Here is nios2 update for v4.17-rc1.

Please consider pulling.

Regards
Ley Foon


The following changes since commit 0adb32858b0bddf4ada5f364a84ed60b196dbcda:

  Linux 4.16 (2018-04-01 14:20:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git tags/nios2-v4.17-rc1

for you to fetch changes up to 3d9644ef9a0f6c3ca0c1bd2aea1d82e7ea0a7f24:

  nios2: Use read_persistent_clock64() instead of read_persistent_clock() (2018-04-03 00:36:55 +0800)

----------------------------------------------------------------
nios2 update for v4.17-rc1

nios2: Use read_persistent_clock64() instead of read_persistent_clock()

----------------------------------------------------------------
Baolin Wang (1):
      nios2: Use read_persistent_clock64() instead of read_persistent_clock()

 arch/nios2/kernel/time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
