Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751129AbeELQEF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 12:04:05 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40957 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeELQEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 12:04:04 -0400
X-Google-Smtp-Source: AB8JxZq+A4AmCUINwliIta16XGxnhqsC3SYOArDpoCI+JXFS4hiJD7I8k5k0yKZ2HtrgCs/0Y3cxzqgXbKYUokaIDug=
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 12 May 2018 09:03:42 -0700
Message-ID: <CAADnVQKVEmD4RrcTAiuMn-uua5TP0N-buvRHXq6Mgp1ZeF=G_Q@mail.gmail.com>
Subject: Re: [PATCH bpf v3] x86/cpufeature: bpf hack for clang not supporting
 asm goto
To: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Yonghong Song <yhs@fb.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 10:58 AM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> I see no option, but to fix the kernel.
> Regardless whether it's called user space breakage or kernel breakage.

Peter,

could you please ack the patch or better yet take it into tip tree
and send to Linus asap ?
rc5 is almost here and we didn't have full test coverage
for more than a month due to this issue.

Thanks
