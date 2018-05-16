Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751844AbeEPPym (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:54:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeEPPyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:54:41 -0400
Date: Wed, 16 May 2018 17:54:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT] [PATCH 10/10] cpufreq: intel_pstate: enable boost for
 SKX
Message-ID: <20180516155424.GG12198@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
 <20180516044911.28797-11-srinivas.pandruvada@linux.intel.com>
 <20180516074948.GZ12217@hirez.programming.kicks-ass.net>
 <1526485584.61700.19.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526485584.61700.19.camel@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 08:46:24AM -0700, Srinivas Pandruvada wrote:
> On Wed, 2018-05-16 at 09:49 +0200, Peter Zijlstra wrote:
> > On Tue, May 15, 2018 at 09:49:11PM -0700, Srinivas Pandruvada wrote:
> > > Enable HWP boost on Skylake server platform.
> > 
> > Why not unconditionally enable it on everything HWP ?
> Never noticed in any difference performance in clients with HWP nor
> anybody complained. Since clients uses single power domain, some other
> CPUs always gives boost. 

Can't the hardware tell us about per-core stuff? Do we really have to
use tables for that?
