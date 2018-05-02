Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbeEBMca (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:32:30 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:45958 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeEBMcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:32:25 -0400
X-Google-Smtp-Source: AB8JxZpnabrnmAqRsfYEmmxjzyf3ozCdUpjVO34H97StA9bDlXXXeDCANkpcjavRc8uKnz60c1OZPRRji2ZGqcLwpwU=
MIME-Version: 1.0
In-Reply-To: <20180426235818.10018-3-digetx@gmail.com>
References: <20180426235818.10018-1-digetx@gmail.com> <20180426235818.10018-3-digetx@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 May 2018 14:32:23 +0200
Message-ID: <CACRpkdYP88CnsqakjcgBfHgjsR2i4jKvY_--Tw+hgZ_EuA+e6Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] pinctrl: tegra20: Provide CDEV1/2 clock muxes
To: Dmitry Osipenko <digetx@gmail.com>
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

On Fri, Apr 27, 2018 at 1:58 AM, Dmitry Osipenko <digetx@gmail.com> wrote:

> Muxing of pins MCLK1/2 determine the muxing of the corresponding clocks.
> Make pinctrl driver to provide clock muxes for the CDEV1/2 pingroups, so
> that main clk-controller driver could get an actual parent clock for the
> CDEV1/2 clocks.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

If this can be applied separately from the other patches, then please
send it separately after fixing Peter's review nits and adding his
review-tag, thanks!

Yours,
Linus Walleij
