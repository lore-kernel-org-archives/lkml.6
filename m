Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423578AbeCBNLa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 08:11:30 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:51956 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423521AbeCBNL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 08:11:26 -0500
X-Google-Smtp-Source: AG47ELvo6LuWUQVBrd+IWcEJGd4uLrTfMFFb4W7/TeBrMp/LIa6eVAce5OJqnfGQ5FBSY8+jRDhweKvgYokqfR0GNqQ=
MIME-Version: 1.0
In-Reply-To: <20180302035045.14660-3-manivannan.sadhasivam@linaro.org>
References: <20180302035045.14660-1-manivannan.sadhasivam@linaro.org> <20180302035045.14660-3-manivannan.sadhasivam@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Mar 2018 14:11:25 +0100
Message-ID: <CACRpkdaGPnvEitHWuDuqMWeCF0VkTCrbtV3Fine05JBM09dMSw@mail.gmail.com>
Subject: Re: [PATCH v4 02/10] arm64: dts: actions: Add pinctrl node for S900
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

> Add pinctrl nodes for Actions Semi S900 SoC
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please funnel this patch through the ARM SoC
tree.

Yours,
Linus Walleij
