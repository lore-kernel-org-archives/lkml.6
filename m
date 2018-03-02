Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423673AbeCBNMO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:12:14 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:45977 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423591AbeCBNMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:12:08 -0500
X-Google-Smtp-Source: AG47ELs1rm4gCnRuTFV9sJktXd+ZR7WmSqcwJQ0d0vWOIumi63GyZO2EPehQxozsFtgNogp6beXW4P9fJIyupVNp5mw=
MIME-Version: 1.0
In-Reply-To: <20180302035045.14660-4-manivannan.sadhasivam@linaro.org>
References: <20180302035045.14660-1-manivannan.sadhasivam@linaro.org> <20180302035045.14660-4-manivannan.sadhasivam@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Mar 2018 14:12:07 +0100
Message-ID: <CACRpkdaUbxhs=1Qad44_X6vUmBnj0AKfLjAZmh67Envp-DLzUA@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] arm64: actions: Enable PINCTRL in platforms Kconfig
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
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

On Fri, Mar 2, 2018 at 4:50 AM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Select PINCTRL for Actions Semi SoCs
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this patch through the ARM SoC tree.

Yours,
Linus Walleij
