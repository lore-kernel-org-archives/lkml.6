Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbeC1IHL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:07:11 -0400
Received: from verein.lst.de ([213.95.11.211]:44449 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752538AbeC1IHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:07:07 -0400
Date: Wed, 28 Mar 2018 10:07:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: unexport nvme_start_keep_alive
Message-ID: <20180328080706.GC20373@lst.de>
References: <20180326084015.9269-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326084015.9269-1-jthumshirn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 10:40:15AM +0200, Johannes Thumshirn wrote:
> nvme_start_keep_alive() isn't used outside core.c so unexport it and
> make it static.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
