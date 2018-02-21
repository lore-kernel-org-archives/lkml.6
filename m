Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937363AbeBUO4D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:56:03 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33288 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936893AbeBUOzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:55:37 -0500
X-Google-Smtp-Source: AH8x225lhvo8gFx6cJVl2BGNwBcOfWgdKu9xJN5qkOdx02/WrP0L9MSbGIdv2hNyJK04P83tiAX0IQ==
Date: Wed, 21 Feb 2018 20:25:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>, amit.kucheria@linaro.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/10] gpio: Add gpio driver for Actions OWL S900 SoC
Message-ID: <20180221145526.6kr7kx5dwg5lzyvg@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-9-manivannan.sadhasivam@linaro.org>
 <CAOFm3uEYhMxMz5QHDhOtpzEsrwJPrOdqLbGWTqveuNMtR_FVWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOFm3uEYhMxMz5QHDhOtpzEsrwJPrOdqLbGWTqveuNMtR_FVWA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,
On Tue, Feb 20, 2018 at 08:55:57AM +0100, Philippe Ombredanne wrote:
> Manivannan,
> 
> On Sat, Feb 17, 2018 at 9:44 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > Add gpio driver for Actions Semi OWL family S900 SoC. Set of registers
> > controlling the gpio shares the same register range with pinctrl block.
> >
> > GPIO registers are organized as 6 banks and each bank controls the
> > maximum of 32 gpios.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> <snip>
> 
> > --- /dev/null
> > +++ b/drivers/gpio/gpio-owl.c
> > @@ -0,0 +1,258 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> 
> <snip>
> 
> > +MODULE_LICENSE("GPL v2");
> 
> Please sync this with your SPDX id above. nodule.h has the doc on the
> meaning of MODULE_LICENSE macros.
> Here you have stated a combo of GPL-2.0 and GPL-2.0 or later
> 
Sorry. It should be MODULE_LICENSE("GPL"). Will get it fixed in next revision.

Thanks,
Mani
> -- 
> Cordially
> Philippe Ombredanne
