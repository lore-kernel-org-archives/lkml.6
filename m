Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934151AbeBLLfD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:35:03 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52771 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933981AbeBLLfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:35:01 -0500
Message-ID: <1518435295.2744.7.camel@pengutronix.de>
Subject: Re: [PATCH] MAINTAINERS: add Freescale pin controllers
From: Lucas Stach <l.stach@pengutronix.de>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Stefan Agner <stefan@agner.ch>, linus.walleij@linaro.org,
        aisheng.dong@nxp.com, fabio.estevam@nxp.com, shawnguo@kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date: Mon, 12 Feb 2018 12:34:55 +0100
In-Reply-To: <20180212112255.u333xb676kfmi63f@sapphire.tkos.co.il>
References: <20180210153204.12728-1-stefan@agner.ch>
         <1518432502.2744.5.camel@pengutronix.de>
         <20180212112255.u333xb676kfmi63f@sapphire.tkos.co.il>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:fa0f:41ff:fe58:4010
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, den 12.02.2018, 13:22 +0200 schrieb Baruch Siach:
> Hi Lucas,
> 
> On Mon, Feb 12, 2018 at 11:48:22AM +0100, Lucas Stach wrote:
> > Am Samstag, den 10.02.2018, 16:32 +0100 schrieb Stefan Agner:
> > > Add Dong Aisheng, Fabio Estevam, Shawn Guo and myself as
> > > maintainer
> > > and Sascha as reviewer.
> > > 
> > > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > > ---
> > >  MAINTAINERS | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 82ad0eabce4f..fb672dfc519d 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -10768,6 +10768,17 @@ L:	linux-gpio@vger.kernel.org
> > >  S:	Supported
> > >  F:	drivers/pinctrl/pinctrl-at91-pio4.*
> > >  
> > > +PIN CONTROLLER - FREESCALE
> > > +M:	Dong Aisheng <aisheng.dong@nxp.com>
> > > +M:	Fabio Estevam <festevam@gmail.com>
> > > +M:	Shawn Guo <shawnguo@kernel.org>
> > > +M:	Stefan Agner <stefan@agner.ch>
> > > +R:	Sascha Hauer <kernel@pengutronix.de>
> > 
> > I'm fine with the patch, but it might make sense to clarify this a
> > bit:
> > the kernel@ address is really the whole Pengutronix kernel team,
> > not
> > just Sascha. Using this address is totally fine if you expect
> > comments
> > on patches, as it gives them a quite wide exposure inside of PTX.
> 
> Of the 5 mentions of kernel@pengutronix.de in MAINTAINERS as of
> v4.16-rc1, 
> three name Sascha, and two name Uwe. Would you like to also clarify
> those?

I think it fine to keep the names of the individual people where they
maintain stuff, as this is usually bound to a single person (where
kernel@ address is only used for the exposure benefits), but I think it
makes less sense for the reviewer role.

Regards,
Lucas
