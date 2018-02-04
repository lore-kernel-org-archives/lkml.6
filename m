Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbeBDCZt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 21:25:49 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34902 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeBDCZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 21:25:42 -0500
X-Google-Smtp-Source: AH8x225/24834nEumHoOhy50UYstqJPOg5o+aKhcJp/WhfItYv9ubjCymAH96bPdYqfGo8AZg8G/0nCUGRA6doG2VYA=
MIME-Version: 1.0
In-Reply-To: <20180203161732.4a65c66b@gandalf.local.home>
References: <20180202230458.840252014@goodmis.org> <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
 <20180203140217.2382df69@gandalf.local.home> <20180203205207.mpob4w6eyehhg2ky@ast-mbp>
 <20180203161732.4a65c66b@gandalf.local.home>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 4 Feb 2018 11:25:20 +0900
X-Google-Sender-Auth: JZnq00P2YkSbYl5mOdRRGNRsnVQ
Message-ID: <CAM9d7cgmWmo6S30fLg6Zdk5ic8a3UJOjYSo3C55CcG=NBz6mhQ@mail.gmail.com>
Subject: Re: [PATCH 00/18] [ANNOUNCE] Dynamically created function based events
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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

Hi Steve and Alexei,

On Sun, Feb 4, 2018 at 6:17 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Sat, 3 Feb 2018 12:52:08 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
>> It's a user space job.
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

I'm interested in this.  From my understanding, it's basically
function tracing + filter + custom argument info, right?

Supporting arguments with complex type could be error-prone.
We need to prevent malfunctions by invalid inputs.

Thanks,
Namhyung
