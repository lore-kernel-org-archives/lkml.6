Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751120AbeBQKH7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 05:07:59 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39720 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbeBQKH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 05:07:58 -0500
X-Google-Smtp-Source: AH8x227psZo8Y9ep6clh6rofBlbdPu49+WbMAPbHQK1exw/PdKCs3zJVVkmEtr4hTf+St3yE8MTMSg==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v.4.16-rc2
Date: Sat, 17 Feb 2018 11:07:44 +0100
Message-Id: <1518862064-26269-1-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v4.16-rc2. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v4.16-rc1

for you to fetch changes up to 118032be389009b07ecb5a03ffe219a89d421def:

  mmc: bcm2835: Don't overwrite max frequency unconditionally (2018-02-14 11:30:10 +0100)

----------------------------------------------------------------
MMC host:
 - meson-gx: Revert to earlier tuning process
 - bcm2835: Don't overwrite max frequency unconditionally

----------------------------------------------------------------
Jerome Brunet (1):
      Revert "mmc: meson-gx: include tx phase in the tuning process"

Phil Elwell (1):
      mmc: bcm2835: Don't overwrite max frequency unconditionally

 drivers/mmc/host/bcm2835.c      |  3 ++-
 drivers/mmc/host/meson-gx-mmc.c | 19 +------------------
 2 files changed, 3 insertions(+), 19 deletions(-)
