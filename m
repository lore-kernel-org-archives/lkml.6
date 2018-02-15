Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755182AbeBOJIo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 04:08:44 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:46269 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755069AbeBOJIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 04:08:40 -0500
Date: Thu, 15 Feb 2018 10:08:38 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 0/2] Fix broken bananapi m2 devicetree/regulators
Message-ID: <20180215090838.fnenymzrejs6vhcf@flea.home>
References: <20180214141025.22171-1-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pezhon6uik27e2hh"
Content-Disposition: inline
In-Reply-To: <20180214141025.22171-1-embed3d@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pezhon6uik27e2hh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2018 at 03:10:23PM +0100, Philipp Rossak wrote:
> This patchseries fixes the bananapi m1 devicetree, to be able to boot aga=
in.
> The first two patches update/improve the devicetree and the last patch ad=
ds
> all missing regulators.
>=20
> Regards,
> Philipp
>=20
> Changes since v1:
> 	* squashed commit 1 and 3
> 	* fix wrong mmc regulator
>=20
> Philipp Rossak (2):
>   arm: dts: sun6i: a31s: bpi-m2: improve pmic properties
>   arm: dts: sun6i: a31s: fix: bpi-m2: add missing regulators

Applied both.

I had to make a couple of changes though, in the commit title arm
should be uppercase, and the fix isn't needed.

I also added stable in Cc, since these patches have been there for
quite some time.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--pezhon6uik27e2hh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqFThUACgkQ0rTAlCFN
r3SYtA/+KYqTpkxcn4U+UE/F645lEn0rhrJt+dlSELrkIQ0dd2pZsW+FFloohSJb
GRxM77uLy/uvfhLEocQoJujJJU3UBvLGkYyQGeXQmSiQGcGaB5YCkUQNeN91tJF9
r5PTSPpE02qGQ7iU6PrvPpmoWTqZlkKe/59ouZoxA5/390ZcMgfwF6HZJ6KYbrAn
pMfAMLmWRh66v+iFCVZXBOLi0GW7ui1RCpk0ZdBUv9Ojeufnjqf1v9Oy3onEHDFs
xhNDtNita6gCNFL4Wt+uTi43ggNI7RUCSn54zSr3Fm6oPY6OQ338rYiLf4pg0cf3
rgbGeK/FBG96wZEj7YzVu39GXWFB+eC+gJa8S4arYYkMkBYoOgaDSZ1H++cSIlwQ
f+TNjD/2Z+VqCXPxlDm2wLHeqj33r06bb4kJKoXPqCIcoEoYeprTyNX8MS4BhCOi
ksOl7XrjaRhtT12ly4tzvpyx7dBZggebwQkvPPEy+6Ubx4j2fMoHtpP1xpinK0Of
jYm3msKTYvuejYAmqgM2zS/i6dzCYkilDpl5DQAu86ril8D3c/EylEaNUilnx9Bb
FY1tgE+cOP4d2GNsxTfoxDfcaEBA7Ve8WQEjUBtD5Y+keNcy0+sYBFSa226iwmvQ
krkdtqR2BsJODzZUkDKwyj2ExiVDtQLZUCg9pTC/dU81DigcIbQ=
=VPxy
-----END PGP SIGNATURE-----

--pezhon6uik27e2hh--
