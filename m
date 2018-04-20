Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbeDTQuj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:50:39 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:34324 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753150AbeDTQug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:50:36 -0400
Date: Sat, 21 Apr 2018 00:50:33 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Nick Terrell <terrelln@fb.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        kernel-team@fb.com, Chris Mason <clm@fb.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Geliang Tang <geliangtang@gmail.com>
Subject: Re: [RESEND PATCH] crypto: Add zstd support
Message-ID: <20180420165032.ufqzoefyvnym75s3@gondor.apana.org.au>
References: <20180330191453.3535287-1-terrelln@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330191453.3535287-1-terrelln@fb.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 12:14:53PM -0700, Nick Terrell wrote:
> Adds zstd support to crypto and scompress. Only supports the default
> level.
> 
> Previously we held off on this patch, since there weren't any users.
> Now zram is ready for zstd support, but depends on CONFIG_CRYPTO_ZSTD,
> which isn't defined until this patch is in. I also see a patch adding
> zstd to pstore [0], which depends on crypto zstd.
> 
> [0] lkml.kernel.org/r/9c9416b2dff19f05fb4c35879aaa83d11ff72c92.1521626182.git.geliangtang@gmail.com
> 
> Signed-off-by: Nick Terrell <terrelln@fb.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
