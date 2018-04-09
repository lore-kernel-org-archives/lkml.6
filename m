Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeDILkc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:40:32 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56732 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbeDILka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:40:30 -0400
Date: Mon, 9 Apr 2018 12:40:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH RESEND v6 0/6] provide power off support for iMX6 with
 external PMIC
Message-ID: <20180409114022.GE11532@sirena.org.uk>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180409113744.GA14582@dragon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LSp5EJdfMPwZcMS1"
Content-Disposition: inline
In-Reply-To: <20180409113744.GA14582@dragon>
X-Cookie: Professional sample - not for sale.
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LSp5EJdfMPwZcMS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 09, 2018 at 07:37:45PM +0800, Shawn Guo wrote:
> On Mon, Mar 05, 2018 at 11:25:17AM +0100, Oleksij Rempel wrote:

> > As this patch set touches multiple subsystems I think it would make
> > sense for Shawn Guo to take the all patch set.
> > The only part which didn't receive an ACK is regulator stuff. So I would
> > hope that Mark Brown can ACK it.

> Besides regulator changes, I did not see an ACK on kernel/reboot.c
> either.

Right, that's the big blocker here.

--LSp5EJdfMPwZcMS1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrLUSUACgkQJNaLcl1U
h9BWmwf+N5uf/xy/Y7tUhi0MpSGVD1lUHK47H5HyGbL5k4RIzZMAvODp6i4dSUgD
5OEvkIrJ5PZFhijPsmMzxPFzoh7PcetVTnoUpvQj0DhZ5y7GBRVl8Oa68LFSi9K3
bUYdUwxo4XugrTIM666rIHvGo3pq7wQ5zE5pBr2k5vHmiCsm8nb0cU+C/nwDzK+0
dVtchKQxjhJU9fj0bPLaVZ1vy6Qm2Dwom6tgU9WHfKA9TJgKv/zW1i83d8iHwBO8
o5O7ZTe5n/hv4FF+EGY2vJvuE5ORgqcyAXvM7BL9wiR2XQUk8A3ZeKWiRpty34zk
qFTdxA78pancA+KyjBieWA1KYOUlsw==
=3drf
-----END PGP SIGNATURE-----

--LSp5EJdfMPwZcMS1--
