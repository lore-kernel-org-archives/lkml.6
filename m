Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeB0HHz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 02:07:55 -0500
Received: from mail.bootlin.com ([62.4.15.54]:43686 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751974AbeB0HHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 02:07:54 -0500
Date: Tue, 27 Feb 2018 08:07:35 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Julian Calaby <julian.calaby@gmail.com>
Cc: jernej.skrabec@siol.net, linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>
Subject: Re: [linux-sunxi] [PATCH 14/15] ARM: dts: sun8i: h3: Enable HDMI
 output on H3 boards
Message-ID: <20180227070735.ml3mc4nr4vpge57u@flea>
References: <20180224214545.3740-1-jernej.skrabec@siol.net>
 <2676311.2IEVhXnSIE@jernej-laptop>
 <4AA78C45-E139-417E-BE89-FE0BFBC409B0@aosc.io>
 <2342395.9m6rrqTry7@jernej-laptop>
 <CAGRGNgU8-uJuns7mAzS-gc81qvVAkS9JS2Tm13p2Qp7dMDCNkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hvvzilz5wqazdv4s"
Content-Disposition: inline
In-Reply-To: <CAGRGNgU8-uJuns7mAzS-gc81qvVAkS9JS2Tm13p2Qp7dMDCNkg@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hvvzilz5wqazdv4s
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2018 at 01:29:27PM +1100, Julian Calaby wrote:
> Hi Jernej,
>=20
> On Tue, Feb 27, 2018 at 3:27 AM, Jernej =C5=A0krabec <jernej.skrabec@siol=
=2Enet> wrote:
> > Hi,
> >
> > Dne ponedeljek, 26. februar 2018 ob 17:21:05 CET je Icenowy Zheng napis=
al(a):
> >> =E4=BA=8E 2018=E5=B9=B42=E6=9C=8827=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=
=8812:16:44, "Jernej =C5=A0krabec"
> > <jernej.skrabec@siol.net> =E5=86=99=E5=88=B0:
> >> >Hi Julian,
> >> >
> >> >Dne nedelja, 25. februar 2018 ob 09:11:34 CET je Julian Calaby
> >> >
> >> >napisal(a):
> >> >> Hi Jernej,
> >> >>
> >> >> On Sun, Feb 25, 2018 at 8:45 AM, Jernej Skrabec
> >> >
> >> ><jernej.skrabec@siol.net>
> >> >
> >> >wrote:
> >> >> > Enable HDMI output on all boards which have HDMI connector.
> >> >> >
> >> >> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >> >> > ---
> >> >> >
> >> >> >  arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    | 25
> >> >> >  ++++++++++++++++++++++ arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
> >> >> >
> >> >> >   | 25 ++++++++++++++++++++++
> >> >> >
> >> >> >  arch/arm/boot/dts/sun8i-h3-libretech-all-h3-cc.dts | 25
> >> >> >  ++++++++++++++++++++++ arch/arm/boot/dts/sun8i-h3-nanopi-m1.dts
> >> >> >
> >> >> >   | 25 ++++++++++++++++++++++
> >> >
> >> >arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
> >> >
> >> >> >         | 25 ++++++++++++++++++++++
> >> >> >
> >> >> >  arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts       | 25
> >> >> >  ++++++++++++++++++++++ arch/arm/boot/dts/sun8i-h3-orangepi-one.d=
ts
> >> >> >
> >> >> >   | 24 +++++++++++++++++++++
> >> >
> >> >arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> >> >
> >> >> >        | 25 ++++++++++++++++++++++ 8 files changed, 199
> >> >
> >> >insertions(+)
> >> >
> >> >> As I understand it, the H2+ is just a slightly trimmed down H3. In
> >> >> terms of HDMI support, the difference is that the H2+ can't output
> >> >
> >> >4k.
> >> >
> >> >> If this code is compatible with the H2+, could you please add the
> >> >> necessary bits and pieces to the h2-plus DTSs too?
> >> >
> >> >There are only 3 H2+ boards in kernel and none of them has HDMI
> >> >connector, so
> >>
> >> BPi M2 Zero has miniHDMI connector.
> >
> > Ah, sorry, I missed that one. Since I don't have it (or any other board=
 with
> > H2+) I'm not really comfortable including such patch. If anyone will te=
st it,
> > I can include it in next revision.
>=20
> I have one of those (this is why I'm interested in this patchset) so
> I'm willing to test, however I can't guarantee I'll get to it quickly.

Then I guess the best way forward will be to keep the current patch as
is, and you'll send a patch whenever you have the time to test it.

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--hvvzilz5wqazdv4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlqVA6gACgkQ0rTAlCFN
r3Q6vg/9Fm4ScE+f0ZUY+8HUDprDlD6ldpEISEpdTAjAJWM79FS1uGjliUeykw3r
+W2ILskyTqcyI4vWoV7IfGfdj5AdHYgu4Kl11jgk692Xsli8Tcmj1j1HSeFVGShq
Zi5uRUDRbWegypGTCqFKp7xpZaMpv+9h3cQ02hdqOzxieu/On9hWWK+2siI7L9Uo
Og0DPCvyNTnEMFvi+7UHHlKSHVmIrNdx5D8Ey2rk8hC2Y4R4cA4FPFRzGp4sYzor
GEtKGM/cbB1xFgtCNaUjs4I+pEi8ZGowc7UZ0mVdKHsH7IhkEj1kC+LJRP2r5mMf
nfLESFP/0ovvg6wTPrwZkLWGnYoEEIH1YgodzwO//2IOZHxrFh+ZL1bGrfQg9mUV
tqiOP5aRaWCMYZy9NN5MQZ8jajPmQrxBsrrEoB8/B5DDaWRb7vnbNjqhNUVgmTh6
2C/pHxFZbgMLSXR1Hkj0Ph50AZaQeqO381JsrI6SM5xXnGUrg4K4C7i/xtxyhdWU
XZXw/rm4kLSCbBHQvNicrILn0PZh0fAKvsmClmFmxv6bMeXPAlRimM+uQjzaR7o/
vCq253+Ne61sOPSRjgyJl2tqjEof2CIUTYwS8+U+57DYcgg678e2Qv8Br2cdYENX
kJVUbQ8vbEYm4VMGApRBsWAsakQwgnK0QVuCJ53nhNp4Nu5c5wM=
=8IBn
-----END PGP SIGNATURE-----

--hvvzilz5wqazdv4s--
