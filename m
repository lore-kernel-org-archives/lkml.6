Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966993AbeCAJ3s (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:29:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34765 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966781AbeCAJ3q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:29:46 -0500
Date: Thu, 1 Mar 2018 10:29:33 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 5/7] clk: sunxi-ng: add support for the Allwinner H6
 CCU
Message-ID: <20180301092933.eqibjnepoj3ecvo6@flea>
References: <20180223123555.64009-6-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s63sgyrl3h62372d"
Content-Disposition: inline
In-Reply-To: <20180223123555.64009-6-icenowy@aosc.io>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s63sgyrl3h62372d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2018 at 08:35:53PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC has a CCU which has been largely rearranged.
>=20
> Add support for it in the sunxi-ng CCU framework.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Acked-by: Rob Herring <robh@kernel.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--s63sgyrl3h62372d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqXx/wACgkQ0rTAlCFN
r3QliQ//fe49xJfjzFjOrXyAoTIVrDoHzFPPRbLwC1kMiDypGE/WGyU/ofTX8u3o
1EjXj2TQorYDHwl/+8QGHOnfnDWg5gUmJOeVCvdS8fhcjReTC8Ofrwnti3SHERjK
K5YjBYIxByAvZOfAc6ohAKVP2RxuOR1owAEYRIi0/7SvRwH+4LRmCTB9PGiJsqSn
lenCiR6ZYcP1Ny08VVi620EiLV9aNY8pQBRh1oL/EFudT4Gg3it3L7DIWgYs2on7
Dpt+UdPxH+ZCpqnlYUGzL/Thw/Kd9F32ZpqWDywzu88g/HPcAXwoTYtYWpOpE3Cu
mUyf7aSxJ+wkZRcmTlJtbMp94fSDS2ZtZQqF7E1i2YqGtmxrS7pdSQDEcKE6YqKz
ITZSveu9SmIFkd1NEfpRDDw/ouuzS+IjcR0Unn6TQ9o7knLTMK8nJDDk7dsLpb95
oRgLBBMwYsalT0XC0m0PtKvqaALRGWEaV6ncOilNKZvgZLb2Wd5o8yQnqLXw7LpP
BEaI017FQa96DDCXooLP4l1FKsD/s38PvqFQrUGD/OynBvcnehV2tLMHJ0ABvXVT
+aO0poJG6+H4xk4J/m427F9OVTIUcqQJAU8NqPQ/YVp1j0UiLC+aycWXrS1ztBVS
1nrR3rqp1un4XBs0cbUQBPAuTHSQf7Xr4HVexA47zklbEGwGrss=
=t6pH
-----END PGP SIGNATURE-----

--s63sgyrl3h62372d--
