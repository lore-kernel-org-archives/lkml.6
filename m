Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754493AbeDZH5R (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:57:17 -0400
Received: from www62.your-server.de ([213.133.104.62]:49569 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753677AbeDZH5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:57:10 -0400
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
References: <20180426105313.792db06a@canb.auug.org.au>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <57a9e2f1-fb96-a6f9-246b-19b84cca1992@iogearbox.net>
Date: Thu, 26 Apr 2018 09:57:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180426105313.792db06a@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/2018 02:53 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the bpf-next tree got a conflict in:
> 
>   samples/sockmap/Makefile
> 
> between commit:
> 
>   4dfe1bb95235 ("bpf: sockmap sample use clang flag, -target bpf")
> 
> from the bpf tree and commit:
> 
>   2e04eb1dd1ca ("bpf: sockmap, remove samples program")
> 
> from the bpf-next tree.
> 
> I fixed it up (I just removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

That's correct as well, thank you!
