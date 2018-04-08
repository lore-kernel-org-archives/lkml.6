Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752790AbeDHDT3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 23:19:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752463AbeDHDT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 23:19:27 -0400
Date: Sun, 8 Apr 2018 11:19:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 4/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
Message-ID: <20180408031912.GA24737@ming.t460p>
References: <20180308105358.1506-1-ming.lei@redhat.com>
 <20180308105358.1506-5-ming.lei@redhat.com>
 <alpine.DEB.2.21.1804031522480.2511@nanos.tec.linutronix.de>
 <20180403160001.GA25255@ming.t460p>
 <alpine.DEB.2.21.1804041017530.2056@nanos.tec.linutronix.de>
 <20180404150759.GA24824@ming.t460p>
 <alpine.DEB.2.21.1804042027130.1492@nanos.tec.linutronix.de>
 <20180406091257.GA9605@ming.t460p>
 <alpine.DEB.2.21.1804061145180.1982@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1804062348080.1533@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804062348080.1533@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 11:49:47PM +0200, Thomas Gleixner wrote:
> On Fri, 6 Apr 2018, Thomas Gleixner wrote:
> 
> > On Fri, 6 Apr 2018, Ming Lei wrote:
> > > 
> > > I will post V4 soon by using cpu_present_mask in the 1st stage irq spread.
> > > And it should work fine for Kashyap's case in normal cases.
> > 
> > No need to resend. I've changed it already and will push it out after
> > lunch.
> 
> No. Lunch did not last that long :)
> 
> I pushed out the lot to
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
> 
> Please double check the modifications I did. The first related commit fixes
> an existing error handling bug.

I think your modification is better, especially about adding comment in
irq_create_affinity_masks().

I also testes these patches again, and they just work fine.

Thanks,
Ming
