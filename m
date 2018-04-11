Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752755AbeDKMWU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:22:20 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35774 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbeDKMWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:22:18 -0400
X-Google-Smtp-Source: AIpwx4/kBC9IFzFGbSyi1IpnEqoiWvSPhAshLIRnUmtD00QNK6AidKunGWkRiZOHUqKwuPLwBT1CHA==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.17-rc1
Date: Wed, 11 Apr 2018 14:22:15 +0200
Message-Id: <1523449335-15724-1-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.17-rc1. Details about
the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 17dec0a949153d9ac00760ba2f5b78cb583e995f:

  Merge branch 'userns-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace (2018-04-03 19:15:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.17-2

for you to fetch changes up to fc167daff581c01ebce8695e9618231cae3561a1:

  mmc: tmio: Fix error handling when issuing CMD23 (2018-04-04 12:21:27 +0200)

----------------------------------------------------------------
MMC core:
 - Prevent bus reference leak in mmc_blk_init()

MMC host:
 - tmio: Fix error handling when issuing CMD23
 - jz4740: Fix race condition in IRQ mask update

----------------------------------------------------------------
Alex Smith (1):
      mmc: jz4740: Fix race condition in IRQ mask update

Alexander Kappner (1):
      mmc: core: Prevent bus reference leak in mmc_blk_init()

Masaharu Hayakawa (1):
      mmc: tmio: Fix error handling when issuing CMD23

 drivers/mmc/core/block.c         | 1 +
 drivers/mmc/host/jz4740_mmc.c    | 2 +-
 drivers/mmc/host/tmio_mmc_core.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)
