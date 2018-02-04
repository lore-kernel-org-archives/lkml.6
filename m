Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbeBDCiG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 21:38:06 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42543 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeBDCiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 21:38:02 -0500
X-Google-Smtp-Source: AH8x226vPeCpRvh26bzoEXsZwvDCwWuiIRVD3refdT8EdgvqqUT+MyIQY6QkgIeIUaBpR3H1KFz/lQ4oiMXtNrQGo/M=
MIME-Version: 1.0
In-Reply-To: <20180203213013.b6png725tcehqai3@ast-mbp>
References: <20180202230458.840252014@goodmis.org> <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
 <20180203140217.2382df69@gandalf.local.home> <20180203205207.mpob4w6eyehhg2ky@ast-mbp>
 <20180203160824.42a6c1bb@gandalf.local.home> <20180203213013.b6png725tcehqai3@ast-mbp>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 4 Feb 2018 11:37:40 +0900
X-Google-Sender-Auth: ivEJ-nfQq6atLhQ48HC-lL43zd4
Message-ID: <CAM9d7cjF=Tc00XGmR=Bx91mexnh2svcU=U0mj5qQmQv_kx5GMw@mail.gmail.com>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based events
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>,
        acme <acme@kernel.org>, Clark Williams <williams@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, bristot <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 4, 2018 at 6:30 AM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Sat, Feb 03, 2018 at 04:08:24PM -0500, Steven Rostedt wrote:
>> OK, so no new development in this was wanted? So the entire talk about
>> getting tracepoints into vfs and scheduling wasn't needed?
>
> I don't know who wants tracepoints in vfs.

AFAIK some people wanted to get some info (e.g. filename) from vfs.


>> Not if you are working in the embedded space and only have busybox as
>> your interface.
>
> did you notice bpfd project that does remote kprobe+bpf into an android phone?
> or phone is not an embedded space?

I never tried bpfd yet but it looks promissing.
It'd be nice to have such setup working on a typical yocto environment.
Anyway, I'd say that android phone is different that typical embedded
systems. :)

Thanks,
Namhyung
