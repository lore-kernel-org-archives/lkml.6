Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755569AbeDWPDO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:03:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41813 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755419AbeDWPDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:03:11 -0400
Date: Mon, 23 Apr 2018 17:03:09 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: sun8i: h3: Add SY8106A regulator to
 Orange Pi PC
Message-ID: <20180423150309.dksr2rjazlrmlzx2@flea>
References: <20180423144657.63264-1-icenowy@aosc.io>
 <20180423144657.63264-4-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5n6aegyizyrw7jdc"
Content-Disposition: inline
In-Reply-To: <20180423144657.63264-4-icenowy@aosc.io>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5n6aegyizyrw7jdc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 10:46:57PM +0800, Icenowy Zheng wrote:
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

Why is there Chen-Yu's SoB? It doesn't really make much sense, unless
Chen-Yu would have applied this patch already, but then you wouldn't
post it, right?

Maxime=20

> ---

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--5n6aegyizyrw7jdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrd9awACgkQ0rTAlCFN
r3TInhAAmrq22gc94H5suq9QPZDD4krf9irMnM/zICuvFA0LcjrmKdJzwonl7Nj/
xH5VI1SEQ7keFGX8bdGqYQDQmqffvf8E/2jeqDYbOEuOuye8rKjexZLckhCZTnHJ
W0knOdO7dUn465HXffHjOsaZLGb9fl6hZgOm+O+ZZDkNrhtMhbTVM6Q7UCcccZal
00sT9M8q2k0+ZsmgSrjEY2y0Kc2MNuUPrmLxBZKEYA9obTsroOEYGwi+Q+H9+/uD
iXVtV8w0l24EpToIDOrbeHg5RJ5mrC67HLBhrhkwO/CaIJATz2st3l3cKHTJd+Ak
M2zmGAqK4YPXCMupP1k2gH6It0FNmaWR5PUrr3yreFVtEhlQMPfyqc0B6xQ4SP8C
h9IrdoQt2DZOwRRx4LdmZNdxCEw0nez9kYw8YmT0RVPpfdRLVM5dIyqhG+6L5uO/
a3/uu9xdDklSfdxIqxVhT7oaqXt1wovYfoCtALCJHT8keqEt2SZpjVWyNNF4m6yP
mdGlzlLr640Y44F3GyE2grEa+IjqYy4BUKVNnpHk587HZ+EIrLnf+GnR3U/VXjW6
bEx6a6tQUcIazvurhpqtftq0/SezSKXh+RfEd1yogYSvW/UpkYsuaKkDtHO+gY/p
KDKxJdm8yJiTRk5tYsd2uORTlpB7/aKIrwhwsFz02WZN3Y4SyLA=
=rQeH
-----END PGP SIGNATURE-----

--5n6aegyizyrw7jdc--
