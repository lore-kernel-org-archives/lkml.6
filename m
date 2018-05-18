Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeERH2c (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:28:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59461 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751907AbeERH2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:28:31 -0400
Subject: Re: [PATCH] objtool: Detect assembly code falling through to INT3
 padding
To: Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Anvin <h.peter.anvin@intel.com>,
        kernel test robot <xiaolong.ye@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tipbuild@zytor.com, LKP <lkp@01.org>
References: <20180515210757.GA12225@avx2>
 <C40DC70F50313144AB3AF8625D4F407F90689B42@ORSMSX101.amr.corp.intel.com>
 <20180515214337.GA18021@avx2> <20180515222211.ods5hzne46hozojq@treble>
 <CA+55aFw1MxjUKtrt-KyiNxmpuKUY273L5uy8ggzOFjBSYMwwog@mail.gmail.com>
 <20180515224354.zmygmsnlqj5lrdbo@treble>
 <CA+55aFzTpkn_fokmm+ddi+cgk5K3EOftRmPad+NkUb5W2z0Fqg@mail.gmail.com>
 <CA+55aFwrT-BAvdujUonX5MvB=8GFopQJT4x6xMhtjNN2G0AxSw@mail.gmail.com>
 <20180516033044.odb74pdgcn5nacwb@treble>
 <20180517134934.eog2fgoby5azq5a7@treble> <20180518071814.GB26358@gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <ce49ca7a-c5fd-6e93-9578-c91290f819d8@zytor.com>
Date: Fri, 18 May 2018 00:27:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518071814.GB26358@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/18 00:18, Ingo Molnar wrote:
> 
> Ok, this is cool, it addresses the robustness problem that INT3 padding introduced 
> very nicely.
> 
> The concept of built-in kernel tooling working at the machine code level is just 
> so powerful - we should have added our own KCC compiler 20 years ago.
> 

How many times has this been suggested? ;)

	-hpa
