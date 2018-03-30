Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeC3Qtp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 12:49:45 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33433 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeC3Qtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 12:49:43 -0400
X-Google-Smtp-Source: AIpwx4/cnHlwd0Bu+COhe8vWLusEXYxfjArTP7Yx+6LnOXfZ1pqTMZc2LFvRWiBaQINlK/3aCrtNm1x4RY70i9aUygI=
MIME-Version: 1.0
In-Reply-To: <20180330163930.GA27856@gondor.apana.org.au>
References: <20180326230308.GA27259@beast> <20180330163930.GA27856@gondor.apana.org.au>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 30 Mar 2018 09:49:41 -0700
X-Google-Sender-Auth: oofnQknKzI7bxL5kk5ABT0d09J4
Message-ID: <CAGXu5jKaB169dB47u5YT3ot-r2PvTcT+5Ng+1ZQZV3f3azkJAg@mail.gmail.com>
Subject: Re: [PATCH] Revert "crypto/ecc: Remove stack VLA usage"
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 9:39 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Mon, Mar 26, 2018 at 04:03:08PM -0700, Kees Cook wrote:
>> This reverts commit 14de52112ee70ca289fa77bf2d9cbc79fd2c811f.
>>
>> The solution was incomplete and inefficient. This will be fixed
>> correctly in the next patch.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Hmm you didn't post this to linux-crypto so it's not in patchwork.
>
> Anyway, I'd prefer if you just squashed this together with the
> subsequent patch.  It's not that complex to require a revert and
> a new patch to be readable.

Sounds good, thanks!

-Kees

-- 
Kees Cook
Pixel Security
