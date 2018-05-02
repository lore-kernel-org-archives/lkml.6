Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeEBOAd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:00:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45658 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750898AbeEBOA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:00:28 -0400
Date: Wed, 2 May 2018 16:00:08 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFD] x86: The future of MPX
Message-ID: <20180502140008.GE2851@pd.tnic>
References: <alpine.DEB.2.21.1804272122390.1596@nanos.tec.linutronix.de>
 <20180428091823.h3iajtxkqdwdcpst@gmail.com>
 <CA+55aFwgcmpSoNh17Pbtsw8j8KzufdvroC9Rsd3K-UbTTP9qPg@mail.gmail.com>
 <CA+55aFyVEJtiRjcazfTst7swGNXXZFHByHO5++-Foq6TDZWjTg@mail.gmail.com>
 <86ff0f5c-0215-798a-2ab8-71fe1677255c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86ff0f5c-0215-798a-2ab8-71fe1677255c@linux.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 29, 2018 at 09:44:00PM -0700, Dave Hansen wrote:
> The loss of the GCC support is definitely a bummer.

https://gcc.gnu.org/ml/gcc-patches/2018-05/msg00027.html

Will go into gcc9.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
