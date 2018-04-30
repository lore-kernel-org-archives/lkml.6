Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeD3EoD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 00:44:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:27387 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750803AbeD3EoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 00:44:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,345,1520924400";
   d="scan'208";a="224451021"
Subject: Re: [RFD] x86: The future of MPX
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
References: <alpine.DEB.2.21.1804272122390.1596@nanos.tec.linutronix.de>
 <20180428091823.h3iajtxkqdwdcpst@gmail.com>
 <CA+55aFwgcmpSoNh17Pbtsw8j8KzufdvroC9Rsd3K-UbTTP9qPg@mail.gmail.com>
 <CA+55aFyVEJtiRjcazfTst7swGNXXZFHByHO5++-Foq6TDZWjTg@mail.gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <86ff0f5c-0215-798a-2ab8-71fe1677255c@linux.intel.com>
Date: Sun, 29 Apr 2018 21:44:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFyVEJtiRjcazfTst7swGNXXZFHByHO5++-Foq6TDZWjTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/28/2018 09:44 AM, Linus Torvalds wrote:
> On Sat, Apr 28, 2018 at 9:36 AM Linus Torvalds <
> torvalds@linux-foundation.org> wrote:
> 
>> They need to be run as root.
> Side note: don't get me wrong. If the MPX stuff isn't supported by gcc,
> then there is little point in us supporting it in the kernel either.

The loss of the GCC support is definitely a bummer.

There are no objections from me against removing it from future kernels.
 I think it will be pretty straightforward, just leaving the prctl()
numbers as placeholders.
