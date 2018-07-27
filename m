Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9756CC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7E820893
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7E820893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbeG0KCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:02:35 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46979 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbeG0KCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:02:35 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1fiyJd-00058x-7e; Fri, 27 Jul 2018 10:41:37 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1fiyJa-0003Cd-Ev; Fri, 27 Jul 2018 10:41:34 +0200
Date:   Fri, 27 Jul 2018 10:41:34 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>,
        dl-linux-imx <linux-imx@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>
Subject: Re: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
 fsl,pmic-stby-poweroff property
Message-ID: <20180727084134.f43jwgt2w57vuerm@pengutronix.de>
References: <20180726092220.17250-1-o.rempel@pengutronix.de>
 <20180726092220.17250-2-o.rempel@pengutronix.de>
 <DB6PR04MB3223605CB1F5E06D4A278B3C892B0@DB6PR04MB3223.eurprd04.prod.outlook.com>
 <84c1921c-922e-4b5d-b688-db89047fa1db@pengutronix.de>
 <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wtka2h7mm3kvfpat"
Content-Disposition: inline
In-Reply-To: <DB6PR04MB32236EA307DCD070771B1D4D892A0@DB6PR04MB3223.eurprd04.prod.outlook.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:21:11 up 217 days, 20:59, 60 users,  load average: 1.10, 1.05,
 1.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wtka2h7mm3kvfpat
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 27, 2018 at 01:51:35AM +0000, Robin Gong wrote:
>=20
>=20
> > -----Original Message-----
> > From: Oleksij Rempel [mailto:o.rempel@pengutronix.de]
> > Sent: 2018=E5=B9=B47=E6=9C=8826=E6=97=A5 19:38
> > To: Robin Gong <yibin.gong@nxp.com>; Shawn Guo <shawnguo@kernel.org>;
> > Mark Brown <broonie@kernel.org>; Rafael J. Wysocki
> > <rafael.j.wysocki@intel.com>
> > Cc: kernel@pengutronix.de; devicetree@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-clk@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Andrew Morton <akpm@linux-foundation.org>;
> > Liam Girdwood <lgirdwood@gmail.com>; Leonard Crestez
> > <leonard.crestez@nxp.com>; Rob Herring <robh+dt@kernel.org>; Mark
> > Rutland <mark.rutland@arm.com>; Michael Turquette
> > <mturquette@baylibre.com>; Stephen Boyd <sboyd@codeaurora.org>; Fabio
> > Estevam <fabio.estevam@nxp.com>; Russell King <linux@armlinux.org.uk>;
> > dl-linux-imx <linux-imx@nxp.com>; A.s. Dong <aisheng.dong@nxp.com>
> > Subject: Re: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
> > fsl,pmic-stby-poweroff property
> >=20
> > Hi,
> >=20
> > On 26.07.2018 11:51, Robin Gong wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Oleksij Rempel [mailto:o.rempel@pengutronix.de]
> > >> Sent: 2018=E5=B9=B47=E6=9C=8826=E6=97=A5 17:22
> > >> To: Shawn Guo <shawnguo@kernel.org>; Mark Brown
> > <broonie@kernel.org>;
> > >> Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >> Cc: Oleksij Rempel <o.rempel@pengutronix.de>; kernel@pengutronix.de;
> > >> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > >> linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; Andrew
> > >> Morton <akpm@linux-foundation.org>; Liam Girdwood
> > >> <lgirdwood@gmail.com>; Leonard Crestez <leonard.crestez@nxp.com>;
> > Rob
> > >> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> > >> Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> > >> <sboyd@codeaurora.org>; Fabio Estevam <fabio.estevam@nxp.com>;
> > >> Russell King <linux@armlinux.org.uk>; dl-linux-imx
> > >> <linux-imx@nxp.com>; Robin Gong <yibin.gong@nxp.com>; A.s. Dong
> > >> <aisheng.dong@nxp.com>
> > >> Subject: [PATCH v8 1/6] ARM: imx6q: provide documentation for new
> > >> fsl,pmic-stby-poweroff property
> > >>
> > >> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > >> Acked-by: Rob Herring <robh@kernel.org>
> > >> ---
> > >>  Documentation/devicetree/bindings/clock/imx6q-clock.txt | 8 ++++++++
> > >>  1 file changed, 8 insertions(+)
> > >>
> > >> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > >> b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > >> index a45ca67a9d5f..e1308346e00d 100644
> > >> --- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > >> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
> > >> @@ -6,6 +6,14 @@ Required properties:
> > >>  - interrupts: Should contain CCM interrupt
> > >>  - #clock-cells: Should be <1>
> > >>
> > >> +Optional properties:
> > >> +- fsl,pmic-stby-poweroff: Configure CCM to assert PMIC_STBY_REQ
> > >> +signal
> > >> +  on power off.
> > >> +  Use this property if the SoC should be powered off by external
> > >> +power
> > >> +  management IC (PMIC) triggered via PMIC_STBY_REQ signal.
> > > PMIC_ON_REQ didn't connect to any pin of PMIC in your case?
> >=20
> > No. First, it was only one customer specific issue. After some research=
 I found
