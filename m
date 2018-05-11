Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeEKO6C (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 10:58:02 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45532 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752997AbeEKO6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 10:58:00 -0400
Date: Fri, 11 May 2018 16:57:58 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2] arm64: allwinner: a64: Add Amarula A64 Relic initial
 support
Message-ID: <20180511145758.z3ufqu3njnm7kb2m@flea>
References: <20180511054307.3410-1-jagan@amarulasolutions.com>
 <CAGb2v67ZDUqLGiWfocZXzGY54dYcSVUMC-xz87xaJQs88-nqyw@mail.gmail.com>
 <CAMty3ZCM7Sxsp4MwDRYq9NSfWJfj6XKK6JN9DKyk91MNrLvPAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="obqtqp7m74x2wcoj"
Content-Disposition: inline
In-Reply-To: <CAMty3ZCM7Sxsp4MwDRYq9NSfWJfj6XKK6JN9DKyk91MNrLvPAg@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--obqtqp7m74x2wcoj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 11:37:04AM +0530, Jagan Teki wrote:
> On Fri, May 11, 2018 at 11:20 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> > On Thu, May 10, 2018 at 10:43 PM, Jagan Teki <jagan@amarulasolutions.co=
m> wrote:
> >> Amarula A64 Relic is Allwinner A64 based IoT device, which support
> >> - Allwinner A64 Cortex-A53
> >> - Mali-400MP2 GPU
> >> - AXP803 PMIC
> >> - 1GB DDR3 RAM
> >> - 8GB eMMC
> >> - AP6330 Wifi/BLE
> >> - MIPI-DSI
> >> - CSI: OV5640 sensor
> >> - USB OTG
> >> - 12V DC power supply
> >>
> >> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >> ---
> >> Changes for v2:
> >> - Rename dts name to sun50i-a64-relic.dts which is simple to use
> >
> > This is subjective. For other users this hardly qualifies to
> > identify the board. Please keep the vendor / brand name in
> > the file name.
>=20
> Which I thought initially, but adding vendor makes long string which
> become lengthy for next boards to add it in future. So we make
> notation with <SOC_name>_<board_name> like sun50i-a64-teres-i.dts
> does.

In the case of Teres-I, this is an easily identifiable board, for
which a simple google search can give you very easily what board it is
and where you can get it. Yours fail for both, so I agree with Chen-Yu
here.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--obqtqp7m74x2wcoj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr1r3YACgkQ0rTAlCFN
r3TAJA/+OIFPglicsm38Q24bOiDd1D4wAUkUGBwQWnHnK8UNyGWL2hmzTJ93To6V
YWz4dD0RlpGVdkPy2/2Df67FFZuQdf2zpMNpEuWHdMQ4yE3jRmZmDfDfL/Fieku0
sFt0zNj/aPBxQTfFYtLelDaqlZam2L3TlKE0abqk3reSL7ld3idcG9lG8pvdJYHu
1bQlhaQkFMdhS/NESikPELsU1CHy3nGMZl6fVno952ePr7ecvh+CMXcdmNrqKGCF
jboS4ER4K/HSD20riqEwcJT7i8WeDobsuGPpq7kK+nqO97WTzvGDrF22hNRO5SLe
xkTgm1KsrJkr8oQOidih6nXWrx7QKQTVMOFpGl9YgOJu+kXG6fnhGoS51oZX6w0Q
C0JzT+WjXFu+ShNtIGEXLrM7xTIUjHhcwAjq4gSypK5HeWDQgtwAefqUI+rJp905
qEG7tH0/4wtCez1Xf2d8aBpj/19fY1LFNsbzfSFjGzJao/eZucwWperedl9mKhVi
idrg4ywmsc9YK2/6L6KCzhu9ACUbyoeNmxCfocdcfmhf64Q4aTWphsNqksRNm/TP
HYKdUbM7bGsMFE/bb02OcWFQ9/UXFQkpD+tSqYXwfNO+Vd07DlCvLcoAOW9wLv6b
iXMprd9dmAJRDzSpXuE67SGiYfuKeisisH6q8LjgeDBHX/Xz6Lo=
=TYLN
-----END PGP SIGNATURE-----

--obqtqp7m74x2wcoj--
