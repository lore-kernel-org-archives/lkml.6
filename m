Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753604AbeDTGvx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 02:51:53 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39492 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752771AbeDTGvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 02:51:51 -0400
X-Google-Smtp-Source: AB8JxZoRAReuW6HnnRO1mALqun0igj+syZ9Xm+yvskFhgJMBruYu6KZgRLcienN4c/MMGNzBKt8qUw==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.17-rc2
Date: Fri, 20 Apr 2018 08:51:47 +0200
Message-Id: <1524207107-3397-1-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.17-rc2. Details about
the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit fc167daff581c01ebce8695e9618231cae3561a1:

  mmc: tmio: Fix error handling when issuing CMD23 (2018-04-04 12:21:27 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.17-3

for you to fetch changes up to 0cbc94daa55441c21999e96a07061952d873dcb7:

  mmc: renesas_sdhi_internal_dmac: limit DMA RX for old SoCs (2018-04-19 14:57:17 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-pci: Fixup tuning for AMD for eMMC HS200 mode
 - renesas_sdhi_internal_dmac: Avoid data corruption by limiting DMA RX

----------------------------------------------------------------
Daniel Kurtz (1):
      mmc: sdhci-pci: Only do AMD tuning for HS200

Wolfram Sang (1):
      mmc: renesas_sdhi_internal_dmac: limit DMA RX for old SoCs

 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 39 ++++++++++++++++++++++-----
 drivers/mmc/host/sdhci-pci-core.c             | 25 +++++++++++++++--
 2 files changed, 56 insertions(+), 8 deletions(-)
