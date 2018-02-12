Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934290AbeBLLyC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 06:54:02 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:36476 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933898AbeBLLyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 06:54:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date: Mon, 12 Feb 2018 12:53:59 +0100
From: Stefan Agner <stefan@agner.ch>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Baruch Siach <baruch@tkos.co.il>, linus.walleij@linaro.org,
        aisheng.dong@nxp.com, fabio.estevam@nxp.com, shawnguo@kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] MAINTAINERS: add Freescale pin controllers
In-Reply-To: <1518435295.2744.7.camel@pengutronix.de>
References: <20180210153204.12728-1-stefan@agner.ch>
 <1518432502.2744.5.camel@pengutronix.de>
 <20180212112255.u333xb676kfmi63f@sapphire.tkos.co.il>
 <1518435295.2744.7.camel@pengutronix.de>
Message-ID: <3701bd50c7b3269af308223a1712f6d9@agner.ch>
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.02.2018 12:34, Lucas Stach wrote:
> Am Montag, den 12.02.2018, 13:22 +0200 schrieb Baruch Siach:
>> Hi Lucas,
>>
>> On Mon, Feb 12, 2018 at 11:48:22AM +0100, Lucas Stach wrote:
>> > Am Samstag, den 10.02.2018, 16:32 +0100 schrieb Stefan Agner:
>> > > Add Dong Aisheng, Fabio Estevam, Shawn Guo and myself as
>> > > maintainer
>> > > and Sascha as reviewer.
>> > >
>> > > Signed-off-by: Stefan Agner <stefan@agner.ch>
>> > > ---
>> > >  MAINTAINERS | 11 +++++++++++
>> > >  1 file changed, 11 insertions(+)
>> > >
>> > > diff --git a/MAINTAINERS b/MAINTAINERS
>> > > index 82ad0eabce4f..fb672dfc519d 100644
>> > > --- a/MAINTAINERS
>> > > +++ b/MAINTAINERS
>> > > @@ -10768,6 +10768,17 @@ L:	linux-gpio@vger.kernel.org
>> > >  S:	Supported
>> > >  F:	drivers/pinctrl/pinctrl-at91-pio4.*
>> > >  
>> > > +PIN CONTROLLER - FREESCALE
>> > > +M:	Dong Aisheng <aisheng.dong@nxp.com>
>> > > +M:	Fabio Estevam <festevam@gmail.com>
>> > > +M:	Shawn Guo <shawnguo@kernel.org>
>> > > +M:	Stefan Agner <stefan@agner.ch>
>> > > +R:	Sascha Hauer <kernel@pengutronix.de>
>> >
>> > I'm fine with the patch, but it might make sense to clarify this a
>> > bit:
>> > the kernel@ address is really the whole Pengutronix kernel team,
>> > not
>> > just Sascha. Using this address is totally fine if you expect
>> > comments
>> > on patches, as it gives them a quite wide exposure inside of PTX.
>>
>> Of the 5 mentions of kernel@pengutronix.de in MAINTAINERS as of
>> v4.16-rc1, 
>> three name Sascha, and two name Uwe. Would you like to also clarify
>> those?
> 
> I think it fine to keep the names of the individual people where they
> maintain stuff, as this is usually bound to a single person (where
> kernel@ address is only used for the exposure benefits), but I think it
> makes less sense for the reviewer role.

Sounds reasonable, I will send a v2 with:
R:	Pengutronix Kernel Team <kernel@pengutronix.de>

--
Stefan

> 
> Regards,
> Lucas
