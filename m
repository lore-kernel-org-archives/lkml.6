Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754408AbeEWIgN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:36:13 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33056 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754195AbeEWIgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:36:11 -0400
X-Google-Smtp-Source: AB8JxZpAoDW+NcZoh+jZ/JP3zEq7/P3Wk8sPAMundDIm4R47dVJSslulJ0Kretc4v7yCgNIdWTBuHri89EtVuGYhZg0=
MIME-Version: 1.0
In-Reply-To: <20180520051736.4842-5-manivannan.sadhasivam@linaro.org>
References: <20180520051736.4842-1-manivannan.sadhasivam@linaro.org> <20180520051736.4842-5-manivannan.sadhasivam@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 May 2018 10:36:10 +0200
Message-ID: <CACRpkdYteaiNWHNsi4Ldb9a0SZD5uG0j3Ltg_Eu5t0RZMJUUcw@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] pinctrl: actions: Add gpio support for Actions
 S900 SoC
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

On Sun, May 20, 2018 at 7:17 AM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add gpio support to pinctrl driver for Actions Semi S900 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Patch applied for v4.18 so we get some rotation in linux-next!

Yours,
Linus Walleij
