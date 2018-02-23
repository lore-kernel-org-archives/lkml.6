Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeBWPH4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 10:07:56 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:42033 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeBWPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 10:07:53 -0500
X-Google-Smtp-Source: AG47ELviKKJcn40Z8wqiuj+GQVUHrrJWtNSAsm3jSTO+3DrjJCFynytPFHijufQoUifupl8PVNaZ0Fb7PBe0M3ix4PM=
MIME-Version: 1.0
In-Reply-To: <20180221160044.15089-5-manivannan.sadhasivam@linaro.org>
References: <20180221160044.15089-1-manivannan.sadhasivam@linaro.org> <20180221160044.15089-5-manivannan.sadhasivam@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Feb 2018 16:07:51 +0100
Message-ID: <CACRpkdZNVv1=WngCaXF9Mrmw7e=KugG7gJpYF7mr9RAbcsNu=g@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] pinctrl: actions: Add Actions S900 pinctrl driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc: Rob Herring <robh+dt@kernel.org>, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 5:00 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add pinctrl driver for Actions Semi S900 SoC. The driver supports
> pinctrl, pinmux and pinconf functionalities through a range of registers
> common to both gpio driver and pinctrl driver.
>
> Pinmux functionality is available only for the pin groups while the
> pinconf functionality is available for both pin groups and individual
> pins.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Looks very good overall.

Can I get Andreas' feedback and ACK on this?

It would be awesome if someone from Actions could also
ACK or drop some comments.

Actions was an early adopter of the pin control framework (it was
used already on ATM7029), so I would appreciate their feedback.

Yours,
Linus Walleij
