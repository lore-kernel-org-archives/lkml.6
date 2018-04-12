Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeDLIyb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 04:54:31 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:46113 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbeDLIy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 04:54:29 -0400
X-Google-Smtp-Source: AIpwx49Gb1KxoL8+rrL8Zh+Jpoxqs5gnDuTo1SCajbscU94F7K949/oHRj0pE80OHA4M+VZ4CP1MmXkEiTOq+7PrAbA=
MIME-Version: 1.0
In-Reply-To: <20180328174703.19778-5-manivannan.sadhasivam@linaro.org>
References: <20180328174703.19778-1-manivannan.sadhasivam@linaro.org> <20180328174703.19778-5-manivannan.sadhasivam@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Apr 2018 10:54:28 +0200
Message-ID: <CACRpkdYtdJc7jXfFPmXQUg5Q5YACk29-FvohOkXMmnOgV5_NzQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] dt-bindings: gpio: Add gpio nodes for Actions S900 SoC
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

On Wed, Mar 28, 2018 at 7:46 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:

> Add gpio nodes for Actions Semi S900 SoC.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

This should probably have Subject "add bindings" rather than "add gpio nodes"
but it's fine, I can fix it up when applying if I just get Rob's ACK
on these bindings (that look entirely uncontroversial).

Yours,
Linus Walleij
