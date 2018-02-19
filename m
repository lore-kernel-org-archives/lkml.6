Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753409AbeBSRbL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:31:11 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33233 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753337AbeBSRbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:31:08 -0500
X-Google-Smtp-Source: AH8x22429Nc/+Ai0xKqKPnfEXJ89MlfeZ0Z5BNi0QPQtO4/8vbNzEM8kpB0xx0u+D+F+AQi482Pvcw==
Date: Mon, 19 Feb 2018 23:00:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: linus.walleij@linaro.org, robh+dt@kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] MAINTAINERS: Add Actions Semi S900 pinctrl and
 gpio entries
Message-ID: <20180219173059.t2ezyjkszkr6wsf7@linaro.org>
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
 <20180217204433.3095-11-manivannan.sadhasivam@linaro.org>
 <9a7720b7-586e-8275-db41-19764e40f367@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9a7720b7-586e-8275-db41-19764e40f367@suse.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2018 at 10:21:27PM +0100, Andreas Färber wrote:
> Am 17.02.2018 um 21:44 schrieb Manivannan Sadhasivam:
> > Add S900 pinctrl and gpio entries under ARCH_ACTIONS
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  MAINTAINERS | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 96b8b6531196..b718be5af680 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1126,11 +1126,15 @@ F:	arch/arm/boot/dts/owl-*
> >  F:	arch/arm64/boot/dts/actions/
> >  F:	drivers/clocksource/owl-*
> >  F:	drivers/soc/actions/
> > +F:	drivers/pinctrl/actions/*
> > +F:	drivers/gpio/gpio-owl.c
> >  F:	include/dt-bindings/power/owl-*
> >  F:	include/linux/soc/actions/
> >  F:	Documentation/devicetree/bindings/arm/actions.txt
> >  F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
> >  F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
> > +F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
> > +F:	Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
> 
> Please retain alphabetical ordering.
>
Okay.

Thanks,
Mani 
> Regards,
> Andreas
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
