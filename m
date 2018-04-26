Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754239AbeDZH42 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 03:56:28 -0400
Received: from www62.your-server.de ([213.133.104.62]:49514 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753000AbeDZH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 03:56:27 -0400
Subject: Re: linux-next: manual merge of the bpf-next tree with the net-next
 tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
References: <20180426104902.548c3fdb@canb.auug.org.au>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <946a88a7-a12b-ab57-9f6a-17cf4f9aecfb@iogearbox.net>
Date: Thu, 26 Apr 2018 09:56:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180426104902.548c3fdb@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/2018 02:49 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the bpf-next tree got a conflict in:
> 
>   tools/testing/selftests/bpf/.gitignore
> 
> between commit:
> 
>   0abf854d7cbb ("selftests: bpf: update .gitignore with missing generated files")
> 
> from the net-next tree and commit:
> 
>   b6fd9cf796e6 ("selftests: bpf: update .gitignore with missing file")
> 
> from the bpf-next tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks good, thanks!
