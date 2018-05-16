Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeEPPq2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:46:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:33242 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750775AbeEPPqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:46:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,406,1520924400";
   d="scan'208";a="229031108"
Message-ID: <1526485584.61700.19.camel@linux.intel.com>
Subject: Re: [RFC/RFT] [PATCH 10/10] cpufreq: intel_pstate: enable boost for
 SKX
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@suse.de, lenb@kernel.org,
        rjw@rjwysocki.net, mgorman@techsingularity.net, x86@kernel.org,
        linux-pm@vger.kernel.org, viresh.kumar@linaro.org, juri.lelli@arm.com,
        linux-kernel@vger.kernel.org
Date: Wed, 16 May 2018 08:46:24 -0700
In-Reply-To: <20180516074948.GZ12217@hirez.programming.kicks-ass.net>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
         <20180516044911.28797-11-srinivas.pandruvada@linux.intel.com>
         <20180516074948.GZ12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-05-16 at 09:49 +0200, Peter Zijlstra wrote:
> On Tue, May 15, 2018 at 09:49:11PM -0700, Srinivas Pandruvada wrote:
> > Enable HWP boost on Skylake server platform.
> 
> Why not unconditionally enable it on everything HWP ?
Never noticed in any difference performance in clients with HWP nor
anybody complained. Since clients uses single power domain, some other
CPUs always gives boost. 

Thanks,
Srinivas
