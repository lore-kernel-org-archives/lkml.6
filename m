Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753339AbeCPNoi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:44:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40272 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbeCPNog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:44:36 -0400
Date: Fri, 16 Mar 2018 14:44:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>, tglx@linutronix.de,
        Dmitry.Prohorov@intel.com, alexander.shishkin@linux.intel.com,
        acme@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org,
        vincent.weaver@maine.edu, kan.liang@intel.com, eranian@google.com,
        davidcc@google.com, valery.cherepennikov@intel.com,
        linux-tip-commits@vger.kernel.org
Subject: Re: [PATCH] perf/core: clear sibling list of detached events (was
 "Re: [PATCH] perf: Fix sibling iteration")
Message-ID: <20180316134427.GZ4043@hirez.programming.kicks-ass.net>
References: <tip-8343aae66167df6708128a778e750d48dbe31302@git.kernel.org>
 <20180315170129.GX4043@hirez.programming.kicks-ass.net>
 <0be54adb-a7be-cd2f-dfcb-4166dfe432ea@linux.intel.com>
 <20180316103129.GC4064@hirez.programming.kicks-ass.net>
 <20180316103946.GA6960@krava>
 <20180316105017.GD4064@hirez.programming.kicks-ass.net>
 <20180316131741.3svgr64yibc6vsid@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316131741.3svgr64yibc6vsid@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 01:17:41PM +0000, Mark Rutland wrote:
> I've given this 50 boots with the 0day scripts, and no explosions so far
> (with 5 boots where a leader had an empty group_node).

I've been running this for almost 2 hours now, and no splats either.
I'll let it run for another few hours, just in case.

Thanks Mark!
