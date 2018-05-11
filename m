Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeEKNrS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:47:18 -0400
Received: from ozlabs.org ([203.11.71.1]:42589 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753042AbeEKNrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:47:17 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] lib/test_bitmap.c: Fix bitmap optimisation tests to report errors correctly
In-Reply-To: <CAGXu5jJSDFid-w3kdhCYH_9d_n1AOnJkDaFg70OaWvjpsJ2sgQ@mail.gmail.com>
References: <20180509114328.9887-1-mpe@ellerman.id.au> <CAGXu5jJSDFid-w3kdhCYH_9d_n1AOnJkDaFg70OaWvjpsJ2sgQ@mail.gmail.com>
Date: Fri, 11 May 2018 23:47:15 +1000
Message-ID: <87h8neqp7g.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, May 9, 2018 at 4:43 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> From: Matthew Wilcox <mawilcox@microsoft.com>
>>
>> I had neglected to increment the error counter when the tests failed,
>> which made the tests noisy when they fail, but not actually return an
>> error code.
>>
>> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
>> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
>> Fixes: 3cc78125a081 ("lib/test_bitmap.c: add optimisation tests")
>> Cc: stable@vger.kernel.org # v4.13+
>> Tested-by: Michael Ellerman <mpe@ellerman.id.au>
>
> FWIW:
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks.

cheers
