Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164709AbeBOPn0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:43:26 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:39516 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033989AbeBOPnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:43:19 -0500
Date: Thu, 15 Feb 2018 23:43:14 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: rsa-pkcs1pad: Replace GFP_ATOMIC with GFP_KERNEL
 in pkcs1pad_encrypt_sign_complete
Message-ID: <20180215154314.GH7352@gondor.apana.org.au>
References: <1516874274-11851-1-git-send-email-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516874274-11851-1-git-send-email-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2018 at 05:57:54PM +0800, Jia-Ju Bai wrote:
> After checking all possible call chains to kzalloc here,
> my tool finds that this kzalloc is never called in atomic context.
> Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.
> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
