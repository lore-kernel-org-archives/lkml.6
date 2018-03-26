Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeCZImt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:42:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51826 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeCZIms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:42:48 -0400
Date: Mon, 26 Mar 2018 10:42:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Abderrahmane Benbachir <abderrahmane.benbachir@polymtl.ca>,
        =?iso-8859-1?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH 0/3] [RFC] init, tracing: Add initcall trace events
Message-ID: <20180326084242.GJ4043@hirez.programming.kicks-ass.net>
References: <20180323150241.878778199@goodmis.org>
 <20180323125016.270ea1558fe2499b1a12bfd7@linux-foundation.org>
 <20180323160441.3217664d@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323160441.3217664d@vmware.local.home>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 04:04:41PM -0400, Steven Rostedt wrote:
> I would even argue that we remove the printks and use the trace events
> instead. There's already an option to make trace events be sent to
> printk(). I could have initcall_debug enable the trace events and send
> them to printk.

Those printk()'s are so ever much more useful when you fail to boot and
can't get the trace buffer out.
