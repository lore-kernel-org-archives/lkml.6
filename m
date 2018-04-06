Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeDFTqG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 15:46:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751679AbeDFTqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 15:46:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5EE21720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 6 Apr 2018 15:46:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes (Google)" <joel.opensrc@gmail.com>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>
Subject: Re: [PATCH 0/4 v2] init, tracing: Add initcall trace events
Message-ID: <20180406154602.7d7c6922@gandalf.local.home>
In-Reply-To: <20180406193424.GM4082@hirez.programming.kicks-ass.net>
References: <20180406190854.875810797@goodmis.org>
        <20180406151923.292cb09f@gandalf.local.home>
        <20180406193424.GM4082@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Apr 2018 21:34:24 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Apr 06, 2018 at 03:19:23PM -0400, Steven Rostedt wrote:
> > 
> > Peter, Andrew,
> > 
> > This keeps initcall_debug printing printk()s, but adds the feature of
> > those locations also being trace events. Are you OK if I add this?  
> 
> Yeah, I don't see any real problems with it.

Thanks!

Andrew, do you?

-- Steve
