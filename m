Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeDOJIM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 05:08:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:54323 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751065AbeDOJIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 05:08:11 -0400
From: Takashi Iwai <tiwai@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] swiotlb: Some regression fixes
Date: Sun, 15 Apr 2018 11:08:06 +0200
Message-Id: <20180415090808.19121-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a couple of small regression fixes I stumbled on recently.
The first one is a trivial one, and it was already posted in another
thread ("swiotlb: Fix unexpected swiotlb_alloc_coherent() failures").


thanks,

Takashi

===

Takashi Iwai (2):
  dma-direct: Don't repeat allocation for no-op GFP_DMA
  swiotlb: Fix dma_supported() to consider direct allocation

 lib/dma-direct.c | 3 ++-
 lib/swiotlb.c    | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.16.3
