Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbeEPMX1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:23:27 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34939 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752026AbeEPMXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:23:24 -0400
X-Google-Smtp-Source: AB8JxZo8I/5pDdTa1BFESm1/5pf11tcaRkXxlsqE9mIy6kIJV1Zp+wA25bhXCNzW5C/80kJ1wIFuSUDVgaZiwzE/oQ8=
MIME-Version: 1.0
In-Reply-To: <20180503225537.20748-3-digetx@gmail.com>
References: <20180503225537.20748-1-digetx@gmail.com> <20180503225537.20748-3-digetx@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 May 2018 14:23:23 +0200
Message-ID: <CACRpkdbykxwHvQgfFnihOHy1hsM7ZWHtCYGCNb49MbNkKWz6Hg@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: tegra20: Provide CDEV1/2 clock muxes
To: Dmitry Osipenko <digetx@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Marcel Ziswiler <marcel@ziswiler.com>, Marc Dietrich <marvin24@gmx.de>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 4, 2018 at 12:55 AM, Dmitry Osipenko <digetx@gmail.com> wrote:

> Muxing of pins MCLK1/2 determine the muxing of the corresponding clocks.
> Make pinctrl driver to provide clock muxes for the CDEV1/2 pingroups, so
> that main clk-controller driver could get an actual parent clock for the
> CDEV1/2 clocks.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Marcel Ziswiler <marcel@ziswiler.com>
> Tested-by: Marcel Ziswiler <marcel@ziswiler.com>
> Tested-by: Marc Dietrich <marvin24@gmx.de>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>
> v2: This patch is factored out from the v1 clk/DT series so that it could be
>     applied separately.

Patch applied unless Stephen W protests.
Please include swarren on future patches to this driver.

Yours,
Linus Walleij
