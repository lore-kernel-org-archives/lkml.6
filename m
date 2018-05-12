Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbeELQPP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 12:15:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:27159 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750902AbeELQPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 12:15:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,392,1520924400";
   d="scan'208";a="48726936"
Message-ID: <1526141702.2067.4.camel@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.17-rc5
From: Zhang Rui <rui.zhang@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Date: Sun, 13 May 2018 00:15:02 +0800
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for v4.17-rc5 with
top-most commit 60abce9f43d812dfec6687a10ca30be380f6f97a:

  Merge branch 'thermal-soc' into next (2018-05-11 09:37:21 +0800)

on top of commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

Specifics:

- Fix NULL pointer deref on module load/probe, for int3403_thermal
driver.

- Fix an emergency shutdown issue on exynos thermal driver.


thanks,
rui

----------------------------------------------------------------
Hans de Goede (1):
      thermal: int3403_thermal: Fix NULL pointer deref on module load /
probe

Marek Szyprowski (2):
      thermal: exynos: Reading temperature makes sense only when TMU is
turned on
      thermal: exynos: Propagate error value from tmu_read()

Zhang Rui (1):
      Merge branch 'thermal-soc' into next

 drivers/thermal/int340x_thermal/int3403_thermal.c |  3 +--
 drivers/thermal/samsung/exynos_tmu.c              | 14 +++++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)
