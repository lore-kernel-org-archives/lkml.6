Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965219AbeEYIre (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 04:47:34 -0400
Received: from verein.lst.de ([213.95.11.211]:35653 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964909AbeEYIrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 04:47:33 -0400
Date: Fri, 25 May 2018 10:53:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-pci: set nvmeq->cq_vector after alloc cq/sq
Message-ID: <20180525085311.GB19376@lst.de>
References: <1527155494-1891-1-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527155494-1891-1-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-4.18.
