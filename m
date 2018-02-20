Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeBTHyG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 02:54:06 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:40438 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbeBTHyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 02:54:04 -0500
X-Google-Smtp-Source: AH8x224EL705czNjT3xVzBMCCfixSWlZC4d6QUC2EF6MRbnO/rfbzN9YM7OC3OmWscqi91F2GJz7jtXzXALoyzT98Ek=
MIME-Version: 1.0
In-Reply-To: <20180217204433.3095-5-manivannan.sadhasivam@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org> <20180217204433.3095-5-manivannan.sadhasivam@linaro.org>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Tue, 20 Feb 2018 08:53:22 +0100
Message-ID: <CAOFm3uF=n+_TJUAuXh-KihA6gprJaLMiH+y6b3y-5QpcGqGNtg@mail.gmail.com>
Subject: Re: [PATCH 04/10] pinctrl: actions: Add Actions S900 pinctrl driver
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

Dear Manivannan,

On Sat, Feb 17, 2018 at 9:44 PM, Manivannan Sadhasivam
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


<snip>


> --- /dev/null
> +++ b/drivers/pinctrl/actions/pinctrl-s900.c
> @@ -0,0 +1,2536 @@
> +// SPDX-License-Identifier: GPL-2.0+

<snip>

> +MODULE_LICENSE("GPL v2");

This does not match your license above. Per module.h "GPL v2" means
GPL-2.0 where you license above GPL-2.0+ means or later

-- 
Cordially
Philippe Ombredanne
