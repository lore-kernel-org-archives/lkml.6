Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751773AbeDFTeg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 15:34:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56388 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbeDFTef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 15:34:35 -0400
Date: Fri, 6 Apr 2018 21:34:24 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes (Google)" <joel.opensrc@gmail.com>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
Subject: Re: [PATCH 0/4 v2] init, tracing: Add initcall trace events
Message-ID: <20180406193424.GM4082@hirez.programming.kicks-ass.net>
References: <20180406190854.875810797@goodmis.org>
 <20180406151923.292cb09f@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406151923.292cb09f@gandalf.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 03:19:23PM -0400, Steven Rostedt wrote:
> 
> Peter, Andrew,
> 
> This keeps initcall_debug printing printk()s, but adds the feature of
> those locations also being trace events. Are you OK if I add this?

Yeah, I don't see any real problems with it.
