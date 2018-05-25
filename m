Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967650AbeEYSHg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967452AbeEYSHf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:07:35 -0400
Date: Fri, 25 May 2018 14:07:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Namhyung Kim <namhyung@kernel.org>, Yann Ylavic <ylavic.dev@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3 13/14] tracing/selftest: Add selftests to test
 trace_marker histogram triggers
Message-ID: <20180525140731.07d7543a@gandalf.local.home>
In-Reply-To: <20180523231331.bf69453f05478e11b00451ab@kernel.org>
References: <20180516150012.135869655@goodmis.org>
        <20180516150201.246539183@goodmis.org>
        <20180523231331.bf69453f05478e11b00451ab@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 May 2018 23:13:31 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> This looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> BTW, would you plan to add simplar test case for the marker?
> (like just write a marker and read trace log, and run a simple
>  trigger, like taking a snapshot by marker)

I wasn't planning to, but I could.

-- Steve
