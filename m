Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753925AbeDSQsE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 12:48:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32822 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753573AbeDSQsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 12:48:03 -0400
Date: Thu, 19 Apr 2018 17:48:01 +0100
From: Mark Brown <broonie@kernel.org>
To: ryang <decatf@gmail.com>, lee.jones@linaro.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: tps6586x: Add support for TPS658624
Message-ID: <20180419164801.GI27188@sirena.org.uk>
References: <20180419161850.GA9144@computer>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZOudaV4lSIjFTlHv"
Content-Disposition: inline
In-Reply-To: <20180419161850.GA9144@computer>
X-Cookie: We've upped our standards, so up yours!
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZOudaV4lSIjFTlHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 19, 2018 at 12:18:50PM -0400, ryang wrote:
> This version is exists in the Samsung Galaxy Tab 10.1 which is based on t=
he
> Nvidia Tegra 2 board. The TPS658624 has the same SM2 voltage table as
> TPS658623.

> Signed-off-by: ryang <decatf@gmail.com>
> ---
>  drivers/regulator/tps6586x-regulator.c | 1 +
>  include/linux/mfd/tps6586x.h           | 1 +
>  2 files changed, 2 insertions(+)

This also touches the MFD header for the part so should've been sent to
Lee, the MFD maintainer (CCed here, left the entire patch for context). =20

> diff --git a/drivers/regulator/tps6586x-regulator.c b/drivers/regulator/t=
ps6586x-regulator.c
> index 9e9d220..ba3dae7 100644
> --- a/drivers/regulator/tps6586x-regulator.c
> +++ b/drivers/regulator/tps6586x-regulator.c
> @@ -342,6 +342,7 @@ static struct tps6586x_regulator *find_regulator_info=
(int id, int version)
> =20
>  	switch (version) {
>  	case TPS658623:
> +	case TPS658624:
>  		table =3D tps658623_regulator;
>  		num =3D ARRAY_SIZE(tps658623_regulator);
>  		break;
> diff --git a/include/linux/mfd/tps6586x.h b/include/linux/mfd/tps6586x.h
> index 2fe68e4..b19c280 100644
> --- a/include/linux/mfd/tps6586x.h
> +++ b/include/linux/mfd/tps6586x.h
> @@ -18,6 +18,7 @@
>  #define TPS658621A	0x15
>  #define TPS658621CD	0x2c
>  #define TPS658623	0x1b
> +#define TPS658624	0x0a
>  #define TPS658640	0x01
>  #define TPS658640v2	0x02
>  #define TPS658643	0x03
> --=20
> 2.7.4
>=20

--ZOudaV4lSIjFTlHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrYyEAACgkQJNaLcl1U
h9Djpgf4pnwbYW0lvJoCGszzkQIxBhD7spIoQoNkaZYE+958JtwJzxUyWgJl3i3k
ie1KRrGgQnI3f9+2ftQqDDgd2UiDqLQiscAdqbje1HrmpoBbtXsBBsMGGGY6pdnZ
GRBQclOm5cwOYmIhpJuoyWKBR/qb+XxvB8YOaXwnN4DY4sml6TQNJs3SfRTk+WBQ
3H84f3ZdVj/TZgo8+3AvTGEKfH87nZS0JaqZtalQWu3RuQ8SdHDY0SDENp2SK22i
R6IfF5nmfO/N+4PAL8YrLVzNJynod7AASJASB5TMuYRrmXKLJu8QpxI3T4h1Tl3v
K2LBU83VjYrnTaqZnY2vVZbny4fu
=5XNb
-----END PGP SIGNATURE-----

--ZOudaV4lSIjFTlHv--
