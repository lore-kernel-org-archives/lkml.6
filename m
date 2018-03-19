Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030878AbeCSVNk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:13:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49770 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965510AbeCSVNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:13:35 -0400
Date: Mon, 19 Mar 2018 22:13:22 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Airlie <airlied@linux.ie>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] ARM: sun9i: a80: Add display support
Message-ID: <20180319211322.gnbc4mgk4nn2uskg@flea>
References: <20180315114136.24747-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wdy4vv7sq55rfep4"
Content-Disposition: inline
In-Reply-To: <20180315114136.24747-1-wens@csie.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wdy4vv7sq55rfep4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 15, 2018 at 07:41:28PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
>=20
> This series adds basic support for the display pipelines found on the
> Allwinner A80 SoC. Currently only parallel RGB output via TCON0 is
> supported. TCON1 drives the HDMI encoder, which I've not been able to
> get working yet.
>=20
> Patch 1 adds device tree bindings for the TCONs on the A80. In
> particular, TCON0 requires the eDP reset control in addition to its own.
>=20
> Patch 2 adds a device tree binding for the Detail Enhancement Unit found
> only on the A80.
>=20
> Patch 3 adds driver support for the TCONs.
>=20
> Patch 4 adds compatible strings to the device tree bindings for all the=
=20
> remaining peripherals covered by this series.
>=20
> Patch 5 adds support for the compatible strings from the previous patch
> to the sun4i-drm driver.
>=20
> Patch 6 adds the display pipeline device nodes to the A80 .dtsi file.
>=20
> Patch 7 adds a pinmux setting for RGB888 output for TCON0.
>=20
> Patch 8 enables VGA output on the Cubieboard4 via an external DAC and
> an I2C bus from the SoC for DDC.
>=20
>=20
> I've had these patches for quite some time now, rebasing them as more
> features were added to sun4i-drm. Please have a look.

Applied all, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--wdy4vv7sq55rfep4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqwJ/EACgkQ0rTAlCFN
r3QqZRAAgQjnhfi/zcsXVxH8QFKdBjJYRZKBwrNP5S9H3qvW9pSKv1U6rzz1WlEi
kfXv7gRZHzlZrBYw/uWPfxvplKwPee9rWMGJi8r7xhonZ10LJ2vAtcuCSjp1OuTk
cnt+RkCGRrlMb+x7WHKm4Gd4cF02HdNQZF+xjVVDNrLu8NH69Yw/wZyXWnGmBXKC
1TtrTFSjKQZzV1XnU2ZZCyL7ex4GmNkHJ0iaHPtsCE5XCBZ5+ORTi8yBU6/ZPXqk
Y1KepEBnqmGLMtaBktTr1axV7dAPZKm9nbFl3bmrsYEF2BKI4V7dmRQDLZotkqrZ
GY4+mUZhq0/j/LNUurAnbB2pjMuciN2dt6YLJZD/64du+BUZmRkhmhnh6fboB30p
aNYBVRCag5uL/2O06Qq8j/F5wnqUkeeSklxsHbJDxed703i/IfhQUqKT6I+PNlBD
j+0MCJjMHdgR4EJ905IkSfOOwWRIK7ph40tpbmQtKH9xo2x8dGc/oKBHi41lEfpH
YGrbVhfRUULezmUUGdhG3oC/9a9mwa6q+i4b07HW/1NFEjnGPLzY1FjvR+TWK7dy
QWoJUyp9eDLycm84oQAOezoq683CR4H/4hLQei9c/2Nma2t2a4bRjhzTBCusMTXD
4arS9Psh5kFdnx3vWTomGJeH6MXUa1zukJft4B/HaMdJtCr+gJ0=
=WteB
-----END PGP SIGNATURE-----

--wdy4vv7sq55rfep4--
