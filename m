Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752810AbeBFQJU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:09:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752331AbeBFQJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:09:09 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54125217AA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AH8x22609aXgpfp7ttLYpbjNT/JhGgaA3ShrFLMBb7/lnQ/6QGP+KfzMxiyscRmwP2CJdXTOdcPOfE1kz3wl8+Ib4wE=
MIME-Version: 1.0
In-Reply-To: <20180205012146.23981-11-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com> <20180205012146.23981-11-ulfalizer@gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 6 Feb 2018 10:08:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKO83x3iTc+929RBiAE3bfSFH6hHmO537DO1h4rhaMU4g@mail.gmail.com>
Message-ID: <CAL_JsqKO83x3iTc+929RBiAE3bfSFH6hHmO537DO1h4rhaMU4g@mail.gmail.com>
Subject: Re: [PATCH 10/20] lib/Kconfig: Remove leftover select of GENERIC_IO
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, Paul Burton <paul.burton@mips.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vineet Gupta <vgupta@synopsys.com>, mgorman@techsingularity.net,
        Christoph Hellwig <hch@lst.de>, Michal Nazarewicz <mina86@mina86.com>,
        Stephen Boyd <sboyd@codeaurora.org>, paulus@ozlabs.org,
        Will Deacon <will.deacon@arm.com>, Tony Lindgren <tony@atomide.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Dave Airlie <airlied@redhat.com>,
        Jeremy Kerr <jk@ozlabs.org>, Bart Van Assche <bart.vanassche@wdc.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 4, 2018 at 7:21 PM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> GENERIC_IO was removed by commit 9de8da47742b ("kconfig: kill off
> GENERIC_IO option"), but HAS_IOMEM still selects it.
>
> Remove the select of GENERIC_IO from HAS_IOMEM.
>
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>  lib/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

There was another fix[1] for this but it seems to have gotten lost.

Acked-by: Rob Herring <robh@kernel.org>

Rob

[1] https://lkml.org/lkml/2018/1/17/924
