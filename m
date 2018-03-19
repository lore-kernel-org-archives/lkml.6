Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755265AbeCSFo3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 01:44:29 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:25724 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755118AbeCSFoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 01:44:25 -0400
Subject: Re: linux-next: build warning after merge of the crypto tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180319120433.24cc4be1@canb.auug.org.au>
From: Harsh Jain <harsh@chelsio.com>
Message-ID: <dbcf6dc6-919c-1b7e-5a6c-c4181fd29c40@chelsio.com>
Date: Mon, 19 Mar 2018 11:14:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319120433.24cc4be1@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19-03-2018 06:34, Stephen Rothwell wrote:
> Hi Herbert,
>
> After merging the crypto tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> In file included from drivers/crypto/chelsio/chcr_ipsec.c:66:0:
> drivers/crypto/chelsio/chcr_crypto.h:343:12: warning: 'chcr_ahash_continue' declared 'static' but never defined [-Wunused-function]
>  static int chcr_ahash_continue(struct ahash_request *req);
>             ^~~~~~~~~~~~~~~~~~~
>
> Introduced by commit
>
>   5110e65536f3 ("crypto: chelsio -Split Hash requests for large scatter gather list")
>
Hi Stephen/Herbert,

I will submit the fix to cryptodev tree.

Thanks & Regards
Harsh Jain
