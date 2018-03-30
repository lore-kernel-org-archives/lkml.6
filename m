Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeC3Qjk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 12:39:40 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:51468 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeC3Qjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 12:39:39 -0400
Date: Sat, 31 Mar 2018 00:39:31 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "crypto/ecc: Remove stack VLA usage"
Message-ID: <20180330163930.GA27856@gondor.apana.org.au>
References: <20180326230308.GA27259@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326230308.GA27259@beast>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 26, 2018 at 04:03:08PM -0700, Kees Cook wrote:
> This reverts commit 14de52112ee70ca289fa77bf2d9cbc79fd2c811f.
> 
> The solution was incomplete and inefficient. This will be fixed
> correctly in the next patch.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Hmm you didn't post this to linux-crypto so it's not in patchwork.

Anyway, I'd prefer if you just squashed this together with the
subsequent patch.  It's not that complex to require a revert and
a new patch to be readable.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
