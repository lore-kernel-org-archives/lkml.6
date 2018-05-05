Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751913AbeEEHRc (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 03:17:32 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:35184 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbeEEHRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 03:17:30 -0400
Date: Sat, 5 May 2018 15:17:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kees Cook <keescook@chromium.org>
Cc: Gilad Ben-Yossef <gilad@benyossef.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: tcrypt: Remove VLA usage
Message-ID: <20180505071724.ts3zndtzp62hprng@gondor.apana.org.au>
References: <20180427025728.GA38607@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427025728.GA38607@beast>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 07:57:28PM -0700, Kees Cook wrote:
> In the quest to remove all stack VLA usage from the kernel[1], this
> allocates the return code buffers before starting jiffie timers, rather
> than using stack space for the array. Additionally cleans up some exit
> paths and make sure that the num_mb module_param() is used only once
> per execution to avoid possible races in the value changing.
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