> > even publicly available boards (for example RioTboard) which has same/s=
imilar
> > design. After seeing this in imx6 documentation as valid power off way,=
 I have
> > no doubts - there should be even more devices doin this in the wild.
> Not sure why the customer didn't follow reference design, since PMIC_ON_R=
EQ can
> provide power off/on feature by pressing ONOFF key which connected ONOFF
> pin of i.mx6(ONOFF will toggle PMIC_ON_REQ to power off/on PMIC). The off=
icial
> power off/on way (PMIC_ON_REQ) can also power off all power rails of PFUZ=
E except
> snvs as your patch did on PMIC_STBY_REQ.  PMIC_STBY_REQ is used to notify=
 pmic
> switch power mode (PFM/APS) or decrease voltage to save power in kernel s=
uspend,
> not power off....I am not sure if we need this patchset to 'workaround' t=
he board issue.
> >=20
> > > Don't understand
> > > why not follow normal board design guide to power off pmic by
> > PMIC_ON_REQ.
> > > How to power on board again then?
> >=20
> > Power cycle. Without this patch, power of is not real power off. So, po=
wer cycle,
> > is expected behavior for user interaction. On usual PC, reset button wi=
ll not
> > enable PC as well.
> Your board can't support wakeup by RTC alarm if not use PMIC_ON_REQ to po=
wer off.
> Again, why your board not follow the design guide?

Just wild assumption: you haven't read comment provided in patch:
Subject: [PATCH v8 2/6] ARM: imx6: register pm_power_off handler if
 "fsl,pmic-stby-poweroff" is set

One of the Freescale recommended sequences for power off with external
PMIC is the following:
=2E..
3.  SoC is programming PMIC for power off when standby is asserted.
4.  In CCM STOP mode, Standby is asserted, PMIC gates SoC supplies.

See:
http://www.nxp.com/assets/documents/data/en/reference-manuals/IMX6DQRM.pdf
page 5083

This patch implements step 4. of this sequence.

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--wtka2h7mm3kvfpat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEpENFL0P3hvQ7p0DDdQOiSHVI77QFAlta2rsACgkQdQOiSHVI
77TNJgf/U4He/gqLXuUyZhn0d0AFKr+UYvH5TL33NlUr7/W9rqgucdcAcYLwxQoB
T1TFZigKh+AxR8XcF9b0RpJHJs+8LEw33r6ZNLDa19Byo3qiL74neXbG+a34DS3x
PsgEjg9Np5POpwX2LT75VwzJk5BY/nv705479IIeCEqQNycccBnYMIWoS4PHaIO1
W1TvPAL58rxPZA6hUO8rDNqVrimjHuPV9QLTZ8/CJ7bFbbjVxIeadlS1GnqQDFHH
kJDevwM9d29DF0CSMudM9YQ7j1P7G2k98tpXEQ8Hat/WvzaIOwyErIkKvPLl4/7q
oQeE0HMpfZyUrUj6zjagH3Lc6cG5+w==
=UUIr
-----END PGP SIGNATURE-----

--wtka2h7mm3kvfpat--
