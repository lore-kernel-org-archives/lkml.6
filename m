Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966294AbeEJQUw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:20:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34234 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935410AbeEJQUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:20:51 -0400
Date: Thu, 10 May 2018 18:20:28 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Yonghong Song <yhs@fb.com>,
        mingo@kernel.org, torvalds@linux-foundation.org, ast@fb.com,
        daniel@iogearbox.net, linux-kernel@vger.kernel.org, x86@kernel.org,
        netdev@vger.kernel.org, kernel-team@fb.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH bpf v3] x86/cpufeature: bpf hack for clang not supporting
 asm goto
Message-ID: <20180510162028.GB16130@pd.tnic>
References: <20180504033119.2130788-1-yhs@fb.com>
 <20180510100634.GZ12217@hirez.programming.kicks-ass.net>
 <20180510155240.5s2fpgm2fwal3jlj@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180510155240.5s2fpgm2fwal3jlj@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 08:52:42AM -0700, Alexei Starovoitov wrote:
> That makes me wonder what happened with "we do not break user space" rule?

As someone already pointed out on IRC, arch/x86/include/asm/cpufeature.h
is solely a kernel header so nothing but kernel should include it. So
forget the userspace breakage "argument".

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
