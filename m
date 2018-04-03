Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932169AbeDCMzL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 08:55:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59469 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932087AbeDCMzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 08:55:09 -0400
Date: Tue, 3 Apr 2018 14:55:07 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ming Lei <ming.lei@redhat.com>
cc: Artem Bityutskiy <dedekind1@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
In-Reply-To: <20180330031554.GC12412@ming.t460p>
Message-ID: <alpine.DEB.2.21.1804031435450.2511@nanos.tec.linutronix.de>
References: <20180308105358.1506-1-ming.lei@redhat.com> <1520515113.20980.31.camel@gmail.com> <20180308133440.GA2713@ming.t460p> <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de> <20180309012458.GD5228@ming.t460p> <alpine.DEB.2.21.1803091107520.1364@nanos.tec.linutronix.de>
 <20180309120833.GB30257@ming.t460p> <alpine.DEB.2.21.1803091531000.1364@nanos.tec.linutronix.de> <20180330031554.GC12412@ming.t460p>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ming,

On Fri, 30 Mar 2018, Ming Lei wrote:
> On Fri, Mar 09, 2018 at 04:08:19PM +0100, Thomas Gleixner wrote:
> > Thoughts?
> 
> Given this patchset doesn't have effect on normal machines without
> supporting physical CPU hotplug, it can fix performance regression on
> machines which might support physical CPU hotplug(cpu_present_mask !=
> cpu_possible_mask) with some extra memory allocation cost.
>
> So is there any chance to make it in v4.17?

Sorry, that thing fell through the cracks. I'll queue it now and try to do
a pull request late in the merge window.

Thanks,

	tglx
