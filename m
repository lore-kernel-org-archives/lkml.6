Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeDFVt5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 17:49:57 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43219 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752412AbeDFVtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 17:49:55 -0400
Date: Fri, 6 Apr 2018 23:49:47 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ming Lei <ming.lei@redhat.com>
cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 4/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
In-Reply-To: <alpine.DEB.2.21.1804061145180.1982@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1804062348080.1533@nanos.tec.linutronix.de>
References: <20180308105358.1506-1-ming.lei@redhat.com> <20180308105358.1506-5-ming.lei@redhat.com> <alpine.DEB.2.21.1804031522480.2511@nanos.tec.linutronix.de> <20180403160001.GA25255@ming.t460p> <alpine.DEB.2.21.1804041017530.2056@nanos.tec.linutronix.de>
 <20180404150759.GA24824@ming.t460p> <alpine.DEB.2.21.1804042027130.1492@nanos.tec.linutronix.de> <20180406091257.GA9605@ming.t460p> <alpine.DEB.2.21.1804061145180.1982@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2018, Thomas Gleixner wrote:

> On Fri, 6 Apr 2018, Ming Lei wrote:
> > 
> > I will post V4 soon by using cpu_present_mask in the 1st stage irq spread.
> > And it should work fine for Kashyap's case in normal cases.
> 
> No need to resend. I've changed it already and will push it out after
> lunch.

No. Lunch did not last that long :)

I pushed out the lot to

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core

Please double check the modifications I did. The first related commit fixes
an existing error handling bug.

Thanks,

	tglx
