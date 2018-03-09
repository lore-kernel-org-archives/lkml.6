Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeCIHAN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 02:00:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:27643 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750848AbeCIHAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 02:00:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,444,1515484800";
   d="scan'208";a="33627795"
Message-ID: <1520578808.20980.46.camel@gmail.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Ming Lei <ming.lei@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Laurence Oberman <loberman@redhat.com>
Date: Fri, 09 Mar 2018 09:00:08 +0200
In-Reply-To: <20180309012458.GD5228@ming.t460p>
References: <20180308105358.1506-1-ming.lei@redhat.com>
         <1520515113.20980.31.camel@gmail.com> <20180308133440.GA2713@ming.t460p>
         <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de>
         <20180309012458.GD5228@ming.t460p>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-09 at 09:24 +0800, Ming Lei wrote:
> Hi Thomas,
> 
> On Fri, Mar 09, 2018 at 12:20:09AM +0100, Thomas Gleixner wrote:
> > On Thu, 8 Mar 2018, Ming Lei wrote:
> > > Actually, it isn't a real fix, the real one is in the following
> > > two:
> > > 
> > > 	0c20244d458e scsi: megaraid_sas: fix selection of reply queue
> > > 	ed6d043be8cd scsi: hpsa: fix selection of reply queue
> > 
> > Where are these commits? Neither Linus tree not -next know anything
> > about
> > them....
> 
> Both aren't merged yet, but they should land V4.16, IMO.

Is it a secret where they are? If not, could you please give ma a
pointer and I'll give them a test.
