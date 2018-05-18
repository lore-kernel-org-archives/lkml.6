Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbeERQHS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:07:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39510 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751112AbeERQHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:07:14 -0400
Date: Fri, 18 May 2018 18:06:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Anvin <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tipbuild@zytor.com, LKP <lkp@01.org>
Subject: Re: [PATCH] objtool: Detect assembly code falling through to INT3
 padding
Message-ID: <20180518160638.GG17285@pd.tnic>
References: <20180515214337.GA18021@avx2>
 <20180515222211.ods5hzne46hozojq@treble>
 <CA+55aFw1MxjUKtrt-KyiNxmpuKUY273L5uy8ggzOFjBSYMwwog@mail.gmail.com>
 <20180515224354.zmygmsnlqj5lrdbo@treble>
 <CA+55aFzTpkn_fokmm+ddi+cgk5K3EOftRmPad+NkUb5W2z0Fqg@mail.gmail.com>
 <CA+55aFwrT-BAvdujUonX5MvB=8GFopQJT4x6xMhtjNN2G0AxSw@mail.gmail.com>
 <20180516033044.odb74pdgcn5nacwb@treble>
 <20180517134934.eog2fgoby5azq5a7@treble>
 <20180518071814.GB26358@gmail.com>
 <ce49ca7a-c5fd-6e93-9578-c91290f819d8@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce49ca7a-c5fd-6e93-9578-c91290f819d8@zytor.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 12:27:15AM -0700, H. Peter Anvin wrote:
> On 05/18/18 00:18, Ingo Molnar wrote:
> > 
> > Ok, this is cool, it addresses the robustness problem that INT3 padding introduced 
> > very nicely.
> > 
> > The concept of built-in kernel tooling working at the machine code level is just 
> > so powerful - we should have added our own KCC compiler 20 years ago.
> > 
> 
> How many times has this been suggested? ;)

Goes to show we still really need it. Imagine the simplifications and
improvements we'll be able to do. Oh myyy....

/me has a wet dream.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
