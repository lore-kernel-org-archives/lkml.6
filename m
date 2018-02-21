Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938041AbeBUO47 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:56:59 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34258 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937392AbeBUO44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:56:56 -0500
X-Google-Smtp-Source: AH8x224J1ki9kFOJZQlXtY8qaCdVReBFES9dwk1lSO+PfhQYuJr1kMU2w12XdP/ehagApy1P/pQ0pw==
Date: Wed, 21 Feb 2018 20:26:47 +0530
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
Subject: Re: [PATCH 04/10] pinctrl: actions: Add Actions S900 pinctrl driver
Message-ID: <20180221145646.i4v2ez5uwscy3gm2@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-5-manivannan.sadhasivam@linaro.org>
 <CAOFm3uF=n+_TJUAuXh-KihA6gprJaLMiH+y6b3y-5QpcGqGNtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOFm3uF=n+_TJUAuXh-KihA6gprJaLMiH+y6b3y-5QpcGqGNtg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe,
On Tue, Feb 20, 2018 at 08:53:22AM +0100, Philippe Ombredanne wrote:
> Dear Manivannan,
> 
> On Sat, Feb 17, 2018 at 9:44 PM, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > Add pinctrl driver for Actions Semi S900 SoC. The driver supports
> > pinctrl, pinmux and pinconf functionalities through a range of registers
> > common to both gpio driver and pinctrl driver.
> >
> > Pinmux functionality is available only for the pin groups while the
> > pinconf functionality is available for both pin groups and individual
> > pins.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> 
> <snip>
> 
> 
> > --- /dev/null
> > +++ b/drivers/pinctrl/actions/pinctrl-s900.c
> > @@ -0,0 +1,2536 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> 
> <snip>
> 
> > +MODULE_LICENSE("GPL v2");
> 
> This does not match your license above. Per module.h "GPL v2" means
> GPL-2.0 where you license above GPL-2.0+ means or later
> 
Should be MODULE_LICENSE("GPL"). Will get it fixed in next revision.

Thanks,
Mani
> -- 
> Cordially
> Philippe Ombredanne
