Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932214AbeCKNtq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 09:49:46 -0400
Received: from foss.arm.com ([217.140.101.70]:44998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932136AbeCKNtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 09:49:46 -0400
From: Marc Zyngier <marc.zyngier@arm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] irqchip updates for 4.16-rc5
Date: Sun, 11 Mar 2018 13:49:22 +0000
Message-Id: <20180311134922.22696-1-marc.zyngier@arm.com>
X-Mailer: git-send-email 2.14.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

Here's a few patches I've collected for the irqchip tree. Nothing
fancy, just cleanups and a small corner case fix for the GICv3 ITS.

Please pull,

	M.

The following changes since commit 0b24a0bbe2147815d982d9335c41bb10c04f40bc:

  irqdomain: Re-use DEFINE_SHOW_ATTRIBUTE() macro (2018-02-16 14:22:34 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git tags/irqchip-4.16-3

for you to fetch changes up to 61b8b22858b9cfa5df52fc0e4893aebfe0bbb804:

  irqchip/irq-imx-gpcv2: Remove unused function (2018-03-11 13:27:12 +0000)

----------------------------------------------------------------
irqchip updates for 4.16-rc5

- IMX GPCv2 cleanup
- GICv3 iomem annontation fixes
- GICv3 ITS minimal ITE allocation now matching the LPIs'.

----------------------------------------------------------------
Ard Biesheuvel (1):
      irqchip/gic-v3-its: Ensure nr_ites >= nr_lpis

Fabio Estevam (1):
      irqchip/irq-imx-gpcv2: Remove unused function

Robin Murphy (1):
      irqchip/gic-v3-its: Fix misplaced __iomem annotations

 drivers/irqchip/irq-gic-v3-its.c | 13 ++++++-------
 drivers/irqchip/irq-imx-gpcv2.c  | 14 --------------
 2 files changed, 6 insertions(+), 21 deletions(-)
