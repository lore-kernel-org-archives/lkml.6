Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965939AbeEIW76 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 18:59:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46866 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965426AbeEIW75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 18:59:57 -0400
Date: Wed, 9 May 2018 15:59:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, mawilcox@microsoft.com,
        ynorov@caviumnetworks.com, andriy.shevchenko@linux.intel.com,
        geert@linux-m68k.org, keescook@chromium.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH] lib/test_bitmap.c: Fix bitmap optimisation tests to
 report errors correctly
Message-Id: <20180509155956.4132815b34c4e7421aaab0a7@linux-foundation.org>
In-Reply-To: <20180509114328.9887-1-mpe@ellerman.id.au>
References: <20180509114328.9887-1-mpe@ellerman.id.au>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 May 2018 21:43:28 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:

> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> I had neglected to increment the error counter when the tests failed,
> which made the tests noisy when they fail, but not actually return an
> error code.
> 
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Fixes: 3cc78125a081 ("lib/test_bitmap.c: add optimisation tests")
> Cc: stable@vger.kernel.org # v4.13+
> Tested-by: Michael Ellerman <mpe@ellerman.id.au>

I'll add your SOB to my copy of this, as you were on the patch delivery path.
