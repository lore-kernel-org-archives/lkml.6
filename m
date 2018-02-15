Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeBOFJ0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 00:09:26 -0500
Received: from ozlabs.org ([103.22.144.67]:37671 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbeBOFJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 00:09:24 -0500
Date: Thu, 15 Feb 2018 16:09:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Progyan Bhattacharya <bprogyan@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        narmstrong@baylibre.com, akpm@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Build: Scripts/Makefile: Remove Repeated Lines
Message-ID: <20180215160922.39ea6c5d@canb.auug.org.au>
In-Reply-To: <CAGyWO1-356ncU=122yrqCoL96pCVfaqJwdFvkmqfot3fzVF6pg@mail.gmail.com>
References: <20180214092558.5846-1-progyanb@acm.org>
        <20180214224937.3f2feb80@canb.auug.org.au>
        <CAGyWO1-9scERtpPw5CCwQcUbCU0SpcqpNq2eiBWRtwpRC-kB-A@mail.gmail.com>
        <CAGyWO1-356ncU=122yrqCoL96pCVfaqJwdFvkmqfot3fzVF6pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Progyan,

On Thu, 15 Feb 2018 10:04:18 +0530 Progyan Bhattacharya <bprogyan@gmail.com> wrote:
>
> I did some ground work and found this particular commit that causing the
> error.
> 
> Commit Hash: d96977a8c2266792397ed9814bb84b5129a278ad

That hash does not appear in linux-next (or Linus' tree).

> Commit Body:
> 
> kasan: rework Kconfig settings
> 
> We get a lot of very large stack frames using gcc-7.0.1 with the default
> -fsanitize-address-use-after-scope --param asan-stack=1 options, which can
> easily cause an overflow of the kernel stack, e.g....
> 
> Author(s):
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

That patch is in Linus' tree now (was in linux-next) but has SHA1 e7c52b84fb18

-- 
Cheers,
Stephen Rothwell
