Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeDLJIP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:08:15 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:42510 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbeDLJIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:08:13 -0400
X-Google-Smtp-Source: AIpwx4//TkhiK7TwmX4LFTqrJxxg4an8ob9bWMsZYqlILtEu4sBBC3QK9oozQcpuGv4og+bH4aHMzExMbqrB3RuvSYI=
MIME-Version: 1.0
In-Reply-To: <20180404172258.7678-9-manivannan.sadhasivam@linaro.org>
References: <20180404172258.7678-1-manivannan.sadhasivam@linaro.org> <20180404172258.7678-9-manivannan.sadhasivam@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Apr 2018 11:08:11 +0200
Message-ID: <CACRpkdZLqqwZpcm7WD-RxdO3uyf8rnNHSyqpQaSPgps06xh_hA@mail.gmail.com>
Subject: Re: [PATCH v7 8/9] MAINTAINERS: Add reviewer for ACTIONS platforms
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 4, 2018 at 7:22 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Since I'll be working on improving support for ACTIONS platforms, adding
> myself as the reviewer.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Andreas: are you funneling patches to ARM SoC for the
Actions stuff? Or who is?

This should go in through the ARM SoC tree anyways,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Tell me if things get stuck and I'll apply it to the GPIO tree...

Yours,
Linus Walleij
