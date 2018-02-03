Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753933AbeBCVRm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 16:17:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:42228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752802AbeBCVRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 16:17:35 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 871F421707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Sat, 3 Feb 2018 16:17:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
Message-ID: <20180203161732.4a65c66b@gandalf.local.home>
In-Reply-To: <20180203205207.mpob4w6eyehhg2ky@ast-mbp>
References: <20180202230458.840252014@goodmis.org>
        <261141691.15507.1517677454208.JavaMail.zimbra@efficios.com>
        <20180203140217.2382df69@gandalf.local.home>
        <20180203205207.mpob4w6eyehhg2ky@ast-mbp>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Feb 2018 12:52:08 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> It's a user space job.

BTW, I asked around at DevConf.cz, and nobody I talked with (besides
Arnaldo), have used eBPF. The "path to hello world" is quite high. This
interface is extremely simple to use, and one doesn't need to install
LLVM or other tools to interface with it.

I used the analogy, that eBPF is like C, and this is like Bash. One is
much easier to get "Hello World!" out than the other.

So personally, this is something I know I would use (note, I have
never used eBPF either). But if I'm the only one to use this
interface then I'll stop here (and not bother with the function graph
return interface). If others think this would be helpful, I would ask
them to speak up now.

Thanks,

-- Steve
