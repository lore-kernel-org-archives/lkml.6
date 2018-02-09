Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbeBIPvj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 10:51:39 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:56828 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeBIPvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 10:51:38 -0500
Date: Fri, 9 Feb 2018 23:51:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Artem Savkov <artem.savkov@gmail.com>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sun4i_ss_prng fixes
Message-ID: <20180209155132.GD22273@gondor.apana.org.au>
References: <20180206212022.1309-1-artem.savkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206212022.1309-1-artem.savkov@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 10:20:20PM +0100, Artem Savkov wrote:
> IPSec hasn't been working on my a10 board since 4.14 and it turned out to be
> caused by sun4i_ss_rng driver.
> 
> Artem Savkov (2):
>   sun4i_ss_prng: fix return value of sun4i_ss_prng_generate
>   sun4i_ss_prng: convert lock to _bh in sun4i_ss_prng_generate
> 
>  drivers/crypto/sunxi-ss/sun4i-ss-prng.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
