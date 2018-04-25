Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753015AbeDYMj3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 08:39:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33253 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbeDYMj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 08:39:27 -0400
Date: Wed, 25 Apr 2018 14:39:15 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 2/7] ARM: dts: sun8i: h3: Split out common board design
 for ALL-H3-CC
Message-ID: <20180425123915.twp3m73o5xap3m6j@flea>
References: <20180424113424.13196-1-wens@csie.org>
 <20180424113424.13196-3-wens@csie.org>
 <20180424121353.zxujyehsw3er2xq6@flea>
 <CAGb2v65iwbmOvQ2YA0e4QyTzQVj=F+5n6cWt2q6K80Y2b_3q3g@mail.gmail.com>
 <20180424193754.jsuucbq57onhxhqe@flea>
 <CAGb2v64MwS+q87z9_UiKxVtgeAenA_9+QSS=cfF42PGy4PeJwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="shhnyvlfu32no7sr"
Content-Disposition: inline
In-Reply-To: <CAGb2v64MwS+q87z9_UiKxVtgeAenA_9+QSS=cfF42PGy4PeJwQ@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--shhnyvlfu32no7sr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 11:19:20AM +0800, Chen-Yu Tsai wrote:
> On Wed, Apr 25, 2018 at 3:37 AM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Tue, Apr 24, 2018 at 08:17:11PM +0800, Chen-Yu Tsai wrote:
> >> On Tue, Apr 24, 2018 at 8:13 PM, Maxime Ripard
> >> <maxime.ripard@bootlin.com> wrote:
> >> > On Tue, Apr 24, 2018 at 07:34:19PM +0800, Chen-Yu Tsai wrote:
> >> >> The Libre Computer Project ALL-H3-CC has three models, all using the
> >> >> same board design, but with different pin compatible SoCs and amoun=
t of
> >> >> DRAM.
> >> >>
> >> >> Currently only the H3 1GB DRAM variant is supported. To support the=
 two
> >> >> other variants, first split the original device tree into a common =
board
> >> >> design part and an SoC specific part.
> >> >>
> >> >> The SoC part only defines which SoC is used and model name, and inc=
ludes
> >> >> the SoC specific dtsi file and the common design dtsi file.
> >> >>
> >> >> Also fix up the SPDX identifier line to use the correct comment sty=
le,
> >> >> and place it on the first line.
> >> >>
> >> >> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >> >> ---
> >> >>  .../boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 213 +-------------=
----
> >> >>  ....dts =3D> sunxi-hx-libretech-all-h3-cc.dtsi} |  11 +-
> >> >
> >> > I think I prefer the name of Neil's DTSI better, and since pretty mu=
ch
> >> > the same patches (a couple of hours) before, we'll merge them (while
> >> > merging the rest of your patches, obviously).
> >> >
> >> > Does that work for you?
> >>
> >> I would like for the regulator voltage fix to be merged before the spl=
it.
> >> This will make it trivial to back port, instead of having to reverse t=
he
> >> split, and maybe failing.
> >
> > Yes, I was just talking about replacing your two redundant patches,
> > but keeping the order you have.
>=20
> That works for me. Might require a little fixing up.
> Let me know if you need help with that.

I did. You can double check if you want :)

maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--shhnyvlfu32no7sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrgdvIACgkQ0rTAlCFN
r3QNmg/+Nc8al3vygIu1hcUz9Oj5kIvz5x5IY3/FOaT8pWebw5+w6BrA2OOEhYBV
xpFzJYYsjyvv0nerzXHSU2NLy9LGTCLUSwNfH5p9BUBf+MCOerpvzXkosTnNVhw7
G5sFrJ//53a+qL/0E+98Ofg1bZ9CwVFyHWDY9gA4RRtUnFpAuK8WeDyew498WbvV
ulrjE7yHkcvWBQIiSIqySY9I0zO2shya9i/HREsz2fEEIyBpu+fv1qDtUrXoK2sN
dlVC2ehIH8pPhX2iJgmMnpnbU7/pXDB7u2HgqTSnZtT7TFyA+ACBr3cyOWfXSbmD
3PGrd5ranvowg4QKWSqCNOTaXKPjlHVHDyoL91B/faqUBKZz8BhDLt4Ar7rP+TR1
eHW01uEffMPh+hO7Oq1tT5uIOo34+MlKQVLBo1hPojfglA9F5H/tS4hEXXYY8fum
twCBpbq712qUSDLYW+GFQD3hQi/ArbzVSAu0ZSNpOqydN519kcd9qew9lLURolcR
/pVWh3wsEeODgeohyuu534E1m1g/AsD66lCO6o6WKT0L1+6QoFHtVokgEKN6+gGX
3NYmNsDP5ggSCcW8XZkUwfoQBwqvuwmv33e2jRmQiSqy4w4J0eYKZ7y7A2SsMr+G
DJAmXGQ7ToMlOlIAc/7rPtTR4k7BmnickwEzp7lAJbPBY2jwpPs=
=1G4v
-----END PGP SIGNATURE-----

--shhnyvlfu32no7sr--
