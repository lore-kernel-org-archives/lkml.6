Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeDPOv6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:51:58 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36096 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbeDPOvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:51:55 -0400
X-Google-Smtp-Source: AIpwx49/9mFR1+kewZx8RBvpwj/5neXEBKdkETTSfUZ5To79Jy/OwxpsIfbMO2byDS86sb/UqLDyHA==
Date: Mon, 16 Apr 2018 08:51:53 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Greg Thelen <gthelen@google.com>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Tarick Bedeir <tarick@google.com>
Subject: Re: [PATCH] IB: make INFINIBAND_ADDR_TRANS configurable
Message-ID: <20180416145153.GA23029@ziepe.ca>
References: <20180413070644.11974-1-gthelen@google.com>
 <20180415120636.GA10759@infradead.org>
 <CAHH2K0ZKqDt2OS1RN7i6qqc=VyPfhzC5sfSSb4ktDdtZnzAhCA@mail.gmail.com>
 <20180416085620.GA30363@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416085620.GA30363@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 01:56:20AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 16, 2018 at 04:02:12AM +0000, Greg Thelen wrote:
> > I think I've identified the set of options which use
> > INFINIBAND_ADDR_TRANS without a kconfig depends:
> > * CIFS_SMB_DIRECT
> > * INFINIBAND_SRPT
> > * NVME_RDMA
> > * NVME_TARGET_RDMA
> > 
> > I have patches for the above, but need to finish the commit logs.  Let me
> > know if they'll be nacked and I'll just patch my kernel and forget
> > upstreaming.
> 
> I think those are what is needed.  But better do a full cycle through
> the build bot first..

Yes, you have to post the full series and have the build bots say it
is clean, collect acks from the various maintainers and then we can
apply the whole thing through RDMA..

I n't want to apply kconfig changes piecemeal, we just get bug reports
from build bots that way.

Jason
