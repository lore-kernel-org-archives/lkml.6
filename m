Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbeCLRl3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:41:29 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39849 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932356AbeCLRl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:41:27 -0400
X-Google-Smtp-Source: AG47ELuxsFMBhY8DJtwqS2FKCDO2Q+3yUfM4F4z1cisIhRtyYLDSVgKIWBMQEKGQCfsJRBiZa4eCnA==
Date: Mon, 12 Mar 2018 18:41:20 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Anvin <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        linux-tip-commits@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>
Subject: Re: [tip:x86/mm] x86/boot/compressed/64: Describe the logic behind
 the LA57 check
Message-ID: <20180312174120.wtopp54bskk5a5fu@gmail.com>
References: <tip-a403d798182f4f7be5e9bab56cfa37e9828fd92a@git.kernel.org>
 <20180312124027.GG4064@hirez.programming.kicks-ass.net>
 <20180312124337.vw7bchm6brfzghfa@node.shutemov.name>
 <20180312131055.GH4064@hirez.programming.kicks-ass.net>
 <20180312140449.oyngtgqppnjuh3lf@node.shutemov.name>
 <20180312143212.77z2ptyqbsbqdll3@gmail.com>
 <20180312145049.boh3wmaotim6sfh2@black.fi.intel.com>
 <CA+55aFyKOkO1BBYX+-SZyON2FA_FSc9YqVDLU9-pRj1=jh9sUw@mail.gmail.com>
 <CALCETrU8=_A9VzJMWuLouoyVQVLbnh_1etQK4tB4kvD8b51opQ@mail.gmail.com>
 <CA+55aFya-fZQVi45axVpv4PF_b8yhHfDxx3xCTX+gbN5Ec9VUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFya-fZQVi45axVpv4PF_b8yhHfDxx3xCTX+gbN5Ec9VUQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> But regardless, I think we're better off with a "wait and see" approach.
> 
> IOW, try to use 5-level whenever possible for now, and _if_ somebody actually 
> can show that 4-level page tables perform better or have some other advantage, 
> we can then try to be clever later when it's all tested and it's just an 
> optimization, not a "that code won't even run normally and gets basically zero 
> coverage".

Ok, fair enough - and the testing argument makes sense as well.

Thanks,

	Ingo
