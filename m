Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934016AbeBLLXB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:23:01 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:33970 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933898AbeBLLXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:23:00 -0500
Date: Mon, 12 Feb 2018 13:22:55 +0200
From: Baruch Siach <baruch@tkos.co.il>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Stefan Agner <stefan@agner.ch>, linus.walleij@linaro.org,
        aisheng.dong@nxp.com, fabio.estevam@nxp.com, shawnguo@kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: add Freescale pin controllers
Message-ID: <20180212112255.u333xb676kfmi63f@sapphire.tkos.co.il>
References: <20180210153204.12728-1-stefan@agner.ch>
 <1518432502.2744.5.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518432502.2744.5.camel@pengutronix.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

On Mon, Feb 12, 2018 at 11:48:22AM +0100, Lucas Stach wrote:
> Am Samstag, den 10.02.2018, 16:32 +0100 schrieb Stefan Agner:
> > Add Dong Aisheng, Fabio Estevam, Shawn Guo and myself as maintainer
> > and Sascha as reviewer.
> > 
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > ---
> >  MAINTAINERS | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 82ad0eabce4f..fb672dfc519d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -10768,6 +10768,17 @@ L:	linux-gpio@vger.kernel.org
> >  S:	Supported
> >  F:	drivers/pinctrl/pinctrl-at91-pio4.*
> >  
> > +PIN CONTROLLER - FREESCALE
> > +M:	Dong Aisheng <aisheng.dong@nxp.com>
> > +M:	Fabio Estevam <festevam@gmail.com>
> > +M:	Shawn Guo <shawnguo@kernel.org>
> > +M:	Stefan Agner <stefan@agner.ch>
> > +R:	Sascha Hauer <kernel@pengutronix.de>
> 
> I'm fine with the patch, but it might make sense to clarify this a bit:
> the kernel@ address is really the whole Pengutronix kernel team, not
> just Sascha. Using this address is totally fine if you expect comments
> on patches, as it gives them a quite wide exposure inside of PTX.

Of the 5 mentions of kernel@pengutronix.de in MAINTAINERS as of v4.16-rc1, 
three name Sascha, and two name Uwe. Would you like to also clarify those?

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
