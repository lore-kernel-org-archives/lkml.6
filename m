Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeEQIYZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 04:24:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:53140 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbeEQIYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 04:24:23 -0400
Date: Thu, 17 May 2018 10:23:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, viresh.kumar@linaro.org
Subject: Re: [UPDATE][RFC/RFT][PATCH 07/10] cpufreq: intel_pstate: HWP boost
 performance on busy task migrate
Message-ID: <20180517082353.GN12217@hirez.programming.kicks-ass.net>
References: <20180516205111.22231-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516205111.22231-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 01:51:11PM -0700, Srinivas Pandruvada wrote:
> @@ -263,6 +264,7 @@ struct cpudata {
>  	call_single_data_t csd;
>  	bool hwp_boost_active;
>  	u64 last_io_update;
> +	bool migrate_hint;
>  };

You want to look at that structure layout...
