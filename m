Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeECHOp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 03:14:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48918 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbeECHOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 03:14:41 -0400
Date: Thu, 3 May 2018 09:14:34 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma mapping fix for 4.17-rc4
Message-ID: <20180503071434.GA13895@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2d618bdf71635463a4aa4ad0fe46ec852292bc0c:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rkuo/linux-hexagon-kernel (2018-05-01 19:54:22 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.17-4

for you to fetch changes up to 892a0be43edd63e1cd228af3453a064e9e94f08e:

  swiotlb: fix inversed DMA_ATTR_NO_WARN test (2018-05-02 14:48:55 +0200)

----------------------------------------------------------------
Fix an incorrect warning selection introduces in the last merge window.

----------------------------------------------------------------
Michel Dänzer (1):
      swiotlb: fix inversed DMA_ATTR_NO_WARN test

 lib/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
