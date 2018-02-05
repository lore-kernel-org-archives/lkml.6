Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752116AbeBEXZz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 18:25:55 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:38887 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750724AbeBEXZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 18:25:48 -0500
X-Google-Smtp-Source: AH8x227wAOwLp3n0g6+ylQVc1L8mCARXa6OHCkpkdgdA1KBYKV1j0PtgRVjPjT53k1Ih4ACRnZPhkEEPrBL0H7mHA10=
MIME-Version: 1.0
In-Reply-To: <20180205012146.23981-8-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com> <20180205012146.23981-8-ulfalizer@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 6 Feb 2018 00:25:47 +0100
Message-ID: <CACRpkdY-3ab=o0TpURqa-MyTMJOd86SWqBaD4n7+KGYhgbYjzg@mail.gmail.com>
Subject: Re: [PATCH 07/20] riscv: Remove ARCH_WANT_OPTIONAL_GPIOLIB select
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>, tfiga@chromium.org,
        paul.burton@mips.com, Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Vineet Gupta <vgupta@synopsys.com>, mgorman@techsingularity.net,
        Christoph Hellwig <hch@lst.de>, mina86@mina86.com,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        paulus@ozlabs.org, Will Deacon <will.deacon@arm.com>,
        ext Tony Lindgren <tony@atomide.com>, npiggin@gmail.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 2:21 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:

> The ARCH_WANT_OPTIONAL_GPIOLIB symbol was removed in commit 65053e1a7743
> ("gpio: delete ARCH_[WANTS_OPTIONAL|REQUIRE]_GPIOLIB"). GPIOLIB should
> just be selected explicitly if needed.
>
> Remove the ARCH_WANT_OPTIONAL_GPIOLIB select from RISCV.
>
> See commit 0145071b3314 ("x86: Do away with
> ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB") and commit da9a1c6767 ("arm64: do
> away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB") as well.
>
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>

This should probaly be replaced with
select GPIOLIB

Yours,
Linus Walleij
