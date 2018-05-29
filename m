Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754815AbeE2HGq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:06:46 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35311 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754668AbeE2HGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:06:43 -0400
X-Google-Smtp-Source: ADUXVKJcg30nazZn7XWft15LrX0Xb3o7iShgjbkSGOy/yNvKtq+Pi+J7tIvduJcNwmyEvjnrayB/Sa8DP4CX6MI/91Q=
MIME-Version: 1.0
X-Originating-IP: [90.77.100.34]
In-Reply-To: <20180528191327.23772-1-krzk@kernel.org>
References: <20180528191327.23772-1-krzk@kernel.org>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Tue, 29 May 2018 09:06:42 +0200
Message-ID: <CABxcv=mMEa9Y77CvMsrLXGnfF60L84rthhrR3ZWEfeTSosw2Qg@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: dt-bindings: Explicitly mark Samsung
 Exynos SoC bindings as unstable
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, Pankaj Dubey <pankaj.dubey@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 9:13 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> From: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Samsung Exynos SoCs and boards related bindings evolved since the initial
> introduction, but initially the bindings were minimal and a bit incomplete
> (they never described all the hardware modules available in the SoCs).
> Since then some significant (not fully compatible) changes have been
> already committed a few times (like gpio replaced by pinctrl, display ddc,
> mfc reserved memory, some core clocks added to various hardware modules,
> added more required nodes).
>
> On the other side there are no boards which have device tree embedded in
> the bootloader. Device tree blob is always compiled from the kernel tree
> and updated together with the kernel image.
>
> Thus to avoid further adding a bunch of workarounds for old/missing
> bindings, make development of new platforms easier and allow to make
> cleanup of the existing code and device tree files, lets mark some
> Samsung Exynos SoC platform bindings as unstable. This means that
> bindings can may change at any time and users should use the dtb file
> compiled from the same kernel source tree as the kernel image.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier
