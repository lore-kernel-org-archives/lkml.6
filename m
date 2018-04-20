Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbeDTIgV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:36:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbeDTIgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:36:20 -0400
Date: Fri, 20 Apr 2018 10:36:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: Jiri Olsa <jolsa@redhat.com>, Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>, mingo@elte.hu,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC] perf/core: what is exclude_idle supposed to do
Message-ID: <20180420083607.GG4064@hirez.programming.kicks-ass.net>
References: <CABPqkBS6MuO6Twtq=_+TDV=RNy0_2vRWf=LVCk6wk0tPwNSTog@mail.gmail.com>
 <20180417062010.GA2052@krava>
 <alpine.DEB.2.21.1804181109100.1587@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804181109100.1587@macbook-air>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 11:10:20AM -0400, Vince Weaver wrote:
> On Tue, 17 Apr 2018, Jiri Olsa wrote:
> 
> > On Mon, Apr 16, 2018 at 10:04:53PM +0000, Stephane Eranian wrote:
> > > Hi,
> > > 
> > > I am trying to understand what the exclude_idle event attribute is supposed
> > > to accomplish.
> > > As per the definition in the header file:
> > > 
> > >     exclude_idle   :  1, /* don't count when idle */
> > 
> > AFAICS it's not implemented
> 
> so just to be completely clear hear, we're saying that the "exclude_idle" 
> modifier has never done anything useful and still doesn't?

AFAICT it works on Power and possibly ARM.
