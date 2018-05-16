Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeEPPnN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:43:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:49274 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750935AbeEPPnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:43:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,406,1520924400";
   d="scan'208";a="56429778"
Message-ID: <1526485391.61700.15.camel@linux.intel.com>
Subject: Re: [RFC/RFT] [PATCH 00/10] Intel_pstate: HWP Dynamic performance
 boost
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Juri Lelli <juri.lelli@gmail.com>
Cc: tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org, bp@suse.de,
        lenb@kernel.org, rjw@rjwysocki.net, mgorman@techsingularity.net,
        x86@kernel.org, linux-pm@vger.kernel.org, viresh.kumar@linaro.org,
        juri.lelli@arm.com, linux-kernel@vger.kernel.org
Date: Wed, 16 May 2018 08:43:11 -0700
In-Reply-To: <20180516064943.GA28366@localhost.localdomain>
References: <20180516044911.28797-1-srinivas.pandruvada@linux.intel.com>
         <20180516064943.GA28366@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,

On Wed, 2018-05-16 at 08:49 +0200, Juri Lelli wrote:
> Hi Srinivas,
> 
> On 15/05/18 21:49, Srinivas Pandruvada wrote:
> 
> [...]
> 
> > 
> > Peter Zijlstra (1):
> >   x86,sched: Add support for frequency invariance
> 
> Cool! I was going to ask Peter about this patch. You beat me to it.
> :)
> 
> I'll have a lokk at the set. BTW, just noticed that you Cc-ed me
> using
> my old address. Please use juri.lelli@redhat.com. ;)
I didn't realize that. From next revision I will change to this
address.

Thanks,
Srinivas


> 
> Best,
> 
> - Juri
