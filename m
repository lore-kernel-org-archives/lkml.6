Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbeEVO12 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:27:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60995 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751173AbeEVO1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:27:25 -0400
Date: Tue, 22 May 2018 16:27:23 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Emmanuel Vadot <manu@freebsd.org>
Cc: wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM64: dts: sun50i: h5: Add spi flash node for
 OrangePi PC2
Message-ID: <20180522142723.lm4ivndgwr6mzdpp@flea>
References: <20180521115426.92115-1-manu@freebsd.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bshvfimtksmbvbss"
Content-Disposition: inline
In-Reply-To: <20180521115426.92115-1-manu@freebsd.org>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bshvfimtksmbvbss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2018 at 01:54:26PM +0200, Emmanuel Vadot wrote:
> The OrangePi PC2 have an mx25l1606e spi flash.
> Add a node for it.
>=20
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>

Fixed the prefix and applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--bshvfimtksmbvbss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsEKMoACgkQ0rTAlCFN
r3RclA/+Kyil79U+LvX9vMgRFrGsBgJvsrdYzXNs5zp9a2dRIr3IopP0y15OeB7T
+sgM2N2ppEkKNVp2nGGTFXmyZeDiQ26BADPCYBwEfxqqkvCb+Sx5O4uT+dPKSrQ2
ZxOAUHYaFoPBRTPOx+k5BKe1nuUCyh8ZHFSJpkueMpUwFAL2291AHAjbhz13SnyA
3n3hmMK/p+0ryBb+xBkRQtcUFq+B58neoDxkY/rdEqNf8LPkQy3Kn1KzKwqOvUoD
7tykYKcJg+aTBfS9dx8GWioH0bS9Fy4P65PWd2j5lN3I0LT3enmwjlW43y2MZIH+
C9C3dwIt9glxTV8qqVRLhAC0f6U2mDWIgNTEMXeS+I4hZMjT7CAkCLmS7WLonMLU
E8PEylq5LctAHHU5HlMrCi/5xpW4lfCkZj8ZT/WQXrfJkr/gcyjdmntl6FPoZPxD
p3sjU8o4hkM9XG6YA/Leou0BsX2sMCLuRHnFI2rsNFCYVjlpDvyDjp6uQd0RXo3M
3ubJ4TnCXi0/JTQPFtndunBQlhe8RT1SzauflNuWzK39S90LjNKKkuHYr4GSEOdB
dv5ROQkHzn/oyeh9sagz+75oK43qlASM6hU4GDjcogjfC04m/savUbEz2Unp9fme
qKjZwWymf9UPr6SWdLkNRrZc468wtkRLl0hnOb5nsDpVKyetY2k=
=jK8G
-----END PGP SIGNATURE-----

--bshvfimtksmbvbss--
