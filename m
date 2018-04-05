Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752185AbeDEJTs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:19:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50182 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeDEJTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:19:45 -0400
Date: Thu, 5 Apr 2018 11:19:32 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping updates for 4.17
Message-ID: <20180405091932.GA30280@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Very light this round as the interesting dma mapping changes went
through the x86 tree:

The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.17

for you to fetch changes up to 1f674e16f9ce6eb20ee2e81ae7514737376874de:

  usb: gadget: Add NO_DMA dummies for DMA mapping API (2018-03-16 19:58:28 +0100)

----------------------------------------------------------------
dma-mapping updates for 4.17:
 - provide proper stubs for architectures not supporting dma (Geert)

----------------------------------------------------------------
Geert Uytterhoeven (5):
      dma-mapping: Convert NO_DMA get_dma_ops() into a real dummy
      dma-coherent: Add NO_DMA dummies for managed DMA API
      mm: Add NO_DMA dummies for DMA pool API
      scsi: Add NO_DMA dummies for SCSI DMA mapping API
      usb: gadget: Add NO_DMA dummies for DMA mapping API

 include/linux/dma-mapping.h | 19 ++++++++++++++-----
 include/linux/dmapool.h     | 30 +++++++++++++++++++++++-------
 include/linux/usb/gadget.h  | 12 ++++++++++++
 include/scsi/scsi_cmnd.h    |  5 +++++
 4 files changed, 54 insertions(+), 12 deletions(-)
