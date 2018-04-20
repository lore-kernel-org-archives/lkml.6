Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753084AbeDTQuY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:50:24 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:34318 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbeDTQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:50:20 -0400
Date: Sat, 21 Apr 2018 00:50:18 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kees Cook <keescook@chromium.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] crypto/ecc: Actually remove stack VLA usage
Message-ID: <20180420165017.eqnez3jprvwawgsy@gondor.apana.org.au>
References: <20180330165544.GA13206@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330165544.GA13206@beast>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 09:55:44AM -0700, Kees Cook wrote:
> On the quest to remove all VLAs from the kernel[1], this avoids VLAs
> by just using the maximum allocation size (4 bytes) for stack arrays.
> All the VLAs in ecc were either 3 or 4 bytes (or a multiple), so just
> make it 4 bytes all the time. Initialization routines are adjusted to
> check that ndigits does not end up larger than the arrays.
> 
> This includes a removal of the earlier attempt at this fix from
> commit a963834b4742 ("crypto/ecc: Remove stack VLA usage")
> 
> [1] https://lkml.org/lkml/2018/3/7/621
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
