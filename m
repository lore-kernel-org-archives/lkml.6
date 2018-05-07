Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeEGIQV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 04:16:21 -0400
Received: from www62.your-server.de ([213.133.104.62]:52849 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbeEGIQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 04:16:18 -0400
Subject: Re: linux-next: manual merge of the tip tree with the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180507120909.1fee1683@canb.auug.org.au>
 <20180507141003.79783848@canb.auug.org.au>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <84481a2d-3930-93c5-9d4f-55b3d066050f@iogearbox.net>
Date: Mon, 7 May 2018 10:15:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180507141003.79783848@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2018 06:10 AM, Stephen Rothwell wrote:
> On Mon, 7 May 2018 12:09:09 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the tip tree got a conflict in:
>>
>>   arch/x86/net/bpf_jit_comp.c
>>
>> between commit:
>>
>>   e782bdcf58c5 ("bpf, x64: remove ld_abs/ld_ind")
>>
>> from the bpf-next tree and commit:
>>
>>   5f26c50143f5 ("x86/bpf: Clean up non-standard comments, to make the code more readable")
>>
>> from the tip tree.
>>
>> I fixed it up (the former commit removed some code modified by the latter,
>> so I just removed it) and can carry the fix as necessary. This is now
>> fixed as far as linux-next is concerned, but any non trivial conflicts
>> should be mentioned to your upstream maintainer when your tree is
>> submitted for merging.  You may also want to consider cooperating with
>> the maintainer of the conflicting tree to minimise any particularly
>> complex conflicts.
> 
> Actually the tip tree commit has been added to the bpf-next tree as a
> different commit, so dropping it from the tip tree will clean this up.

Yep, it's been cherry-picked into bpf-next to avoid merge conflicts with
ongoing work.
