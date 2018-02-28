Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932304AbeB1SMZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:12:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932126AbeB1SMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:12:24 -0500
Date: Wed, 28 Feb 2018 10:12:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma-mapping fixe for Linux 4.16
Message-ID: <20180228181218.66ewjh3kyk2duidw@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a638af00b27266c09ab7ac69141e6f4ac6c00eff:

  Merge tag 'usb-4.16-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2018-02-22 12:13:01 -0800)

are available in the git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.16-3

for you to fetch changes up to af1da686843750809738c01e153320106e890804:

  dma-debug: fix memory leak in debug_dma_alloc_coherent (2018-02-22 15:02:33 -0800)

----------------------------------------------------------------
A single fix for a memory leak regression in the dma-debug code.

----------------------------------------------------------------
Miles Chen (1):
      dma-debug: fix memory leak in debug_dma_alloc_coherent

 lib/dma-debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)
