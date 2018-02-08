Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeBHSeV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:34:21 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39005 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBHSeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:34:18 -0500
X-Google-Smtp-Source: AH8x224EkaJoiZprRF4Q+W9DrRj6JhCzFztGhjUs+JN7m6Ygjx+R/Id78N2uvo3nxlO0U7gF67A/zQ==
Date: Thu, 08 Feb 2018 10:34:17 -0800 (PST)
X-Google-Original-Date: Thu, 08 Feb 2018 10:33:21 PST (-0800)
Subject: Re: [PATCH 06/20] riscv: Remove ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE select
In-Reply-To: <20180205012146.23981-7-ulfalizer@gmail.com>
CC: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com,
        egtvedt@samfundet.no, linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, Christoph Hellwig <hch@lst.de>,
        mina86@mina86.com, robh@kernel.org, sboyd@codeaurora.org,
        paulus@ozlabs.org, Will Deacon <will.deacon@arm.com>, tony@atomide.com,
        npiggin@gmail.com, yamada.masahiro@socionext.com, ulfalizer@gmail.com,
        albert@sifive.com, linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@sifive.com>
To: ulfalizer@gmail.com
Message-ID: <mhng-2395f66f-11f6-4209-86b2-71482e5cf52b@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Feb 2018 17:21:18 PST (-0800), ulfalizer@gmail.com wrote:
> The ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE symbol was removed in
> commit 51a021244b9d ("atomic64: no need for
> CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE").
>
> Remove the ARCH_HAS_ATOMIC64_DEC_IS_POSITIVE select from RISCV.
>
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>  arch/riscv/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index b6722c246d9c..ff69c77b9e78 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -8,7 +8,6 @@ config RISCV
>  	select OF
>  	select OF_EARLY_FLATTREE
>  	select OF_IRQ
> -	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>  	select ARCH_WANT_FRAME_POINTERS
>  	select CLONE_BACKWARDS
>  	select COMMON_CLK

Thanks!

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
