Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbeCBWO5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 17:14:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752591AbeCBWO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 17:14:56 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672BE217B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Fri, 2 Mar 2018 16:14:54 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christian =?iso-8859-1?Q?K=F6nig?=
        <ckoenig.leichtzumerken@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [GIT PULL] PCI fixes for v4.16
Message-ID: <20180302221454.GA12069@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI fixes:

  - Update pci.ids location (documentation only) (Randy Dunlap)

  - Fix a crash when BIOS didn't assign a BAR and we try to enlarge it
    (Christian König)


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.16-fixes-2

for you to fetch changes up to c37406e05d1e541df40b8b81c4bd40753fcaf414:

  PCI: Allow release of resources that were never assigned (2018-02-26 14:51:13 -0600)

----------------------------------------------------------------
pci-v4.16-fixes-2

----------------------------------------------------------------
Christian König (1):
      PCI: Allow release of resources that were never assigned

Randy Dunlap (1):
      PCI: Update location of pci.ids file

 Documentation/PCI/pci.txt | 4 +++-
 drivers/pci/setup-res.c   | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)
