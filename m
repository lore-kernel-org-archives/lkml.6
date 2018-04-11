Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeDKOpC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 10:45:02 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:42387 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeDKOpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 10:45:00 -0400
X-Google-Smtp-Source: AIpwx49fdwF+O3O5AbwRXLzrl7tE82JEsYBmFMAtDQuMjR2iHksWO8SlkT75Fo6sLHJY44q100n3IA==
Date: Wed, 11 Apr 2018 20:14:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2] cpufreq/schedutil: Cleanup, document and fix iowait
 boost
Message-ID: <20180411144456.GP7671@vireshk-i7>
References: <20180410155931.31973-1-patrick.bellasi@arm.com>
 <20180411043726.GJ7671@vireshk-i7>
 <20180411104824.GN14248@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180411104824.GN14248@e110439-lin>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-04-18, 11:48, Patrick Bellasi wrote:
> On 11-Apr 10:07, Viresh Kumar wrote:
> > On 10-04-18, 16:59, Patrick Bellasi wrote:

> > The above part should be a different patch with this:
> > 
> > Fixes: a5a0809bc58e ("cpufreq: schedutil: Make iowait boost more energy efficient")
> 
> You mean to split out on a separate patch the fix for the iowait boost
> on per-cpu policies?

Right.

> > And the rest is just code rearrangement. And as Peter said, we better
> > have a routine to clear boost values on delta > TICK_NSEC.
> 
> Right, already commented in reply to Peter. I'll split in two patches:
> one for documentation and code re-organization and a second one for
> the fix to the issue you pointed out.

Thanks.

-- 
viresh
