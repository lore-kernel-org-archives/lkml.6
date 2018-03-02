Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426104AbeCBKCi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:02:38 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:39465 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426019AbeCBKCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:02:32 -0500
X-Google-Smtp-Source: AG47ELvYrSvSI/pgeJEBSmN4jZtOqrzdne8DpHIhG/8SdcPjXfNv7B477n2slsl7WoqwHXFiBsFDUVeyjobgdlzedhA=
MIME-Version: 1.0
In-Reply-To: <af608ebae52f1abf413c1c4bc131744408d00f07.1519437750.git.baolin.wang@linaro.org>
References: <c2db9b3b5c611cadfbe5ea97327be7ee5981fa54.1519437750.git.baolin.wang@linaro.org>
 <af608ebae52f1abf413c1c4bc131744408d00f07.1519437750.git.baolin.wang@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Mar 2018 11:02:31 +0100
Message-ID: <CACRpkda+ofJEj7symPF7Lv6ZvtHT_WpYH86eSWr5b0wVmyOdow@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] gpio: Add GPIO driver for Spreadtrum SC9860 platform
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 24, 2018 at 3:07 AM, Baolin Wang <baolin.wang@linaro.org> wrote:

> The Spreadtrum SC9860 platform GPIO controller contains 16 groups and
> each group contains 16 GPIOs. Each GPIO can set input/output and has
> the interrupt capability.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> Changes since v4:
>  - Convert handle_simple_irq() to handle_bad_irq().
>  - Remove redundant comma.

Patch applied!

OK we're done with this driver, now we just need to fix the rest :D

Yours,
Linus Walleij
