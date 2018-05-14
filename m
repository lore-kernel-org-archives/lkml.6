Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752644AbeENIkz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 04:40:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34720 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752447AbeENIkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 04:40:53 -0400
Date: Mon, 14 May 2018 10:40:50 +0200
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
Message-ID: <20180514084050.ix5corfuvx33gsyn@flea>
References: <20180430114058.5061-1-jagan@amarulasolutions.com>
 <20180430114058.5061-10-jagan@amarulasolutions.com>
 <20180502113413.vv2r3ubfoh7gm3ms@flea>
 <CAMty3ZBheurXewQ8R53G_0gNLgv1jQkZbjAbaN30JQ6_ZVn7Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jyer2q7sajz2ea4p"
Content-Disposition: inline
In-Reply-To: <CAMty3ZBheurXewQ8R53G_0gNLgv1jQkZbjAbaN30JQ6_ZVn7Eg@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jyer2q7sajz2ea4p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 02:03:36PM +0530, Jagan Teki wrote:
> On Wed, May 2, 2018 at 5:04 PM, Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> > Hi,
> >
> > On Mon, Apr 30, 2018 at 05:10:46PM +0530, Jagan Teki wrote:
> >> +             hdmi_phy: hdmi-phy@1ef0000 {
> >> +                     compatible =3D "allwinner,sun50i-a64-hdmi-phy",
> >> +                                  "allwinner,sun8i-h3-hdmi-phy";
> >> +                     reg =3D <0x01ef0000 0x10000>;
> >> +                     clocks =3D <&ccu CLK_BUS_HDMI>, <&ccu CLK_HDMI_D=
DC>,
> >> +                              <&ccu CLK_PLL_VIDEO1>;
> >
> > You were discussing that the PLL0 could also be used to clock the PHY,
> > has that been figured out?
>=20
> This is what I understand from Fig: 3-3. Module Clock Diagram, both
> tcon0 and tcon1 are using HDMI. I'm thinking based on the tcon
> configuration we need use proper PLL or some logic to get common PLL
> don't know yet. Since this series adding tcon1 I've attached PLL1.

You're not describing the TCON node here though, but the HDMI one, and
the HDMI block is listed in both the PLL video 0 and 1.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--jyer2q7sajz2ea4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr5S5EACgkQ0rTAlCFN
r3TYgQ/+KAHn/sA0FQekmjFHCfuz97cMX7MGe8M8digLqQtx4rpOXT4+BF2YKBkm
1KwGxI93LcfUDrWn7a5uf80ucr/+ENS6fxDvCN4LEIJwe2yruQF4KArv2hScReH7
ApO6a6iUuNAZSVbRqSkvgBCcqEJQd8o5FAsMxQBfUGUxljTzMwgz3BJQpnlyNGuf
64VHEfMJLbqAoMOHOK+5Z+3dEqZtnNkF3tMy6LPLQ7ci6V+DMDaNQkJex6yYihQF
BbyXmmBScXd2/daWLF5neDFAe22RZNyY7VRZgQUIyPFWxXhANE8mZ/LtaKch8BXN
Dge8Ma/Gkvq4te+YzdvHCjasyqcAdRLxvqVSlHX3Z/oPEGSuSkfroCdlVg1wqpUe
U+pkAz1mGLLzx6CF8yy/Uk61d5wWrQ1CV6IQ4tLqcan8+IYS4c3T9rwKDtSabtJv
FyHyHd6BQYXwrPK/BL12ScBivFyMFmPLyu9BIg66emhG0A0iSM74G1qgWkIBZ1Zz
DcG2psCWjpT0tQzpBkZxOkEKDbTX3Lqj+Nx1IhAZ8Gy/7VY12TB4xpx+z6Gn9eJG
Trz89sPLDiYbL+3r6liO56LbwTs9UOXQkYvpyNE4KC82N5KDVbMQKWStGttwknMU
a/Yg6tVkcaKdRORO0C3yaUk4GTPltvYiusq5a/UMOHjJctOildk=
=rPJa
-----END PGP SIGNATURE-----

--jyer2q7sajz2ea4p--
