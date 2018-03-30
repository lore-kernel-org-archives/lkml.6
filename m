Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeC3Rm6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 13:42:58 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:51578 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbeC3Rm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 13:42:57 -0400
Date: Sat, 31 Mar 2018 01:42:44 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: "David S. Miller" <davem@davemloft.net>, horia.geanta@nxp.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] crypto: talitos - fix IPsec cipher in length
Message-ID: <20180330174243.GH28120@gondor.apana.org.au>
References: <20180322095701.4563E6F352@po15720vm.idsi0.si.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180322095701.4563E6F352@po15720vm.idsi0.si.c-s.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 10:57:01AM +0100, Christophe Leroy wrote:
> For SEC 2.x+, cipher in length must contain only the ciphertext length.
> In case of using hardware ICV checking, the ICV length is provided via
> the "extent" field of the descriptor pointer.
> 
> Cc: <stable@vger.kernel.org> # 4.8+
> Fixes: 549bd8bc5987 ("crypto: talitos - Implement AEAD for SEC1 using HMAC_SNOOP_NO_AFEU")
> Reported-by: Horia Geantă <horia.geanta@nxp.com>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
