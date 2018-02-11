Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbeBKPgn convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 10:36:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:28139 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751077AbeBKPgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 10:36:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,496,1511856000";
   d="scan'208";a="16864909"
Message-ID: <1518363396.49408.2.camel@intel.com>
Subject: [GIT PULL] arch/nios2 update for v4.16-rc1
From: Ley Foon Tan <ley.foon.tan@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "lftan.linux@gmail.com" <lftan.linux@gmail.com>
Date: Sun, 11 Feb 2018 23:36:36 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Here is nios2 update for v4.16-rc1.

Please consider pulling.

Regards
Ley Foon

The following changes since commit d8a5b80568a9cb66810e75b182018e9edb68e8ff:

  Linux 4.15 (2018-01-28 13:20:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lftan/nios2.git tags/nios2-v4.16-rc1

for you to fetch changes up to e0691ebb33c12084ef11b6b59228c004e19f59c8:

  nios2: defconfig: Cleanup from old Kconfig options (2018-02-11 23:04:53 +0800)

----------------------------------------------------------------
nios2 update for v4.16-rc1

nios2: defconfig: Cleanup from old Kconfig options
nios2: dts: Remove leading 0x and 0s from bindings notation

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      nios2: defconfig: Cleanup from old Kconfig options

Mathieu Malaterre (1):
      nios2: dts: Remove leading 0x and 0s from bindings notation

 arch/nios2/boot/dts/3c120_devboard.dts | 16 ++++++++--------
 arch/nios2/configs/10m50_defconfig     |  1 -
 arch/nios2/configs/3c120_defconfig     |  1 -
 3 files changed, 8 insertions(+), 10 deletions(-)
