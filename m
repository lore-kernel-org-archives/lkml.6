Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeCMIXk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:23:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36724 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751977AbeCMIXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:23:39 -0400
Date: Tue, 13 Mar 2018 09:23:37 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Code Kipper <codekipper@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Subject: Re: [PATCH v2 4/6] ASoC: sun4i-i2s: Add multi-lane functionality
Message-ID: <20180313082337.zekrzyx5utx5lkj6@flea>
References: <20180312155753.9478-1-codekipper@gmail.com>
 <20180312155753.9478-5-codekipper@gmail.com>
 <20180313080026.jtag4w46koxzeqe2@flea>
 <CAEKpxBkE_Aipa3Z6r0HnVNuU-kmfr1zandotZzQ9Z0AkShR=rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4nv7gcidubzhyoxj"
Content-Disposition: inline
In-Reply-To: <CAEKpxBkE_Aipa3Z6r0HnVNuU-kmfr1zandotZzQ9Z0AkShR=rw@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4nv7gcidubzhyoxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2018 at 09:15:49AM +0100, Code Kipper wrote:
> On 13 March 2018 at 09:00, Maxime Ripard <maxime.ripard@bootlin.com> wrot=
e:
> > On Mon, Mar 12, 2018 at 04:57:51PM +0100, codekipper@gmail.com wrote:
> >> From: Marcus Cooper <codekipper@gmail.com>
> >>
> >> The i2s block supports multi-lane i2s output however this functionality
> >> is only possible in earlier SoCs where the pins are exposed and for
> >> the i2s block used for HDMI audio on the later SoCs.
> >>
> >> To enable this functionality, an optional property has been added to
> >> the bindings.
> >>
> >> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> >> ---
> >>  .../devicetree/bindings/sound/sun4i-i2s.txt        |  3 ++
> >>  sound/soc/sunxi/sun4i-i2s.c                        | 48 +++++++++++++=
++++-----
> >>  2 files changed, 41 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/D=
ocumentation/devicetree/bindings/sound/sun4i-i2s.txt
> >> index 48addef65b8f..3f966ac61b9e 100644
> >> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> >> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> >> @@ -33,6 +33,9 @@ Optional properties:
> >>                               configured to extend the slot width to t=
he
> >>                               value specified. Min 8, Max 32.
> >>
> >> +- allwinner,playback-channels:  if this property is present then the =
number
> >> +                             of available channels is extended and the
> >> +                             outputs enabled.
> >
> > Isn't it something that is fixed for each generation of SoCs? Can't we
> > attach it to the compatible?
>=20
> I'm not sure as the documentation is pretty poor. It looks like it is
> supported by all of the variations that we've seen but only exposed as
> pins on A10 and A20. I'm also not sure who would ever use it with
> external devices.

Well, you were saying that it was the case on the older SoCs in your
commit log, so this needs to be figured out.

> The reason why I've added it is that it is required by HDMI for
> supporting surround sound on the newer SoCs.

Why isn't that mentionned in your commit log?

Can you post the whole set of changes needed for HDMI audio? this
would make things much easier to see where you're going.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--4nv7gcidubzhyoxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqniogACgkQ0rTAlCFN
r3RAxQ/8CoPs/TVNfsl+Je+WRDpNM03fEf6niOFSSsQ20HHJWkMcHy4txWzgLq9+
077+bQE26K2R0kEGtd1UPBNwIgRGwQE1nqBkmnsyfvnU4slsMHbypxHYjqj41TJG
HGaNnzLEjwthPTKEg0PfiwQzZYNdaFv/8PgHYiUjr2xyvO5uYMXhKsv+8DubwBgF
NoBXFqZ+dbutNPLmmY9yVastnKxB631WB3QMWTY/z6M+XTtEP6zMWRudQMGN1S9r
9Et5kPGM48HcJ9qyi6LZyfZ1JwEXJiyksb3tcgIQHOAE/oeMw3IoBh9FIQYx5+zu
VALdP9qv4xknD8nLxaAoyz6FdU0vPfN6e/aoiXmmVEvTz5sR7CdlfbPatzswalUI
9A07Kt1L0GJGfJAPQO0FO6R2FOORKuTS4beCjUBdugYRheiF6Okt7TNuDvTOktO1
Uy8oDLbuIJo0etQm3ANJ8DPozchp3M18JQu/PZ7DU6plAeOujCtAfQUVeCOw3Cgt
/Z8R/r9OQHWXDQiWNfPcO6XRfRYM/OJGXnTu3RgH/sQb3dXmF+pjgZYqVL97Jbw6
YGWVLGabodqAH4GdvA8QDlMVaYrFidOP1XkYMW3yf1LXmCCldr7Lif0Sz5ZMbmEJ
psuys+U629tcER7OLIPlIR+9ZHlygfrBHznkGWgKQePcXndvAN0=
=9gSg
-----END PGP SIGNATURE-----

--4nv7gcidubzhyoxj--
