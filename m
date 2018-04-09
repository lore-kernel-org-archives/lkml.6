Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752356AbeDIVTn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 17:19:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751919AbeDIVTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 17:19:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E14E21785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 9 Apr 2018 17:19:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [GIT PULL] tracing: Updates for v4.17
Message-ID: <20180409171935.37054fc7@gandalf.local.home>
In-Reply-To: <20180409132305.16e8f956@gandalf.local.home>
References: <20180409132305.16e8f956@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Apr 2018 13:23:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Linus,
> 
> New features:

BTW, I forgot to mention that there will be some merge conflicts due to
updates to the documentation directory.

The fix by Stephen should work.

 http://lkml.kernel.org/r/20180321153127.23737f6e@canb.auug.org.au

-- Steve

> 
>  - Tom Zanussi's extended histogram work
>    This adds the synthetic events to have histograms from multiple event data
>    Adds triggers "onmatch" and "onmax" to call the synthetic events
>    Several updates to the histogram code from this
> 
>  - Allow way to nest ring buffer calls in the same context
> 
>  - Allow absolute time stamps in ring buffer
> 
>  - Rewrite of filter code parsing based on Al Viro's suggestions
> 
>  - Setting of trace_clock to global if TSC is unstable (on boot)
> 
>  - Better OOM handling when allocating large ring buffers
> 
>  - Added initcall tracepoints (consolidated initcall_debug code with them)
> 
> And other various fixes and clean ups
