Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752668AbeEQOwV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:52:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:8473 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752348AbeEQOwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:52:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,411,1520924400";
   d="scan'208";a="225053291"
Message-ID: <1526568739.11765.2.camel@linux.intel.com>
Subject: Re: [UPDATE][RFC/RFT][PATCH 07/10] cpufreq: intel_pstate: HWP boost
 performance on busy task migrate
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, viresh.kumar@linaro.org
Date: Thu, 17 May 2018 07:52:19 -0700
In-Reply-To: <20180517082353.GN12217@hirez.programming.kicks-ass.net>
References: <20180516205111.22231-1-srinivas.pandruvada@linux.intel.com>
         <20180517082353.GN12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-17 at 10:23 +0200, Peter Zijlstra wrote:
> On Wed, May 16, 2018 at 01:51:11PM -0700, Srinivas Pandruvada wrote:
> > @@ -263,6 +264,7 @@ struct cpudata {
> >  	call_single_data_t csd;
> >  	bool hwp_boost_active;
> >  	u64 last_io_update;
> > +	bool migrate_hint;
> >  };
> 
> You want to look at that structure layout...
Yes, I will.
