Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033911AbeCASYk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:24:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56762 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033770AbeCASYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:24:38 -0500
Date: Thu, 1 Mar 2018 18:24:36 +0000
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: brgl@bgdev.pl, david@lechnology.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: regmap: Failed to create debugfs directory
Message-ID: <20180301182436.GI12864@sirena.org.uk>
References: <CAOMZO5BsSpi_40ky5L_XafxNULnprphv9nhPCQVNgi+vmexD+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZOudaV4lSIjFTlHv"
Content-Disposition: inline
In-Reply-To: <CAOMZO5BsSpi_40ky5L_XafxNULnprphv9nhPCQVNgi+vmexD+Q@mail.gmail.com>
X-Cookie: Real Users hate Real Programmers.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZOudaV4lSIjFTlHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 01, 2018 at 03:19:50PM -0300, Fabio Estevam wrote:
> Hi,
>=20
> Running linux-next 20180301 on a imx6q-sabresd the following
> regmap-debugfs warnings are seen:

Is this triggered by 9b947a13e7f6017f18 (regmap: use debugfs even when
no device)?

>=20
> [    0.067965] CPU identified as i.MX6Q, silicon rev 1.2
> [    0.083466] vdd1p1: supplied by regulator-dummy
> [    0.084768] vdd3p0: supplied by regulator-dummy
> [    0.085816] vdd2p5: supplied by regulator-dummy
> [    0.109831] (NULL device *): Failed to create debugfs directory
> ....
>=20
> [    2.961117] input: EETI eGalax Touch Screen as
> /devices/soc0/soc/2100000.aips-bus/21a8000.i2c/i2c-2/2-0004/input/input0
> [    2.977027] (NULL device *): Failed to create debugfs directory
> [    2.983929] snvs_rtc 20cc000.snvs:snvs-rtc-lp: rtc core: registered
> 20cc000.snvs:snvs-rtc-lp as rtc0
> [    2.993457] i2c /dev entries driver
> [    3.002084] (NULL device *): Failed to create debugfs directory
> [    3.010452] imx2-wdt 20c0000.wdog: timeout 60 sec (nowayout=3D0)
>=20
> I haven't started to debug this yet, but would like to know if anyone
> has any ideas?
>=20
> Thanks,
>=20
> Fabio Estevam

--ZOudaV4lSIjFTlHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYRWMACgkQJNaLcl1U
h9CRqQf/TvE6ic7iHsvx5v4g9l9IWt9YaLLp6mkzdNcFZx+EA7mJE1pR9IvbMBUw
sUFP0GC0iNkCIWwHyCMKgVykpRL1CIBAi02HAdKr0W8A0CQtzvbC+aHJCYs0L2E9
uVEnr0hzmFnBxGJ27NBTUgqNJY3LuPGsoi83XkKoupVdh1h7Ezjdz+lNAFb75aMy
Wb9c7YlZnblzpORp/73NhArsT9eDVQTdZX5vVnfRG3NolhiAq36NxSJF5ktpkiqp
W/kMKzg1KYeb8k/s7MU7VwP2LBVtMKIuOmhRxPGXwDDa1hWVTu7NH6eScXZBoVHi
KOmkPy8whYXL81+C7ciP8qCZIV1DUA==
=YwiK
-----END PGP SIGNATURE-----

--ZOudaV4lSIjFTlHv--
