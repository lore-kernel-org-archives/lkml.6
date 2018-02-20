Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbeBTH4m (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 02:56:42 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39389 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeBTH4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 02:56:39 -0500
X-Google-Smtp-Source: AH8x226ugNKiC8kbCEt/6vXwtZI1B5KlSq0ONxKXTp9v+WLEBdWovVBJlsjY2ac1Uu3YhgouNdVfhPUbjiyoFqy42ww=
MIME-Version: 1.0
In-Reply-To: <20180217204433.3095-9-manivannan.sadhasivam@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org> <20180217204433.3095-9-manivannan.sadhasivam@linaro.org>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Tue, 20 Feb 2018 08:55:57 +0100
Message-ID: <CAOFm3uEYhMxMz5QHDhOtpzEsrwJPrOdqLbGWTqveuNMtR_FVWA@mail.gmail.com>
Subject: Re: [PATCH 08/10] gpio: Add gpio driver for Actions OWL S900 SoC
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>, amit.kucheria@linaro.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manivannan,

On Sat, Feb 17, 2018 at 9:44 PM, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
> Add gpio driver for Actions Semi OWL family S900 SoC. Set of registers
> controlling the gpio shares the same register range with pinctrl block.
>
> GPIO registers are organized as 6 banks and each bank controls the
> maximum of 32 gpios.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

<snip>

> --- /dev/null
> +++ b/drivers/gpio/gpio-owl.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0+

<snip>

> +MODULE_LICENSE("GPL v2");

Please sync this with your SPDX id above. nodule.h has the doc on the
meaning of MODULE_LICENSE macros.
Here you have stated a combo of GPL-2.0 and GPL-2.0 or later

-- 
Cordially
Philippe Ombredanne
