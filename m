Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbeBJSJ0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 13:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750880AbeBJSJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 13:09:25 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B682173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=helgaas@kernel.org
Date: Sat, 10 Feb 2018 12:09:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] PCI fixes for v4.16
Message-ID: <20180210180920.GF206223@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI fixes:

  - fix POWER9/powernv INTx regression from the merge window (Alexey
    Kardashevskiy)


The following changes since commit ab8c609356fbe8dbcd44df11e884ce8cddf3739e:

  Merge branch 'pci/spdx' into next (2018-02-01 11:40:07 -0600)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git tags/pci-v4.16-fixes-1

for you to fetch changes up to c591c2e36ccc9a08f265841d2fd68e35327ab3c4:

  powerpc/pci: Fix broken INTx configuration via OF (2018-02-10 11:49:56 -0600)

----------------------------------------------------------------
pci-v4.16-fixes-1

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      powerpc/pci: Fix broken INTx configuration via OF

 arch/powerpc/kernel/pci-common.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
