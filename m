Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeEOLTw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 07:19:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58137 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752323AbeEOLTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 07:19:50 -0400
Date: Tue, 15 May 2018 13:19:38 +0200
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
Subject: Re: [PATCH 09/21] arm64: dts: allwinner: a64: Add HDMI support
Message-ID: <20180515111938.ia6jttqijj2erxy4@flea>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-10-jagan@amarulasolutions.com>
 <20180502113413.vv2r3ubfoh7gm3ms@flea>
 <CAMty3ZBheurXewQ8R53G_0gNLgv1jQkZbjAbaN30JQ6_ZVn7Eg@mail.gmail.com>
 <20180514084050.ix5corfuvx33gsyn@flea>
 <CAMty3ZDCubM2sLBfNVar-kA9djZ8PJDQJOS0Jwi6wWNVeK9mCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v7lac66a75aajndc"
Content-Disposition: inline
In-Reply-To: <CAMty3ZDCubM2sLBfNVar-kA9djZ8PJDQJOS0Jwi6wWNVeK9mCg@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v7lac66a75aajndc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 04:01:15PM +0530, Jagan Teki wrote:
> On Mon, May 14, 2018 at 2:10 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Mon, May 14, 2018 at 02:03:36PM +0530, Jagan Teki wrote:
> >> On Wed, May 2, 2018 at 5:04 PM, Maxime Ripard <maxime.ripard@bootlin.c=
om> wrote:
> >> > Hi,
> >> >
> >> > On Mon, Apr 30, 2018 at 05:10:46PM +0530, Jagan Teki wrote:
> >> >> +             hdmi_phy: hdmi-phy@1ef0000 {
> >> >> +                     compatible =3D "allwinner,sun50i-a64-hdmi-phy=
",
> >> >> +                                  "allwinner,sun8i-h3-hdmi-phy";
> >> >> +                     reg =3D <0x01ef0000 0x10000>;
> >> >> +                     clocks =3D <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDM=
I_DDC>,
> >> >> +                              <&ccu CLK_PLL_VIDEO1>;
> >> >
> >> > You were discussing that the PLL0 could also be used to clock the PH=
Y,
> >> > has that been figured out?
> >>
> >> This is what I understand from Fig: 3-3. Module Clock Diagram, both
> >> tcon0 and tcon1 are using HDMI. I'm thinking based on the tcon
> >> configuration we need use proper PLL or some logic to get common PLL
> >> don't know yet. Since this series adding tcon1 I've attached PLL1.
> >
> > You're not describing the TCON node here though, but the HDMI one, and
> > the HDMI block is listed in both the PLL video 0 and 1.
>=20
> So how can we attach particular PLL with particular HDMI(PLL0 to HDMI0
> and so-on) or do we need to attached both the PLL's any suggestion?

I'm not sure what your question is here, just add the possibility to
have an extra PLL if that makes sense to the binding.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--v7lac66a75aajndc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr6wkkACgkQ0rTAlCFN
r3Tqag//dbQV1Oc4D43SXUZCymqniRo2QM1sWnt+4qbax7rh2BKJcBnV/Ue0qn07
OqfqRQ1OygMr92fmd8F9VbWqWvp5ehgi28/SWnGjoJvwwzuapeE5BhZKN/BLCMM6
JCFLNivGVeyo3EgSc7p0rzx8gFRrV9OOXfk1RBnWCDM24ep7o/SamrzVYEvZONHS
5ryhl5xMNo48qt62codvMpsSW5Yoymsq45rQRHVqfs08TaVKXbcGOgUSdMlZPpou
ZT0irqRYa2H1Dl6L/p5K0SG2xZhwrd3dHgpeNquI/hRC5CHKKVeYRCiDQ8OfP5c1
cYAk1dMVixaoKGFac/fqW7Tw9n7p1ARDeW047eyPhM05105ovUwIXiDA8sTpIkzS
WYuvrKI1x1rvc8krGTcT8BW9RRes9X0YAoymyjpAFdKAqWiLGdr04sBA2Jx4bTOh
bGH3Tao4Ze7/HyDUdw1VWAgwzw0NJei8wlKrIg68BKlPAGEu1kCNDk7LfVHq1J1V
aaw7WFtTNxQdEedWQVEotOeS+AasRYWva7e3zjxU3MT7taJPsifSiEMZlvRtspRP
CYR06sUect1a7gYb3DnvZusXtSkOaoqxwsdTIUQU0IBvW15mrGpH5vN4DgEbohgY
JPZtUCvBmHLYBk0FgPgtqQhxfVBb+3qnuFQDWNMqC72gMsbakgY=
=qgzn
-----END PGP SIGNATURE-----

--v7lac66a75aajndc--
