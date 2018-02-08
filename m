Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbeBHW6W (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:58:22 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38631 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeBHW6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:58:19 -0500
X-Google-Smtp-Source: AH8x224AQPJugzNYtTOwmWAlOQX0iaml5nhL/L2NrRcYWfbtbyKo0Kz+kzuJQx8jAWDZolKSbRpApA==
Date: Thu, 08 Feb 2018 14:58:18 -0800 (PST)
X-Google-Original-Date: Thu, 08 Feb 2018 14:51:57 PST (-0800)
Subject: Re: [PATCH 07/20] riscv: Remove ARCH_WANT_OPTIONAL_GPIOLIB select
In-Reply-To: <CACRpkdaxyngsogjq7846FEd_zTgCOiv+pEbLXwY1Tj2nG+kmQQ@mail.gmail.com>
CC: ulfalizer@gmail.com, albert@sifive.com, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, tfiga@chromium.org, paul.burton@mips.com,
        m.szyprowski@samsung.com, egtvedt@samfundet.no, vgupta@synopsys.com,
        mgorman@techsingularity.net, Christoph Hellwig <hch@lst.de>,
        mina86@mina86.com, robh@kernel.org, sboyd@codeaurora.org,
        paulus@ozlabs.org, Will Deacon <will.deacon@arm.com>, tony@atomide.com,
        npiggin@gmail.com, yamada.masahiro@socionext.com,
        linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@sifive.com>
To: linus.walleij@linaro.org
Message-ID: <mhng-ef2f8b19-2590-4427-a97c-f0c2c19cdd5c@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Feb 2018 01:47:00 PST (-0800), linus.walleij@linaro.org wrote:
> On Mon, Feb 5, 2018 at 2:21 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
>
>> The ARCH_WANT_OPTIONAL_GPIOLIB symbol was removed in commit 65053e1a7743
>> ("gpio: delete ARCH_[WANTS_OPTIONAL|REQUIRE]_GPIOLIB"). GPIOLIB should
>> just be selected explicitly if needed.
>>
>> Remove the ARCH_WANT_OPTIONAL_GPIOLIB select from RISCV.
>>
>> See commit 0145071b3314 ("x86: Do away with
>> ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB") and commit da9a1c6767 ("arm64: do
>> away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB") as well.
>>
>> Discovered with the
>> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
>> script.
>>
>> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> RISCV maintainers: please apply and carry this patch.

OK, I'll atke it into my tree.  Thanks!
