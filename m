Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753469AbeDLTJ4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 15:09:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753072AbeDLTJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 15:09:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C82205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Thu, 12 Apr 2018 14:09:51 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Desnes A. Nunes do Rosario" <desnesn@linux.vnet.ibm.com>,
        Sinan Kaya <okaya@codeaurora.org>
Subject: [GIT PULL] PCI changes for v4.17, part 2
Message-ID: <20180412190705.GA46420@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI changes:

  - mark Extended Tags as broken on Broadcom HT1100 and HT2000 Root Ports
    to fix drm/Xorg hangs and unresponsive keyboards (Sinan Kaya)

  - remove useless messages during resource reassignment (Desnes A. Nunes
    do Rosario)


The following changes since commit c18bb396d3d261ebbb4efbc05129c5d354c541e4:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-04-09 17:04:10 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.17-changes-2

for you to fetch changes up to adf58458bcb2890efe94e5a58506c27bfecf518d:

  PCI: Remove messages about reassigning resources (2018-04-11 08:46:50 -0500)

----------------------------------------------------------------
pci-v4.17-changes-2

----------------------------------------------------------------
Desnes A. Nunes do Rosario (1):
      PCI: Remove messages about reassigning resources

Sinan Kaya (1):
      PCI: Mark Broadcom HT1100 and HT2000 Root Port Extended Tags as broken

 drivers/pci/pci.c       | 1 -
 drivers/pci/quirks.c    | 4 ++++
 drivers/pci/setup-res.c | 2 --
 3 files changed, 4 insertions(+), 3 deletions(-)
