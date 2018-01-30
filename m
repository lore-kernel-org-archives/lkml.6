Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753431AbeA3Qs1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 11:48:27 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38427 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753019AbeA3QsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 11:48:25 -0500
X-Google-Smtp-Source: AH8x225qhwdVWMgnEkPphZTDiKI6jZRH6D6LEk3IwdFqwd4nkfGQHaRbozUpZoqZ/nuUtDmRYTTVZevOXabQDuFBxZc=
MIME-Version: 1.0
In-Reply-To: <cccc1addb9c0cc541b676dbad005ec341d12d165.1517313987.git.baolin.wang@linaro.org>
References: <2834309f69a1ec37b84a33f153a3d0b90336bcc6.1517313987.git.baolin.wang@linaro.org>
 <cccc1addb9c0cc541b676dbad005ec341d12d165.1517313987.git.baolin.wang@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 30 Jan 2018 18:48:23 +0200
Message-ID: <CAHp75Vcig869pUQ5yK1b=GpXinhYkpw1q29OVKSs_7EqP4Hknw@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: Add GPIO driver for Spreadtrum SC9860 platform
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 2:07 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
> The Spreadtrum SC9860 platform GPIO controller contains 16 groups and
> each group contains 16 GPIOs. Each GPIO can set input/output and has
> the interrupt capability.

> +config GPIO_SPRD

> +       bool "Spreadtrum GPIO support"

Either you have to put tristate here, or remove all redundant
module_*() and MODULE_*() macros.

Other than that looks fine to me, FWIW:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
