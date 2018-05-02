Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeEBM6a (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:58:30 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:35570 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbeEBM60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:58:26 -0400
X-Google-Smtp-Source: AB8JxZqqX8pLSj/9CuhtV0OhWNEyNxq7ZSau7HNpuhrv+Ssnd5oGVCpA7m+QMLDzpevNDZLy3JEvlquscSGA23M8oVE=
MIME-Version: 1.0
In-Reply-To: <20180430112804.GA5770@ulmo>
References: <20180426235818.10018-1-digetx@gmail.com> <20180430094821.GC2476@ulmo>
 <20180430112804.GA5770@ulmo>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 May 2018 14:58:25 +0200
Message-ID: <CACRpkdbp7mZKQPuUqYNYc121oYrkbUm=tKGKm15-VKUvGwEvdg@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Restore ULPI USB on Tegra20
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Dmitry Osipenko <digetx@gmail.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Marcel Ziswiler <marcel@ziswiler.com>, Marc Dietrich <marvin24@gmx.de>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 1:28 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:

> Marc just pointed out to me on IRC that this fixes a regression that was
> introduced in v4.17-rc1.
>
> Can you guys pick this up into your -fixes branches?

OK I will pick mine independently to my fixes.

> Again, I volunteer
> to collect these into a separate branch and submit via ARM SoC (the DTS
> patch is crucial in enabling the fix) with your Acked-bys if that's the
> preferred option.

No need for me at least.

Yours,
Linus Walleij
