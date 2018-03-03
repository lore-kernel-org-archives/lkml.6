Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeCCRsP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 12:48:15 -0500
Received: from merlin.infradead.org ([205.233.59.134]:43274 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752091AbeCCRsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 12:48:14 -0500
Date: Sat, 3 Mar 2018 18:48:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Song Liu <songliubraving@fb.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [RFC] perf: a different approach to perf_rotate_context()
Message-ID: <20180303174808.GJ25201@hirez.programming.kicks-ass.net>
References: <20180301195321.2608515-1-songliubraving@fb.com>
 <20180303152631.GF25201@hirez.programming.kicks-ass.net>
 <E3827285-28C6-4CFD-9990-1FA922CC792C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E3827285-28C6-4CFD-9990-1FA922CC792C@fb.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 03, 2018 at 04:43:16PM +0000, Song Liu wrote:
> > In any case, there's a ton of conflict against the patches here:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=perf/testing
> > 
> > And with those the idea was to move to a virtual time based scheduler
> > (basically schedule those flexible events that have the biggest lag --
> > that also solves 1).
> 
> Thanks for these information. I will study this approach. Maybe that is 
> our path to PMU sharing. 

So I'm really not convinced on that whole PMU sharing.

> What's is the status of this work? Would it 
> land in 4.17? 

These patches might make 4.17, they got held up because of the whole
meltdown/spectre crap and I need to get back to them.
