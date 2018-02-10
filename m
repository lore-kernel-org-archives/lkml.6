Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbeBJIyT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 03:54:19 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37345 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeBJIyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 03:54:17 -0500
X-Google-Smtp-Source: AH8x227lW9YzWvM4MVe2CFant5gQ0CWz5okGBjQ/JjxM1ztha7WbXzUgX7pGvu6XVNTfwlNmhIrP5A==
Date: Sat, 10 Feb 2018 09:54:06 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 7/7] watchdog: coh901327: make use of timeout-secs
 provided in devicetree
Message-ID: <20180210085406.GA744@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
 <20180209192724.1227-8-marcus.folkesson@gmail.com>
 <20180209225200.GI19627@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20180209225200.GI19627@roeck-us.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 09, 2018 at 02:52:00PM -0800, Guenter Roeck wrote:
> On Fri, Feb 09, 2018 at 08:27:24PM +0100, Marcus Folkesson wrote:
> > watchdog_init_timeout() will allways pick timeout_param since it
> > defaults to a valid timeout.
> >=20
> > Following best practice described in
> > Documentation/watchdog/watchdog-kernel-api.txt to make use of
> > the parameter logic.
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  drivers/watchdog/coh901327_wdt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/watchdog/coh901327_wdt.c b/drivers/watchdog/coh901=
327_wdt.c
> > index 4410337f4f7f..437f865e5c6b 100644
> > --- a/drivers/watchdog/coh901327_wdt.c
> > +++ b/drivers/watchdog/coh901327_wdt.c
> > @@ -67,7 +67,7 @@
> >  #define U300_WDOG_IFR_WILL_BARK_IRQ_FORCE_ENABLE			0x0001U
> > =20
> >  /* Default timeout in seconds =3D 1 minute */
> > -static unsigned int margin =3D 60;
> > +static unsigned int margin;
> >  static int irq;
> >  static void __iomem *virtbase;
> >  static struct device *parent;
>=20
> I would suggest to initialize .timeout in 'static struct watchdog_device
> coh901327_wdt', and drop the error check when calling watchdog_init_timeo=
ut().

Will do, thank you.

>=20
> Guenter


Best regards
Marcus Folkesson

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlp+sykACgkQiIBOb1ld
UjJ+FBAA21rpPiBqvFc1Z82UBlfZjBSHVKaLyn1u3pX/Bbkk5Nkfmll+33Y0Yvwb
AarNoMnan6d2pLBzcS6OtDw1iENGrob63f+uZ6XpTsHXZGkNOirpTJJPI6gnYQw6
qxeOCaegsLN34aKw7tyICEboIxFqjAwBcSsKdBY100K7mkOfI8mggJKttgfl0FIO
lxwv0dzdklyxN5SnFJxefshzIwycqqPseJ7YoeFJX62EWadXZZ0PTbuMXc7d39bM
ji/uU9Y+tAlZOHQ0+aMU9x3WlGjQWkYbMBy5M0hXeEZwhR6sK3CxgpS6MPaoj7Bh
RGjj1/TAs/VHHGwoXUa8u0jV5ZobXwWbfHT5ScB9bwTodBFUTKyTBZ0SdI1wakMd
EvAIlgHp0LwzDKqYhEKGhTIbCfSy2/1GOrA264b2ABit7C6sN/OVN80rdECUKRA/
3qCCLj9N7RqfW0QwHaaMpMhB+kzEm5pY6eGHy+LgO+sTSvroSKvUZ0/8y9LXHuoL
kqb7Vt1MgBjlX1u2oN+/svvgR2jBsf2s/8yZ1IuwhwaO59qFyPxgd31VBEiEUUUN
CdXxYF2Zs2FlqyX7WtedKt0JAv8ELV1dSurTS+4QkeLkUkefUFJyydMFXTWH44KV
2hV+Q6WcaK43LElvAYkHbwgoX5C2E8J3WGR5aV/X59SMWMFsWNw=
=McuB
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
