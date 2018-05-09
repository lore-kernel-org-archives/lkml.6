Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935138AbeEIOgm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934936AbeEIOgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:36:40 -0400
X-Google-Smtp-Source: AB8JxZo9GK1a0G+tT8+ncAQXAploiRsvKxujiUqYcGVrc8QJFhacm8eCNvnZjek3V1IMOAd6bA9CZ/ym135KT5XBXEo=
MIME-Version: 1.0
References: <152587066475.17316.3035446966107675608.stgit@devbox>
In-Reply-To: <152587066475.17316.3035446966107675608.stgit@devbox>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 09 May 2018 14:36:27 +0000
X-Gmail-Original-Message-ID: <CALCETrVNFAB-zJxhs3t+CxOdftssmWjMaS_bYuQDR+NcBGPRfg@mail.gmail.com>
Message-ID: <CALCETrVNFAB-zJxhs3t+CxOdftssmWjMaS_bYuQDR+NcBGPRfg@mail.gmail.com>
Subject: Re: [PATCH 0/2] uprobes: x86: Reject probing MOV SS
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>, francis.deslauriers@efficios.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 9, 2018 at 5:58 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,

> I found the CVE-2018-1087 and CVE-2018-8897 should
> be related to kprobes and uprobes too, since both
> are using #DB for single stepping.


Seems okay to me.  I doubt we have a security problem, but I can easily
imagine that the probes wouldn't work right.
