Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423601AbeE1M0W (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:26:22 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34835 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423564AbeE1M0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 08:26:16 -0400
X-Google-Smtp-Source: ADUXVKKCfrW+a8Wu+PNSgFpF/PlsjGHz8bdJCXEQXRQi47aSsaxiolQNGZUNS6dESdYUpJQe6DiwwNp4TqLls2XSzpo=
MIME-Version: 1.0
In-Reply-To: <2026891.KGZ2uNuXyI@amdc3058>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180526100243.GA1564@sirena.org.uk> <CGME20180528112908eucas1p2946a9b6385fcaf6c19921c9767420405@eucas1p2.samsung.com>
 <CACRpkdZFrFuNnP=uJyREckr8EXW6L2ku+=QwVA7Tva3CpfrpCQ@mail.gmail.com> <2026891.KGZ2uNuXyI@amdc3058>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 28 May 2018 15:26:15 +0300
Message-ID: <CAHp75VewkgrvLDheJUvB=8vMjfaoaV6cOgsROqqWSMTrZJ4g7g@mail.gmail.com>
Subject: Re: [PATCH 10/19 v3] regulator: s2mps11: Pass descriptor instead of
 GPIO number
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 2:29 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:

> -       s2mps11->ext_control_gpiod = devm_kmalloc(&pdev->dev,
> +       s2mps11->ext_control_gpiod = devm_kzalloc(&pdev->dev,
>                         sizeof(*s2mps11->ext_control_gpiod) * rdev_num,
>                         GFP_KERNEL);

devm_kcalloc() I would rather use.

-- 
With Best Regards,
Andy Shevchenko
