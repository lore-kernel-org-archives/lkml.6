Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeDEGrL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 02:47:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35028 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750915AbeDEGrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 02:47:10 -0400
Date: Thu, 5 Apr 2018 08:46:58 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v5 1/3] regulator: axp20x: add drivevbus support for
 axp803
Message-ID: <20180405064658.rz2grnpm5fq45lhu@flea>
References: <20180327053104.3812-1-jagan@amarulasolutions.com>
 <CAMty3ZD3ohpgqsBjgNztpyHOmmcu_y7vuUOoop8y-+OpWjLYGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wntvldttjn7llp4a"
Content-Disposition: inline
In-Reply-To: <CAMty3ZD3ohpgqsBjgNztpyHOmmcu_y7vuUOoop8y-+OpWjLYGA@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wntvldttjn7llp4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 12:11:39PM +0530, Jagan Teki wrote:
> On Tue, Mar 27, 2018 at 11:01 AM, Jagan Teki <jagan@amarulasolutions.com>=
 wrote:
> > Like axp221, axp223, axp813 the axp803 is also supporting external
> > regulator to drive the  OTG VBus through N_VBUSEN PMIC pin.
> >
> > Add support for it.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> > Changes for v5:
> > - Collect Chen-Yu reviewed-by tag
> > Changes for v4:
> > - rebase on master
> > Changes for v3:
> > - Update drivevbus in table of regulators
>=20
> Can you pick these, has some dependency with drivevbus on other
> patches.

I'm not the regulator maintainer, nor the AXP maintainer for that
matter. Mark Brown and Chen-Yu are, respectively.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--wntvldttjn7llp4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrFxl4ACgkQ0rTAlCFN
r3QhAg/9FD5xvW3vhhQnFZcuMQ8JwfNw7JEdKzwjaWsdtF/Gx+mhrDHTDoCEafKB
INukxQJYewfyArhwHObg0drLBBDvAdHTkXC0Dqe84ge1nRXGxdP+gcoSPjYy6Qaz
glxbwtt91ddZT0njWA2GkAfNhPK7obZH87omhe4A22At98d7FBi4ot7gM4UqcIIJ
FNI1Ft3z6ne1qYdKBumQawsx5hNy4iRpiDj17KBOAB3dBRpS0vecwIEnkOOgIFkA
55ZOWWbhaMUGHbhv8oDO4XliLvPquDzNJlvc5b9jlIvw77IpU1s4QrPL2ruhVbp7
SDWiIHgme8pHoUDKxj7KhKeUd8nUMcJxulXbWu+8AbQ4ddNlOiN4Lcc+lbdvfNeK
0nqVrd7HT4FG6IBZ9Ix680LBfa9YeE9EYnTNjdwtzf/Kqqt1A7uduh8X1QRSn9Oh
7gHXTF9RYvux/v9nouwznHMjakc/9C2f1ePWc1L7feHaYTwEY4nb/UYhOtxd/FCu
+2GFF1awxuMJjEkZ2uOYyCPOJ7jLWIQixEyqIssf4oH9qOvpFUFCGxoUIp2ZuceM
gH5fsa+6zmzOCLMfdQ3nhHe3+MafnS+RQNmPADZJ7WONNGSxp22Cdf6seg/EPh5Y
pSQI4wRorYJz1ZgDn566Y3A4JEJZ8DJWA01d9zZ3TDAijPISpaI=
=46oY
-----END PGP SIGNATURE-----

--wntvldttjn7llp4a--
