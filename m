Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeDLF55 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 01:57:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60278 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeDLF54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 01:57:56 -0400
Date: Thu, 12 Apr 2018 07:57:51 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] dma mapping fix for 4.17
Message-ID: <20180412055751.GA4908@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b284d4d5a6785f8cd07eda2646a95782373cd01e:

  Merge tag 'ceph-for-4.17-rc1' of git://github.com/ceph/ceph-client (2018-04-10 12:25:30 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-4.17-2

for you to fetch changes up to 9e7f06c8beee304ee21b791653fefcd713f48b9a:

  swiotlb: fix unexpected swiotlb_alloc_coherent failures (2018-04-10 22:30:43 +0200)

----------------------------------------------------------------
Fix for one swiotlb regression in 2.16 from Takashi.

----------------------------------------------------------------
Takashi Iwai (1):
      swiotlb: fix unexpected swiotlb_alloc_coherent failures

 lib/swiotlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
