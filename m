Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbeEMG77 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 02:59:59 -0400
Received: from verein.lst.de ([213.95.11.211]:59175 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbeEMG77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 02:59:59 -0400
Date: Sun, 13 May 2018 09:03:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: another branch for linux-next
Message-ID: <20180513070359.GA25669@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

can you please add the for-linus branch of

   git://git.infradead.org/users/hch/dma-mapping.git

to linux-next?  You already carry the for-next branch, but it turns
out I'll need another branch for late fixes so that for-next can
remain unmerged and unrebased.
