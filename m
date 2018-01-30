Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbeA3NZ7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 08:25:59 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:37501 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751727AbeA3NZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 08:25:58 -0500
Date: Tue, 30 Jan 2018 14:25:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180130132553.GT2249@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <20180130104555.4125-5-mgorman@techsingularity.net>
 <20180130115054.GA2269@hirez.programming.kicks-ass.net>
 <20180130125718.iwntjuvcp3yplvdx@techsingularity.net>
 <1517318144.10272.6.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517318144.10272.6.camel@gmx.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 02:15:44PM +0100, Mike Galbraith wrote:
> On Tue, 2018-01-30 at 12:57 +0000, Mel Gorman wrote:
> > On Tue, Jan 30, 2018 at 12:50:54PM +0100, Peter Zijlstra wrote:
> > 
> > > Mel, what hardware are you testing this on?
> > 
> > The primary one was a single socket skylake machine with 8 threads (HT
> > enabled).
> 
> I took it for a spin in a 2 x Gold 6152 box.

Can you translate that marketing speak for a simpleton like me? That's
what we should've called SKL-EP, right?
