Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753400AbeBSRkP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:40:15 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40332 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753336AbeBSRkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:40:12 -0500
X-Google-Smtp-Source: AH8x224/BhGI+pNHwY6SolSYS+9d2HHXLu5hWx5XNPI9M16cMxfPBZ5SQHRTKkbXsleY6PcmnXTM1A==
Date: Mon, 19 Feb 2018 23:10:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: linus.walleij@linaro.org, robh+dt@kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Add Actions Semi S900 pinctrl and gpio support
Message-ID: <20180219174003.ocijnddmftktxftb@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <72e49775-3a3e-0b47-61e9-079d4be6c9d9@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72e49775-3a3e-0b47-61e9-079d4be6c9d9@suse.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 10:19:50PM +0100, Andreas Färber wrote:
> Am 17.02.2018 um 21:44 schrieb Manivannan Sadhasivam:
> > This patchset adds pinctrl and gpio support for Actions Semi S900 SoC.
> > Pinctrl and gpio subsystems share the common set of register range but
> > implemented as individual drivers for making it less complex.
> > 
> > Pinmux functions are only accessible for pin groups while pinconf
> > parameters are available for both pin groups and individual pins.
> > 
> > gpio-line-names has been added for the Bubblegum-96 board matching the
> > 96Boards CE specification v1.0.
> > 
> > Both pinctrl and gpio drivers are verified using the Bubblegum-96 board.
> > 
> > This patchset depends on the clock driver which is still under review:
> > https://lkml.org/lkml/2018/2/9/831
> 
> What this forgets to point out is that I had authored pinctrl and gpio
> drivers for S500, with preparations for S700 and S900, derived from my
> to-be-submitted pinctrl/gpio drivers for RTD1295, while this one was
> developed independently by Mani for S900. Our intention is to align them
> as part of patch review and redo S500 on top of the result.
>

Sorry for not mentioning that (not intentional). So, I'll push out V2 of the
pinctrl and gpio drivers incorporating all review comments. If that looks
good then we can work on adding S500 support on top of it.

Otherwise we can look on integrating S900 pinctrl definitions with your base
driver. Anyway, for making it easier for comparing both drivers, are you going
to submit yours?
> Regards,
> Andreas
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
