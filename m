Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034A1C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9722084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfAVLOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:14:22 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60478 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbfAVLOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:14:21 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 63DF22078C; Tue, 22 Jan 2019 12:14:18 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2BD8E206A7;
        Tue, 22 Jan 2019 12:14:08 +0100 (CET)
Date:   Tue, 22 Jan 2019 12:14:08 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v5 07/17] drm/sun4i: sun6i_mipi_dsi: Refactor vertical
 video start delay
Message-ID: <20190122111408.4zlhecsxywulvrfy@flea>
References: <20181211164900.wfmkmbrbj3nmlb3h@flea>
 <CAMty3ZB5F5jD9iJT1soXSA5HtQOf5W9rKO9nCdGFUfVo0hpO4Q@mail.gmail.com>
 <20190107141158.zaimizk4rlqa6xli@flea>
 <CAMty3ZBb8byOwh=_W83Ta0Dse1qkoqccOeaBEY9oHPaxDxe9QA@mail.gmail.com>
 <20190108085829.clianbtjovu3oieq@flea>
 <CAMty3ZC9OQtwT-iH=S1LhHsBPc_jFKGAnCYYeR9nuKuDWSKLQw@mail.gmail.com>
 <20190112164319.whr7gwvl4oux5svz@flea>
 <CAMty3ZD8X9KmHjUtAo-+Y83a2j8NF3DjM9Yr3LPMxOvQ8kOV7g@mail.gmail.com>
 <20190116191756.ajzzaga43srk77dk@flea>
 <CAMty3ZCw8itG=nizA5E218HT5kg=-xDzLmShF51vRh4ENYKuBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lpmn2jm2w26y3xo2"
Content-Disposition: inline
In-Reply-To: <CAMty3ZCw8itG=nizA5E218HT5kg=-xDzLmShF51vRh4ENYKuBA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lpmn2jm2w26y3xo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 17, 2019 at 10:02:12AM +0530, Jagan Teki wrote:
> On Thu, Jan 17, 2019 at 12:48 AM Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> >
> > On Sun, Jan 13, 2019 at 01:07:41AM +0530, Jagan Teki wrote:
> > > > > > > > Again, I cannot help you without the datasheet for the pane=
ls you're
> > > > > > > > trying to submit.
> > > > > > >
> > > > > > > The panel bound with Sitronix ST7701 IC
> > > > > > > http://www.startek-lcd.com/res/starteklcd/pdres/201705/201705=
12144242904.pdf
> > > > > >
> > > > > > It's the controller, not the panel
> > > > >
> > > > > As I said before, the datasheet of that panel doesn't have any
> > > > > information except electrical characteristics and used IC which is
> > > > > ST7701.
> > > > >
> > > > > I have one more panel, which is from Bananapi, S070WV20-CT16 ICN6=
21
> > > > > please find the attachment for the same.
> > > > >
> > > > > Here is some more details of the same.
> > > > >
> > > > > https://github.com/yesnoandor/x300/blob/master/kernel/arch/arm/bo=
ot/dts/erobbing/x300/x300.dtsi#L81
> > > > > https://github.com/wxzed/Raspberry_5MIPI_Display/blob/master/I2C_=
Slave/USER/main.c#L15
> > > > >
> > > > > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/ke=
rnel/drivers/video/msm/mdss/mdss_i2c_interface.c#L152
> > > > > matches timings for
> > > > > https://github.com/eliot-shao/qcom/blob/master/icn6211_cxn0102/ke=
rnel/arch/arm/boot/dts/qcom/dsi-mipi-2-rgb_1280p_video.dtsi#L20
> > > > >
> > > > > https://github.com/zestroly/micromat/blob/master/test/raspberry/I=
CN6211.cpp#L169
> > > >
> > > > Where did you get the timings from then?
> > >
> > > You mean drm_mode timings, the same panel with RGB available in
> > > panel-simple[1], and dsi driver in Mailing list[2] and actual DSI
> > > sequence commands from BSP[3]
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it/commit/drivers/gpu/drm/panel/panel-simple.c?id=3D7ad8b41cd8f5c2842646d01=
cdd576663caee04a7
> > > [2] https://patchwork.kernel.org/patch/10680331/
> > > [3] https://github.com/BPI-SINOVOIP/BPI-M64-bsp/blob/master/linux-sun=
xi/drivers/video/sunxi/disp2/disp/lcd/S070WV20_MIPI_RGB.c
> >
> > So you had no reliable source for the timings then? How do you know if
> > all your patches that are timing related are right then?
>=20
> I don't understand your point, or may be I confused with many links
> that I attached in previous mail.
>=20
> 1. Patch for same panel timings are already in Mainline that was
> tested on one of the board. [1]
> 2. Driver from AW, released bsp from BPI-M64-bsp [3]
>=20
> Do you think the above two points are not valid sources?

I'm saying that the only valid source is the datasheet or a DSI analyzer.

Maxmie

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lpmn2jm2w26y3xo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEb7AAAKCRDj7w1vZxhR
xS0fAQDHNLlvyCOc0d7sfDgkpCCnV2uB18j9NbgTDPWP1QmK1AD/XDTH92oI17hs
5fb6v71atKI/c3In5qsOSLUKIicisAQ=
=fPrs
-----END PGP SIGNATURE-----

--lpmn2jm2w26y3xo2--
