Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965885AbeEIW0F (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 18:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965610AbeEIW0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 18:26:04 -0400
Date: Thu, 10 May 2018 07:25:59 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>, francis.deslauriers@efficios.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH 0/2] uprobes: x86: Reject probing MOV SS
Message-Id: <20180510072559.21cf860390f62bfc195ae959@kernel.org>
In-Reply-To: <CALCETrVNFAB-zJxhs3t+CxOdftssmWjMaS_bYuQDR+NcBGPRfg@mail.gmail.com>
References: <152587066475.17316.3035446966107675608.stgit@devbox>
        <CALCETrVNFAB-zJxhs3t+CxOdftssmWjMaS_bYuQDR+NcBGPRfg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 May 2018 14:36:27 +0000
Andy Lutomirski <luto@kernel.org> wrote:

> On Wed, May 9, 2018 at 5:58 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi,
> 
> > I found the CVE-2018-1087 and CVE-2018-8897 should
> > be related to kprobes and uprobes too, since both
> > are using #DB for single stepping.
> 
> 
> Seems okay to me.  I doubt we have a security problem, but I can easily
> imagine that the probes wouldn't work right.

Sorry for confusion, yes, that will not be a security issue, since kprobes
and uprobes can be used only by root user.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
