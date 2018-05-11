Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753292AbeEKNsb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:48:31 -0400
Received: from ozlabs.org ([203.11.71.1]:40961 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753130AbeEKNsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:48:30 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, mawilcox@microsoft.com,
        ynorov@caviumnetworks.com, andriy.shevchenko@linux.intel.com,
        geert@linux-m68k.org, keescook@chromium.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] lib/test_bitmap.c: Fix bitmap optimisation tests to report errors correctly
In-Reply-To: <20180509155956.4132815b34c4e7421aaab0a7@linux-foundation.org>
References: <20180509114328.9887-1-mpe@ellerman.id.au> <20180509155956.4132815b34c4e7421aaab0a7@linux-foundation.org>
Date: Fri, 11 May 2018 23:48:28 +1000
Message-ID: <87efiiqp5f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:
> On Wed,  9 May 2018 21:43:28 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
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
> I'll add your SOB to my copy of this, as you were on the patch delivery path.

Ah yep, I wasn't on the original delivery path, but you're right I am now.

Thanks for fixing it up.

cheers
