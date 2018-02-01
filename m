Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751997AbeBAJLq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 04:11:46 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:33729 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeBAJLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 04:11:45 -0500
Date: Thu, 1 Feb 2018 10:11:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180201091137.GX2269@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <20180130125718.iwntjuvcp3yplvdx@techsingularity.net>
 <20180130131531.GD2269@hirez.programming.kicks-ass.net>
 <4353713.vEOq6OHvJN@aspire.rjw.lan>
 <20180131101710.GM2269@hirez.programming.kicks-ass.net>
 <1517420658.83171.208.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517420658.83171.208.camel@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 09:44:18AM -0800, Srinivas Pandruvada wrote:

> Much more throttling required compared to PERF_CTL. MSR_HWP_REQUEST is
> much slower compared to PERF_CTL (as high as 10:1). 

Still much better than what other architectures have to deal with ;-)
