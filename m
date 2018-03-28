Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752474AbeC1IGu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 04:06:50 -0400
Received: from verein.lst.de ([213.95.11.211]:44443 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751981AbeC1IGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 04:06:47 -0400
Date: Wed, 28 Mar 2018 10:06:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Baegjae Sung <baegjae@gmail.com>
Cc: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-multipath: implement active-active round-robin
        path selector
Message-ID: <20180328080646.GB20373@lst.de>
References: <20180327043851.6640-1-baegjae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327043851.6640-1-baegjae@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For PCIe devices the right policy is not a round robin but to use
the pcie device closer to the node.  I did a prototype for that
long ago and the concept can work.  Can you look into that and
also make that policy used automatically for PCIe devices?
