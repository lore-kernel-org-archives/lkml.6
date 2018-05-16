Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbeEPP0d (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750835AbeEPP0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:26:32 -0400
Date: Wed, 16 May 2018 11:26:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 10/14] tracing: Document trace_marker triggers
Message-ID: <20180516112628.7f6970e0@gandalf.local.home>
In-Reply-To: <1526484147.11544.6.camel@tzanussi-mobl.amr.corp.intel.com>
References: <20180514205845.017925650@goodmis.org>
        <20180514205958.769987842@goodmis.org>
        <1526334427.26800.15.camel@tzanussi-mobl.amr.corp.intel.com>
        <20180516095534.676d7938@gandalf.local.home>
        <1526484147.11544.6.camel@tzanussi-mobl.amr.corp.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018 10:22:27 -0500
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Sure, but noticed in the new version you just posted, that this line is
> still in there for your second example:
> 
> + # echo '!hist:keys=common_pid:vals=hitcount:lat=common_timestamp.usecs-$ts0:sort=hitcount:size=2048:clock=global:onmatch(sched.sched_switch).latency($lat) if buf == "end"' > events/ftrace/print/trigger
> 
> Did you intend that, or am I missing something?

No, I am. From my reply, you can see I skipped it. I totally missed
that comment. I'll update that too.


> 
> Anyway, you have my
> 
> Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thanks!

-- Steve
