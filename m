Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbeBCVie (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 16:38:34 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42123 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753953AbeBCViZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 16:38:25 -0500
X-Google-Smtp-Source: AH8x2267LrM1ZRyb1XxZ30H2+ZICdW7KgkEsfvDKKt2zOD+JJielxgCUhIrSt5pfaS736QfqOYbH8A==
Date: Sat, 3 Feb 2018 13:38:21 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
        Juri Lelli <juri.lelli@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based
 events
Message-ID: <20180203213820.qhsfubqpgndcbfqh@ast-mbp>
References: <20180202230458.840252014@goodmis.org>
 <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
 <20180203140217.2382df69@gandalf.local.home>
 <20180203205207.mpob4w6eyehhg2ky@ast-mbp>
 <20180203161732.4a65c66b@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180203161732.4a65c66b@gandalf.local.home>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 04:17:32PM -0500, Steven Rostedt wrote:
> On Sat, 3 Feb 2018 12:52:08 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> > It's a user space job.
> 
> BTW, I asked around at DevConf.cz, and nobody I talked with (besides
> Arnaldo), have used eBPF. The "path to hello world" is quite high. This
> interface is extremely simple to use, and one doesn't need to install
> LLVM or other tools to interface with it.
> 
> I used the analogy, that eBPF is like C, and this is like Bash. One is
> much easier to get "Hello World!" out than the other.
> 
> So personally, this is something I know I would use (note, I have
> never used eBPF either). But if I'm the only one to use this
> interface then I'll stop here (and not bother with the function graph
> return interface). If others think this would be helpful, I would ask
> them to speak up now.

I'm not arguing against the patches. I know that there are folks
out there who like to use cat/echo interfaces.
I'm only happy that the whole thing has its own kconfig
that we can keep off in fb kernels to reduce maintenance/support burden.
Just like we do for all sorts of other kernel features.
