Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeBHWKE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:10:04 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46452 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeBHWKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:10:02 -0500
X-Google-Smtp-Source: AH8x224lYkqkC13CXMZqY1CutMiOAU1VzOWupjfO+og9JJSqfRCuuUR7sL9vhJ2qCkbbAoS20WasjvsT4jmNz8AS4MM=
MIME-Version: 1.0
In-Reply-To: <mhng-2395f66f-11f6-4209-86b2-71482e5cf52b@palmer-si-x1c4>
References: <20180205012146.23981-7-ulfalizer@gmail.com> <mhng-2395f66f-11f6-4209-86b2-71482e5cf52b@palmer-si-x1c4>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 8 Feb 2018 23:10:01 +0100
Message-ID: <CAFkk2KQwjf0SRgNEmufKBU3FPozZYt1cNqNeAu6KT7jCXDH6QA@mail.gmail.com>
Subject: Re: [PATCH 06/20] riscv: Remove ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE select
To: Palmer Dabbelt <palmer@sifive.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        tfiga@chromium.org, paul.burton@mips.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vineet Gupta <vgupta@synopsys.com>, mgorman@techsingularity.net,
        Christoph Hellwig <hch@lst.de>, mina86@mina86.com,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        Paul Mackerras <paulus@ozlabs.org>, Will Deacon <will.deacon@arm.com>,
        Tony Lindgren <tony@atomide.com>, Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Albert Ou <albert@sifive.com>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 7:34 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
> On Sun, 04 Feb 2018 17:21:18 PST (-0800), ulfalizer@gmail.com wrote:
>>
>> The ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE symbol was removed in
>> commit 51a021244b9d ("atomic64: no need for
>> CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE").
>>
>> Remove the ARCH_HAS_ATOMIC64_DEC_IS_POSITIVE select from RISCV.
>>
>> Discovered with the
>>
>> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
>> script.
>>
>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>> ---
>>  arch/riscv/Kconfig | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index b6722c246d9c..ff69c77b9e78 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -8,7 +8,6 @@ config RISCV
>>         select OF
>>         select OF_EARLY_FLATTREE
>>         select OF_IRQ
>> -       select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>>         select ARCH_WANT_FRAME_POINTERS
>>         select CLONE_BACKWARDS
>>         select COMMON_CLK
>
>
> Thanks!
>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I didn't have a particular tree in mind for these patches by the way,
so feel free to pull it in yourselves.

Cheers,
Ulf
