Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932144AbeEWISh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:18:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57345 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932105AbeEWISb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:18:31 -0400
Date: Wed, 23 May 2018 10:18:30 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v3] arm64: allwinner: a64: Add Amarula A64-Relic initial
 support
Message-ID: <20180523081830.4ly6sj34reabbttn@flea>
References: <20180522132228.6564-1-jagan@amarulasolutions.com>
 <20180522143044.pgwawojiwnk2lzxb@flea>
 <CAMty3ZD3JT-ToGAUHN_uj7uVK-jkyAwfEdTBCmJSj34bACFpYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mamnyo2i4rxbn4ji"
Content-Disposition: inline
In-Reply-To: <CAMty3ZD3JT-ToGAUHN_uj7uVK-jkyAwfEdTBCmJSj34bACFpYQ@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mamnyo2i4rxbn4ji
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 23, 2018 at 11:44:56AM +0530, Jagan Teki wrote:
> On Tue, May 22, 2018 at 8:00 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Tue, May 22, 2018 at 06:52:28PM +0530, Jagan Teki wrote:
> >> Amarula A64-Relic is Allwinner A64 based IoT device, which support
> >> - Allwinner A64 Cortex-A53
> >> - Mali-400MP2 GPU
> >> - AXP803 PMIC
> >> - 1GB DDR3 RAM
> >> - 8GB eMMC
> >> - AP6330 Wifi/BLE
> >> - MIPI-DSI
> >> - CSI: OV5640 sensor
> >> - USB OTG
> >
> > You claim that this is doing OTG...
> >
> > [..]
> >
> >> +&usb_otg {
> >> +     dr_mode =3D "peripheral";
> >> +     status =3D "okay";
> >> +};
> >
> > ... and yet you're setting it as peripheral...
>=20
> Though it claims OTG, board doesn't have any USB ports to operate(not
> even Mini-AB) the only way to use the board as peripheral to transfer
> images from host.

I'm not sure what you mean here. If there's no USB connector, why do
you even enable it?

maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--mamnyo2i4rxbn4ji
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsFI9UACgkQ0rTAlCFN
r3TRxQ//YUtgozefeDLqseqYu7KoRTtEqw4a0UiNTFtIg8LV3VRuBlycSyGvL3wH
PS4Gv37Xy+P6ubDCb4wBMjuaOkB8Xt8Uu6yrWA2YXLsnOCCSI1VMSdp1uaCi83vu
WhjhzOsxquVd+xSw5LkSR1cE2sfDFzQ1e10akQfzivzSYjar2xGUPnc2jCHgoc08
xHSAkw8qVZ7skxbqg1b1zxfvgCkRN3bYA0Vt9Kuprb1JpBnRlh1kPzNK15r50oft
BebQ/RRpTIixs1f5mBYZyn6QBIRWNI7jKKJLBL+TMqlFUI30qK19qheibgHkbmtd
bPpakQrIpY2pjJEUsm2QNhABOnoIDN8iiV0+DKyWxbbmCt4ZZTBZcM6s2Hbr0t5M
7CbBqkuyDqw4I1CzdgQtVuGQcAm7CjfUy9vGef3xbqQHZomlrWpTFVcwVpcqnuWu
6eJ3SKiEMLXUh17PZyy1kk9+6v+McYaKNbDV9DUwJ1PtPD4Ya/A9IyRwunBzagU+
inrsMLvwhlLNVvH0mcedAXwKfTcxc7x7VZ7rISr9TLcijkWpcduIAtiv28bnO/ih
xQBLIyw8bJYtQ+PvbCuDKmGSLUPAa+rX+WuboSpv2RRZ5ZlTymSwQJVIwJ/MLogz
7A45abThiHLYRiBecgVZS+w83AAqXZMUj7BPUl3aO50I9zgJ8eQ=
=5v+K
-----END PGP SIGNATURE-----

--mamnyo2i4rxbn4ji--
