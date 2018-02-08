Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeBHW4N (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 17:56:13 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41803 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752302AbeBHW4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 17:56:11 -0500
X-Google-Smtp-Source: AH8x226NVJhLvKWYtPK/IrQ72yNTtUi6FnIeY3U7cxpBwFvv34uRRpFi9vNCPI1gvYckB8H9jFjxCg==
Date: Thu, 8 Feb 2018 23:56:07 +0100
From: Ulf Magnusson <ulfalizer@gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        tfiga@chromium.org, paul.burton@mips.com, m.szyprowski@samsung.com,
        egtvedt@samfundet.no, linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, Christoph Hellwig <hch@lst.de>,
        mina86@mina86.com, robh@kernel.org, sboyd@codeaurora.org,
        paulus@ozlabs.org, Will Deacon <will.deacon@arm.com>, tony@atomide.com,
        npiggin@gmail.com, yamada.masahiro@socionext.com, albert@sifive.com,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 07/20] riscv: Remove ARCH_WANT_OPTIONAL_GPIOLIB select
Message-ID: <20180208225606.slie77gk7nnmzh6y@huvuddator>
References: <20180205012146.23981-8-ulfalizer@gmail.com>
 <mhng-dc5e58a4-aab6-4d59-bb59-5a5ff20db392@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mhng-dc5e58a4-aab6-4d59-bb59-5a5ff20db392@palmer-si-x1c4>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 10:34:19AM -0800, Palmer Dabbelt wrote:
> On Sun, 04 Feb 2018 17:21:19 PST (-0800), ulfalizer@gmail.com wrote:
> > The ARCH_WANT_OPTIONAL_GPIOLIB symbol was removed in commit 65053e1a7743
> > ("gpio: delete ARCH_[WANTS_OPTIONAL|REQUIRE]_GPIOLIB"). GPIOLIB should
> > just be selected explicitly if needed.
> > 
> > Remove the ARCH_WANT_OPTIONAL_GPIOLIB select from RISCV.
> > 
> > See commit 0145071b3314 ("x86: Do away with
> > ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB") and commit da9a1c6767 ("arm64: do
> > away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB") as well.
> > 
> > Discovered with the
> > https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> > script.
> > 
> > Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> > ---
> >  arch/riscv/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index ff69c77b9e78..716e90e60e5c 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -19,7 +19,6 @@ config RISCV
> >  	select GENERIC_STRNLEN_USER
> >  	select GENERIC_SMP_IDLE_THREAD
> >  	select GENERIC_ATOMIC64 if !64BIT || !RISCV_ISA_A
> > -	select ARCH_WANT_OPTIONAL_GPIOLIB
> >  	select HAVE_MEMBLOCK
> >  	select HAVE_MEMBLOCK_NODE_MAP
> >  	select HAVE_DMA_API_DEBUG
> 
> Thanks!
> 
> (If you want these through my tree, just say something.)

I didn't have a particular tree in mind for these patches, so feel free
to take it.

> 
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Cheers,
Ulf
