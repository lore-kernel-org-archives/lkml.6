Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeC3RPL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 13:15:11 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:51480 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbeC3RPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 13:15:08 -0400
Date: Sat, 31 Mar 2018 01:14:59 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Nick Terrell <terrelln@fb.com>, kernel-team@fb.com,
        Chris Mason <clm@fb.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, Geliang Tang <geliangtang@gmail.com>
Subject: Re: [RESEND PATCH] crypto: Add zstd support
Message-ID: <20180330171459.GB27856@gondor.apana.org.au>
References: <20180321224929.3076350-1-terrelln@fb.com>
 <20180322043230.GD3181@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180322043230.GD3181@jagdpanzerIV>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 01:32:30PM +0900, Sergey Senozhatsky wrote:
> On (03/21/18 15:49), Nick Terrell wrote:
> > depends on CONFIG_CRYPTO_ZSTD, which isn't defined until this patch is in
> 
> Yikes! How come I missed that... :)
> 
> > [0] lkml.kernel.org/r/9c9416b2dff19f05fb4c35879aaa83d11ff72c92.1521626182.git.geliangtang@gmail.com
> 
> Signed-off-by: Nick Terrell <terrelln@fb.com> ?

Please resend with sign-off.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
