Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbeCIHdj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 02:33:39 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750897AbeCIHdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 02:33:38 -0500
Date: Fri, 9 Mar 2018 15:33:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
Message-ID: <20180309073319.GB25709@ming.t460p>
References: <20180308105358.1506-1-ming.lei@redhat.com>
 <1520515113.20980.31.camel@gmail.com>
 <20180308133440.GA2713@ming.t460p>
 <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de>
 <20180309012458.GD5228@ming.t460p>
 <1520578808.20980.46.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520578808.20980.46.camel@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 09:00:08AM +0200, Artem Bityutskiy wrote:
> On Fri, 2018-03-09 at 09:24 +0800, Ming Lei wrote:
> > Hi Thomas,
> > 
> > On Fri, Mar 09, 2018 at 12:20:09AM +0100, Thomas Gleixner wrote:
> > > On Thu, 8 Mar 2018, Ming Lei wrote:
> > > > Actually, it isn't a real fix, the real one is in the following
> > > > two:
> > > > 
> > > > 	0c20244d458e scsi: megaraid_sas: fix selection of reply queue
> > > > 	ed6d043be8cd scsi: hpsa: fix selection of reply queue
> > > 
> > > Where are these commits? Neither Linus tree not -next know anything
> > > about
> > > them....
> > 
> > Both aren't merged yet, but they should land V4.16, IMO.
> 
> Is it a secret where they are? If not, could you please give ma a
> pointer and I'll give them a test.

  https://marc.info/?l=linux-block&m=152056636717380&w=2

Thanks,
Ming
