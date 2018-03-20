Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbeCTE0X (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 00:26:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:58959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750991AbeCTE0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 00:26:20 -0400
Message-ID: <1521519941.24215.2.camel@gmx.de>
Subject: Re: [PATCH v4] cpuset: Enable cpuset controller in default hierarchy
From: Mike Galbraith <efault@gmx.de>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, torvalds@linux-foundation.org,
        Roman Gushchin <guro@fb.com>
Date: Tue, 20 Mar 2018 05:25:41 +0100
In-Reply-To: <a334a234-3e87-a9a7-9589-8476fecb4149@redhat.com>
References: <1c3fe7b0-2600-c46d-1527-d3aaf024bb91@redhat.com>
         <1520619426.27998.18.camel@gmx.de>
         <55809fe4-98ba-5566-86ed-457acfef0e1c@redhat.com>
         <1520624424.27998.76.camel@gmx.de>
         <53de9683-01b7-bac4-8b70-dc1f93ede600@redhat.com>
         <20180309221736.GB5926@hirez.programming.kicks-ass.net>
         <f0fca497-e4e7-3dbd-1e5c-a7f502c05dcb@redhat.com>
         <1520653648.12749.20.camel@gmx.de>
         <20180314195711.GD2943022@devbig577.frc2.facebook.com>
         <1521082141.7100.1.camel@gmx.de>
         <20180319153413.GO2943022@devbig577.frc2.facebook.com>
         <1521492550.16869.1.camel@gmx.de>
         <a334a234-3e87-a9a7-9589-8476fecb4149@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:VM1t3E95PZHGr+bysSU2O2GLczFVYwZWolEXaV0BPzLIKtLyH6K
 EcuUHpGyDWkJ3+RmlQScq0YrRHvyJkC0uZetDcR+oO6B/GUckgXn8PmuzBuJnKT6Rwzc8Ez
 rPwSP59szbnM4GRQy/UnA6en5vOb+ze2OBQHbBx9fLgxAk/CZElwoak5apE9Vc3jk2Nthdb
 36v+ULUJCSxv6ARg4maeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:b2c1fpsRohQ=:lW50M50nFR6nJxupSmY2m4
 G6fE0Ndr4NVxMtk+NrhFQsIr3AbOWTH7JrIV+TxQpihlMRlMWdnJMA5h1/KtZlT6fcuGvy6oK
 BcI6V1gMsqxF+Fjiau828d3aDE4GSLGKMxQjAugBWirGsHFzYr7n0egHFQBCe0HMAuXkVottW
 wyY1/1OwQ9/I82OYJPA32YZx7s8T4aj+MM/BcI8eeEaIOd/z4hxZF3QLkIwtcEz9GmXLE9tUm
 6r8ZiW+gYaY6mRzAq4orE9epPGzRAhk6XiJH2jUopDRkis9kIFU6Ml7r8BEYK2Sc5Lvb5olPV
 fCZqjfk0hfsUTFT55AJS+n0HqXI5S4MRTRonSOqecJ6cQOAMw9Hb29SBMEH5RrTUPAPMFy+G/
 S2XRONczGTRRaAPzDTqUNvT2zR4JsittJ4hb0c+o2J9DinzPhKpE0xEH0z7rb6KozKr7UY9rK
 W6SQGbB82nl4jscz1EijcyvPo1Ziktld1XJx9ZI65tjK/ewZ+DNFlkb8XS4aETnEZJzvMe7Pm
 mF/771ylaXYVMzuTl+cC3yaIZ+a6/M97OZzlSKPDXGrC5+TlyQnDCTBchtoEkEKH2jioGLlMy
 fj3OZbYSmZQ4ITYRryIJqZre/fumWm1BXjoqE4NYZG5tRFsSS2KoohQP9n677hQWWpDeJ3H/4
 KWIsBoDAu2q1JntxDzRrCDTFobozpFvc5yX6Lj3nOmKDXJ7wNau1xNjM4p5/NqyS0t2sbuoYL
 8NG9nVMe3CIqUEFVQF+WhUOohB6hT5E3eEVrvlK2Rh0gMbtgEL3Sr631vNXG7d7krDOXEDo0i
 hNXgE674OJ6d/Lmx06x8pMKDkg0SB5bvSWbAwmtKRTZgJmSqI4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-03-19 at 17:41 -0400, Waiman Long wrote:
> On 03/19/2018 04:49 PM, Mike Galbraith wrote:
> > On Mon, 2018-03-19 at 08:34 -0700, Tejun Heo wrote:
> >> Hello, Mike.
> >>
> >> On Thu, Mar 15, 2018 at 03:49:01AM +0100, Mike Galbraith wrote:
> >>> Under the hood v2 details are entirely up to you.  My input ends at
> >>> please don't leave dynamic partitioning standing at the dock when v2
> >>> sails.
> >> So, this isn't about implementation details but about what the
> >> interface achieves - ie, what's the actual function?  The only thing I
> >> can see is blocking the entity which is configuring the hierarchy from
> >> making certain configs.  While that might be useful in some specific
> >> use cases, it seems to miss the bar for becoming its own kernel
> >> feature.  After all, nothing prevents the same entity from clearing
> >> the exlusive bit and making the said changes.
> > Yes, privileged contexts can maliciously or stupidly step all over one
> > other no matter what you do (finite resource), but oxymoron creation
> > (CPUs simultaneously balanced and isolated) should be handled.  If one
> > context can allocate a set overlapping a set another context intends to
> > or already has detached from scheduler domains, both are screwed.
> >
> > 	-Mike
> 
> The allocations of CPUs to child cgroups should be controlled by the
> parent cgroup. It is the parent's fault if some CPUs are in both
> balanced and isolated cgroups.
> 
> How about we don't allow turning off scheduling if the CPUs aren't
> exclusive from the parent's perspective? So you can't create an isolated
> cgroup if the CPUs aren't exclusive. Will this be a good enough compromise?

Sure.  The kernel need only ensure its own sanity.  Userspace conflicts
are more or less a non-issue.  In practice, all players but one will
have been constrained or eliminated prior to any partitioning.

	-Mike
