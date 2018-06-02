Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751652AbeFBJxx (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 05:53:53 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36361 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbeFBJxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 05:53:50 -0400
X-Google-Smtp-Source: ADUXVKJgzoBUNJxDkTJCXQufGDNp0GzdG5Ws6LIwHbGpp0dCABWoXC2o2rcb2cA0C2wt9/L6pZ4oaA==
Subject: Re: [PATCH 15/18] rhashtable: use bit_spin_locks to protect hash
 bucket.
To: Herbert Xu <herbert@gondor.apana.org.au>, NeilBrown <neilb@suse.com>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
References: <152782754287.30340.4395718227884933670.stgit@noble>
 <152782824984.30340.1634082820568216846.stgit@noble>
 <20180602050322.liesw324q5kawcue@gondor.apana.org.au>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <9bea77df-e7db-677a-31b2-710dc6d956ee@gmail.com>
Date: Sat, 2 Jun 2018 05:53:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180602050322.liesw324q5kawcue@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/02/2018 01:03 AM, Herbert Xu wrote:
 
> Yes the concept looks good to me.  But I would like to hear from
> Eric/Dave as to whether this would be acceptable for existing
> network hash tables such as the ones in inet.


What about lockdep support ?
