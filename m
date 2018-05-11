Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753007AbeEKICJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:02:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60338 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752987AbeEKICF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:02:05 -0400
Date: Fri, 11 May 2018 10:01:54 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com, Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH v4 3/3] ARM: dts: sun8i: h3: Add SY8106A regulator to
 Orange Pi PC
Message-ID: <20180511080154.iubx6jidtxdojgfx@flea>
References: <20180507122942.25758-1-icenowy@aosc.io>
 <20180507122942.25758-4-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zsrhuep42maihh3q"
Content-Disposition: inline
In-Reply-To: <20180507122942.25758-4-icenowy@aosc.io>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zsrhuep42maihh3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 08:29:42PM +0800, Icenowy Zheng wrote:
> From: Ondrej Jirman <megous@megous.com>
>=20
> Add SY8106A regulator to r_i2c bus and enable the r_i2c bus on
> Orange Pi PC, then set the power supply of the ARM cores to this
> regulator, in order to enable DVFS.
>=20
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> [Icenowy: Enable DVFS in this patch, slight changes and change commit
>  message]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> [wens@csie.org: Rename regulator label]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Dropped Chen-Yu's SoB and applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--zsrhuep42maihh3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr1TfEACgkQ0rTAlCFN
r3Q1bQ/9G/ptCzHeIERuiYBLpmX4mzSBKUCKBJoq9OpI5LPFeBJDFNFEjNHjDqbX
PTFDqpNVDF6TnFVdnFrmctdii62IOZ457D7wdISx7LwfrPEQteZLuPahmSOEJE5V
6n2Qoc4y5IA3STVpX5ovdowUk1Nihh99Cit0neH+1GHKghQ72UuNewfcPjbaiZpS
OYlMVBVzmGMSFizKyLdj7FWXHi7HNQY5Kx8NAZJUSvO1nrW9gq0Fzzs5DOWqrwce
LVPnU9eAM689TTMCSPaNGrNsmH9dW00UrRUe2sTjxTSLvm9zQFltlS3cj8FaJ3bz
j7FZZTdgChIyAsaq2rL1z1aBo5O3c6+q39cLR5vHJmvaTcslJ0LM0fEVCTIazzIF
fuVysrkjbbkpyqI+Z8X1/cijOLwTKxOnBjnUWt+0RfvDKIgNyYwxmhYl+zg2DXa4
qGRDgyKEETfEp6S0gqKFCRaihRiQOb7fXzSgltf8lFMOzIHrkVWG1amg+koVF6xD
EkGp6WdjDdlIX/DEw8yDc5haiuljy6tOW1oa0yyZcmX/yyNGow/lL/lkZEVVLLAo
k9vT1Z3deH6vz7dkLqp1IZrSTCbdKo8MKMHtErnSLXSOMPS079Nca/WiW4yXjMdK
LvMRbbIb/jiM9G2/5bjh0SmRogtSNwf970TsqiNc+e94WRltoZ0=
=WWAI
-----END PGP SIGNATURE-----

--zsrhuep42maihh3q--
