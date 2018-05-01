Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751090AbeEAWFA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 18:05:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750780AbeEAWE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 18:04:59 -0400
Date: Tue, 1 May 2018 17:04:58 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: perf: fuzzer causes stack going in wrong direction warnings
Message-ID: <20180501220458.p3rgwzh3jcqt4jmm@treble>
References: <20180109153341.GL6176@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1801091052010.16446@macbook-air>
 <20180109160551.GK3040@hirez.programming.kicks-ass.net>
 <20180109170716.bqmexpmywwr4bwuv@treble>
 <20180111052538.2qhj6oxnc24xumhk@treble>
 <alpine.DEB.2.21.1801111358580.22460@macbook-air>
 <20180111192112.d35nkotzklicd27c@treble>
 <alpine.DEB.2.21.1805010925140.19413@macbook-air>
 <20180501135850.enx4waqd5d7yowlj@treble>
 <alpine.DEB.2.21.1805011557240.19937@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1805011557240.19937@macbook-air>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 03:59:31PM -0400, Vince Weaver wrote:
> On Tue, 1 May 2018, Josh Poimboeuf wrote:
> 
> > Can you try the following patch?
> 
> I applied the patch, but the warnings don't really look that different.
> 
> [   62.220322] WARNING: stack recursion on stack type 4
> [   62.220326] WARNING: can't dereference registers at 000000009ca2e86d for ip swapgs_restore_regs_and_return_to_usermode+0x79/0x87
> [  367.597013] WARNING: stack going in the wrong direction? ip=native_sched_clock+0x9/0x90

Bummer.  I'll need to come up with a patch to dump more info.

-- 
Josh
