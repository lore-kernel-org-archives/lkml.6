Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754161AbeC1PpZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 11:45:25 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:46914 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753937AbeC1PpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 11:45:24 -0400
Date: Wed, 28 Mar 2018 23:45:05 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Stefan Agner <stefan@agner.ch>
Cc: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>, clabbe.montjoie@gmail.com,
        Scott Branden <scott.branden@broadcom.com>,
        Steven Lin <steven.lin1@broadcom.com>, garsilva@embeddedor.com,
        pravin.shedge4linux@gmail.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] crypto: brcm - explicitly cast cipher to hash type
Message-ID: <20180328154505.GA19057@gondor.apana.org.au>
References: <20180324110242.9474-1-stefan@agner.ch>
 <CAAFb_vrFF6D8DEvnZMDda-qd-jTh3mKt0BgGBJ5eWxydY1LEXA@mail.gmail.com>
 <a25ba0afb4cdf8f43b64421995196dee@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a25ba0afb4cdf8f43b64421995196dee@agner.ch>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2018 at 05:41:30PM +0200, Stefan Agner wrote:
>
> Herbert, given that Raveendra agrees to the change, do you want me to
> send a non-RFC version or can you merge the patch as is?

There is no need to resend it.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
