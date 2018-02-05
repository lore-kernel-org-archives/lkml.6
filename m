Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeBEIA1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 03:00:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750943AbeBEIAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 03:00:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C335217B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AH8x22662dihbAKepffVZ77957IjMaiSuIPRoiNFwAhjUJC4Ng9Sblk05hm6wQ8eXR1btPSeRENZ8piBIXqUq3hoj4A=
MIME-Version: 1.0
In-Reply-To: <20180205012146.23981-16-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com> <20180205012146.23981-16-ulfalizer@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 5 Feb 2018 09:00:15 +0100
X-Gmail-Original-Message-ID: <CAJKOXPecaWOgThH6YJ6bNG7u=OZtM+61QyVWD_JyV=8EkHf-gw@mail.gmail.com>
Message-ID: <CAJKOXPecaWOgThH6YJ6bNG7u=OZtM+61QyVWD_JyV=8EkHf-gw@mail.gmail.com>
Subject: Re: [PATCH 15/20] phy: Remove SOC_EXYNOS4212 dep. from PHY_EXYNOS4X12_USB
To: Ulf Magnusson <ulfalizer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        tfiga@chromium.org, paul.burton@mips.com,
        Marek Szyprowski <m.szyprowski@samsung.com>, egtvedt@samfundet.no,
        linus.walleij@linaro.org, vgupta@synopsys.com,
        mgorman@techsingularity.net, hch@lst.de, mina86@mina86.com,
        robh@kernel.org, sboyd@codeaurora.org, paulus@ozlabs.org,
        will.deacon@arm.com, tony@atomide.com, npiggin@gmail.com,
        yamada.masahiro@socionext.com, Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 2:21 AM, Ulf Magnusson <ulfalizer@gmail.com> wrote:
> Exynos4212 support was removed by commit bca9085e0ae9 ("ARM: dts:
> exynos: remove Exynos4212 support (dead code)").
>
> Remove the SOC_EXYNOS4212 dependency from PHY_EXYNOS4X12_USB.
>
> Discovered with the
> https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
> script.
>
> Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
> ---
>  drivers/phy/samsung/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
