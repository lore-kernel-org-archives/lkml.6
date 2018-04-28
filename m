Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933453AbeD1IZb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 04:25:31 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:32810 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759694AbeD1IZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 04:25:29 -0400
Date: Sat, 28 Apr 2018 16:25:13 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Varsha Rao <rvarsha016@gmail.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Joe Perches <joe@perches.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        cocci <cocci@systeme.lip6.fr>, "David S. Miller" <davem@davemloft.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [RESEND PATCH v2] crypto: cavium: zip: Remove unnecessary
 parentheses
Message-ID: <20180428082513.2qkirpburohorkxx@gondor.apana.org.au>
References: <20180419154943.21983-1-rvarsha016@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180419154943.21983-1-rvarsha016@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 09:19:43PM +0530, Varsha Rao wrote:
> This patch fixes the clang warning of extraneous parentheses, with the
> following coccinelle script.
> 
> @@
> identifier i;
> constant c;
> expression e;
> @@
> (
> !((e))
> |
> -((
> \(i == c\|i != c\|i <= c\|i < c\|i >= c\|i > c\)
> -))
> )
> 
> Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
> ---
> Changes in v2:
>  - Modified coccinelle script
> 
>  drivers/crypto/cavium/zip/zip_regs.h | 42 ++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
