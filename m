Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAC5C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAE120671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EAE120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbeG0K2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:28:09 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39845 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729498AbeG0K2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:28:09 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1fiyiC-0008S1-R0; Fri, 27 Jul 2018 11:07:00 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1fiyiB-0004LG-7C; Fri, 27 Jul 2018 11:06:59 +0200
Date:   Fri, 27 Jul 2018 11:06:59 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
Message-ID: <20180727090659.6nbfrhaliyt7kyhx@pengutronix.de>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-2-o.rempel@pengutronix.de>
 <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
 <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <1532680211.32306.36.camel@pengutronix.de>
 <DB6PR04MB32239840E3DF12328A3E7E47892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2lwgmfoygqy6knol"
Content-Disposition: inline
In-Reply-To: <DB6PR04MB32239840E3DF12328A3E7E47892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:05:45 up 217 days, 21:43, 60 users,  load average: 1.05, 1.08,
 1.03
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2lwgmfoygqy6knol
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 08:58:22AM +0000, Robin Gong wrote:
>=20
>=20
> > -----Original Message-----
> > From: Lucas Stach [mailto:l.stach@pengutronix.de]
> > Sent: 2018=E5=B9=B47=E6=9C=8827=E6=97=A5 16:30
> > To: Robin Gong <yibin.gong@nxp.com>; Oleksij Rempel
> > <o.rempel@pengutronix.de>; Shawn Guo <shawnguo@kernel.org>; Mark
> > Brown <broonie@kernel.org>; Rafael J. Wysocki <rafael.j.wysocki@intel.c=
om>
> > Cc: Mark Rutland <mark.rutland@arm.com>; devicetree@vger.kernel.org;
> > Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> > <sboyd@codeaurora.org>; linux-kernel@vger.kernel.org; Liam Girdwood
> > <lgirdwood@gmail.com>; Rob Herring <robh+dt@kernel.org>; dl-linux-imx
> > <linux-imx@nxp.com>; kernel@pengutronix.de; A.s. Dong
> > <aisheng.dong@nxp.com>; Fabio Estevam <fabio.estevam@nxp.com>; Russell
> > King <linux@armlinux.org.uk>; Andrew Morton <akpm@linux-foundation.org>;
> > Leonard Crestez <leonard.crestez@nxp.com>; linux-clk@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
> > fsl,pmic-stby-poweroff property
> >=20
> > Hi Robin,
> >=20
> > Am Freitag, den 27.07.2018, 01:51 +0000 schrieb Robin Gong:
> > [...]
> > > > > > ---
> > > > > > =C2=A0Documentation/devicetree/bindings/clock/imx6q-clock.txt |=
 8
> > > > > > ++++++++
> > > > > > =C2=A01 file changed, 8 insertions(+)
> > > > > >
> > > > > > diff --git
> > > > > > a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > > > > b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > > > > index a45ca67a9d5f..e1308346e00d 100644
> > > > > > --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > > > > +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > > > > > @@ -6,6 +6,14 @@ Required properties:
> > > > > > =C2=A0- interrupts: Should contain CCM interrupt
> > > > > > =C2=A0- #clock-cells: Should be <1>
> > > > > >
> > > > > > +Optional properties:
> > > > > > +- fsl,pmic-stby-poweroff: Configure CCM to assert PMIC_STBY_REQ
> > > > > > +signal
> > > > > > +=C2=A0=C2=A0on power off.
> > > > > > +=C2=A0=C2=A0Use this property if the SoC should be powered off=
 by
> > > > > > +external power
> > > > > > +=C2=A0=C2=A0management IC (PMIC) triggered via PMIC_STBY_REQ s=
ignal.
> > > > >
> > > > > PMIC_ON_REQ didn't connect to any pin of PMIC in your case?
> > > >
> > > > No. First, it was only one customer specific issue. After some
> > > > research I found even publicly available boards (for example
> > > > RioTboard) which has same/similar design. After seeing this in imx6
> > > > documentation as valid power off way, I have no doubts - there shou=
ld be
> > even more devices doin this in the wild.
> > >
> > > Not sure why the customer didn't follow reference design, since
> > > PMIC_ON_REQ can provide power off/on feature by pressing ONOFF key
> > > which connected ONOFF pin of i.mx6(ONOFF will toggle PMIC_ON_REQ to
> > > power off/on PMIC). The official power off/on way (PMIC_ON_REQ) can
> > > also power off all power rails of PFUZE except snvs as your patch did
> > > on PMIC_STBY_REQ.=C2=A0=C2=A0PMIC_STBY_REQ is used to notify pmic swi=
tch power
> > > mode (PFM/APS) or decrease voltage to save power in kernel suspend, n=
ot
> > power off....I am not sure if we need this patchset to 'workaround' the=
 board
> > issue.
> > >
> > Not all boards follow the reference design, that's a fact of life.
> >=20
> > Please look at the i.MX6Q reference manual. The sequence implemented in=
 this
> > patchset can be found as a valid way to power off the system in
> > "60.4.3 Power mode transitions" "Normal ON to OFF with external PMIC", =
so
> > there is hardly any way to argue that this is a board specific quirk. T=
his is one of
> > the Freescale/NXP recommended sequences to turn off the system.
> Okay, but could you add one more comment for this solution? RTC alarm and=
 ONOFF
> Button wakeup feature can't be support in this case.

Sure, at least it will power off. It make no sense to have power off
functionality which use same amount of power as power on system.

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--2lwgmfoygqy6knol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlta4LAACgkQdQOiSHVI
77QmpAf/TFsUXw3Ab5FPk0VQ3hztHFBOWt/dkfUxh7I45l40h6ShHQhNCcBKI697
6fC5BBspcpVYOesO5JKrz5pFpBBdCQy5PseLk+WlWufet6sF89Y29f2krI/2OAw6
QuExD+6KRSPW5qmv2eFTQQXgCmPPnmI49582T1miYndKEQ6aa1tSmVrq2N+vqSgp
lO7Nk5FSMzc7g9qvkaWuBP2qX8EFpLJqbjFFdWPKz6YdRSdSJZ7tuTBSGgEuQZWZ
nXAiVX8PVKyDqe+GFtXgLX+jXdv28gfIvbWVjUQ2z1GdLsFonQw6rKBW3rLr9Ogf
3AKUObX9WfC3RL7XlIxd8uxnoxYzsg==
=1b+O
-----END PGP SIGNATURE-----

--2lwgmfoygqy6knol--
