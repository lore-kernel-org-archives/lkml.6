Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbeEOIHP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:07:15 -0400
Received: from verein.lst.de ([213.95.11.211]:40604 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752620AbeEOIHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:07:14 -0400
Date: Tue, 15 May 2018 10:11:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2 1/5] nvme: fix lockdep warning in
        nvme_mpath_clear_current_path
Message-ID: <20180515081131.GA24332@lst.de>
References: <20180515074043.22843-1-jthumshirn@suse.de> <20180515074043.22843-2-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515074043.22843-2-jthumshirn@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good, although I hate having the whole splat in the commit
message..

Reviewed-by: Christoph Hellwig <hch@lst.de>
