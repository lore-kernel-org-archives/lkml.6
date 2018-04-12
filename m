Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752763AbeDLJKH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:10:07 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:42739 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbeDLJKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:10:04 -0400
X-Google-Smtp-Source: AIpwx48hoTWMHr0cJzgWxHUxRoeQRVEd2J36h/QgWMTFryUKjwPwu4H50f5l0fTM8313MIlA0czj0L9fxjizK9S7Ths=
MIME-Version: 1.0
In-Reply-To: <20180404172258.7678-10-manivannan.sadhasivam@linaro.org>
References: <20180404172258.7678-1-manivannan.sadhasivam@linaro.org> <20180404172258.7678-10-manivannan.sadhasivam@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Apr 2018 11:10:03 +0200
Message-ID: <CACRpkdZBob9vhsshH8qdX+Uef7=sdsoaze+uOXUHmU8WpgRMtQ@mail.gmail.com>
Subject: Re: [PATCH v7 9/9] MAINTAINERS: Add Actions Semi S900 pinctrl and
 gpio entries
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

> Add S900 pinctrl and gpio entries under ARCH_ACTIONS
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

This should probably also go in through the ARM SoC tree.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Again, tell me if things get stuck and I will apply it.

(It doesn't matter that the files referenced come in from different trees.
I think.)

Yours,
Linus Walleij
