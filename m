Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752066AbeFEN0C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:26:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46469 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751822AbeFEN0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:26:00 -0400
Date: Tue, 5 Jun 2018 15:25:39 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 00/26] arm64: allwinner: Add A64 DE2
 HDMI support
Message-ID: <20180605132539.m54xwfzfs6btrmtc@flea>
References: <20180518094536.17201-1-jagan@amarulasolutions.com>
 <20180518095913.nzl3sr5wn6cg4ra5@flea>
 <CAMty3ZC13J+bCWK_=9816Lu-5ctC0UfF4-XR3yNSpHdH8q8Faw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b6opfkfolfd5hoil"
Content-Disposition: inline
In-Reply-To: <CAMty3ZC13J+bCWK_=9816Lu-5ctC0UfF4-XR3yNSpHdH8q8Faw@mail.gmail.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b6opfkfolfd5hoil
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 06:23:57PM +0530, Jagan Teki wrote:
> On Fri, May 18, 2018 at 3:29 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Fri, May 18, 2018 at 03:15:10PM +0530, Jagan Teki wrote:
> >> Allwinner A64 has display engine pipeline like other Allwinner SOC's A=
83T/H3/H5.
> >>
> >> A64 behaviour similar to Allwinner A83T where
> >> Mixer0 =3D> TCON0 =3D> LVDS/RGB/MIPI-DSI
> >> Mixer1 =3D> TCON1 =3D> HDMI
> >> as per Display System Block DiagramAllwinner_A64_User_Manual_V1.1.pdf
> >>
> >> This is second patch-set followed with previous RFC[1] and first serie=
s[2]
> >> and merely concentrated on HDMI pipeline through TCON1 and rest will a=
dd eventually.
> >>
> >> This series fixed previous version comments
> >> - about documenting fallback compatibles
> >> - adding new compatible for mixer1
> >> - support for multiple DW HDMI PHY clock parents (thanks, to Jernej)
> >>
> >> Note:
> >> Pine64 boards are unable to get edid by default like other A64 boards,
> >> but forcing 'video=3DHDMI-A-1:1920x1080@60D' kernel command line can
> >> create edid with display on penel.
> >
> > There's no point in trying to push this without the SRAM issue being
> > solved. It is required, and won't be merged unless this is addressed.
>=20
> is SRAM issue resolved? if so may be I will try to test it on top.

I'd expect the one working on this to push a solution to solve this.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--b6opfkfolfd5hoil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsWj1IACgkQ0rTAlCFN
r3SpSw/9GO1lW52OjlTpVPnGy+0vHIBUtqdF92P9tuQYHXeDDnhyqfXKRkFYj7iJ
Dy+XDFFENnqUVM2GcqqHJmCbZUVjucrBWbLpyQvzQ78a3K3/8RSPeoYr0wgORJ89
K3yynQW3AvUQCmADh1+DIlpi8eIsQ97yT9TBBc1cNamlE3QA44iqlqaXUI0d7JpY
ZVC9jbqb+k3whtsYVFpbwIH0a+XYzSDcNX4sjixnQdASHb0kMO1CW2QWs5XQTEbR
21W4fNXKZGK5zW1gMK+H2SbcwDz7zm7pLWM1JjkqnJDRqj8bJKJYJPtjhLnJDXlJ
zfwsb0fKiGOLVqNmWgyfiY3QkOtyllEz/O1xG1lTI3X6YCTPsiHPtbch3X0jkyI9
QNflDc8YXJ4CAt7z94HYTL3445UUXteZ8/5jGeMN8eV+/YHyiEGMZQdYBsPTA44S
4oxKfSqQNZuHnuMG8U+spnqwGo2QmGMwLWbTjEqml6t/5LZA1M0+jm4V9LDrX3un
PB6OIGhWItNrj5nZB19OGx8MfU2Ldx324Sam/dfS9JBtpRo5hZWXkAyMW7GzrECm
pFknUKRLRLBI5+/8wk4GL6QvXPUufkX5IfEaGCzUvlITUc7nnZ0XpkpiOIkL7cP/
RfoTSZI9obSdUSv2eIDm5xs9ld2TKmaZa4vrwlBKGcKj13LaGAA=
=Obu0
-----END PGP SIGNATURE-----

--b6opfkfolfd5hoil--
