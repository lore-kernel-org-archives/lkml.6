Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936056AbeEYIQ4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 04:16:56 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41653 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935951AbeEYIQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 04:16:55 -0400
X-Google-Smtp-Source: ADUXVKIu/LMD1KRYgyLkgWBiZKr81raCO3ylbqnrm2cu40FlgRh7fIa1q7qNKEY/f4UFdsDozhCNMA==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.17-rc7
Date: Fri, 25 May 2018 10:16:52 +0200
Message-Id: <1527236212-10125-1-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.14-rc7. Details about
the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.17-rc3

for you to fetch changes up to 3de06d5a1f05c11c94cbb68af14dbfa7fb81d78b:

  mmc: sdhci-iproc: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for cygnus (2018-05-21 13:27:22 +0200)

----------------------------------------------------------------
MMC core:
 - Propagate correct error code for RPMB requests

MMC host:
 - sdhci-iproc: Drop hard coded cap for 1.8v
 - sdhci-iproc: Fix 32bit writes for transfer mode
 - sdhci-iproc: Enable SDHCI_QUIRK2_HOST_OFF_CARD_ON for cygnus

----------------------------------------------------------------
Corneliu Doban (2):
      mmc: sdhci-iproc: fix 32bit writes for TRANSFER_MODE register
      mmc: sdhci-iproc: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for cygnus

Mathieu Malaterre (1):
      mmc: block: propagate correct returned value in mmc_rpmb_ioctl

Srinath Mannam (1):
      mmc: sdhci-iproc: remove hard coded mmc cap 1.8v

 drivers/mmc/core/block.c       |  2 +-
 drivers/mmc/host/sdhci-iproc.c | 33 ++++++++++++++++++++++++++-------
 2 files changed, 27 insertions(+), 8 deletions(-)
