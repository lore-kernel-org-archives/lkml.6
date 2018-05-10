Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757335AbeEJSRK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:17:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37862 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756741AbeEJSRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:17:09 -0400
Date: Thu, 10 May 2018 20:16:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Yonghong Song <yhs@fb.com>,
        mingo@kernel.org, torvalds@linux-foundation.org, ast@fb.com,
        daniel@iogearbox.net, linux-kernel@vger.kernel.org, x86@kernel.org,
        netdev@vger.kernel.org, kernel-team@fb.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH bpf v3] x86/cpufeature: bpf hack for clang not supporting
 asm goto
Message-ID: <20180510181644.GE15757@pd.tnic>
References: <20180504033119.2130788-1-yhs@fb.com>
 <20180510100634.GZ12217@hirez.programming.kicks-ass.net>
 <20180510155240.5s2fpgm2fwal3jlj@ast-mbp.dhcp.thefacebook.com>
 <20180510162028.GB16130@pd.tnic>
 <20180510175833.nujqinu26mydeape@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180510175833.nujqinu26mydeape@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 10:58:35AM -0700, Alexei Starovoitov wrote:
> libbcc is a library. It's not only used by bcc scripts, but by production
> services that compile bpf programs with clang.

Let me get this straight: libbcc fails to compile because it
includes (through some long include chain) the kernel header
arch/x86/include/asm/cpufeature.h.

Is that it?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
