Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933736AbeEIGbU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 02:31:20 -0400
Received: from www62.your-server.de ([213.133.104.62]:37505 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933043AbeEIGbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 02:31:18 -0400
Subject: Re: linux-next: manual merge of the bpf-next tree with the s390 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Networking <netdev@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Miller <davem@davemloft.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180508102638.1e19b7f2@canb.auug.org.au>
 <20180509142154.73ff5772@canb.auug.org.au>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <537b8dd9-798e-f5d2-2595-cd0adfd1123c@iogearbox.net>
Date: Wed, 9 May 2018 08:31:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180509142154.73ff5772@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2018 06:21 AM, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 8 May 2018 10:26:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Today's linux-next merge of the bpf-next tree got a conflict in:
>>
>>   arch/s390/net/bpf_jit.S
>>
>> between commit:
>>
>>   de5cb6eb514e ("s390: use expoline thunks in the BPF JIT")
>>
>> from the s390 tree and commit:
>>
>>   e1cf4befa297 ("bpf, s390x: remove ld_abs/ld_ind")
>>
>> from the bpf-next tree.
>>
>> I fixed it up (I just removed the file as the latter does) and can
>> carry the fix as necessary. This is now fixed as far as linux-next is
>> concerned, but any non trivial conflicts should be mentioned to your
>> upstream maintainer when your tree is submitted for merging.  You may
>> also want to consider cooperating with the maintainer of the conflicting
>> tree to minimise any particularly complex conflicts.
> 
> This is now a conflict between the net-next and s390 trees.

Right, bpf-next merged as usual into net-next two days ago; so same
resolution applies.
