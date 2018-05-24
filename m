Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965581AbeEXIyn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:54:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45040 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965007AbeEXIyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:54:39 -0400
Date: Thu, 24 May 2018 10:54:27 +0200
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
Message-ID: <20180524085427.xs6yzhpa42zop6e5@flea>
References: <20180522132228.6564-1-jagan@amarulasolutions.com>
 <20180522143044.pgwawojiwnk2lzxb@flea>
 <CAMty3ZD3JT-ToGAUHN_uj7uVK-jkyAwfEdTBCmJSj34bACFpYQ@mail.gmail.com>
 <20180523081830.4ly6sj34reabbttn@flea>
 <CAMty3ZC-N-6WzYg+kYd2+V3wbQdQmvU706Nog_Urd_EUaWnQjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="e7gzo5xpcsc36slw"
Content-Disposition: inline
In-Reply-To: <CAMty3ZC-N-6WzYg+kYd2+V3wbQdQmvU706Nog_Urd_EUaWnQjQ@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e7gzo5xpcsc36slw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 23, 2018 at 03:57:05PM +0530, Jagan Teki wrote:
> On Wed, May 23, 2018 at 1:48 PM, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> > On Wed, May 23, 2018 at 11:44:56AM +0530, Jagan Teki wrote:
> >> On Tue, May 22, 2018 at 8:00 PM, Maxime Ripard
> >> <maxime.ripard@bootlin.com> wrote:
> >> > On Tue, May 22, 2018 at 06:52:28PM +0530, Jagan Teki wrote:
> >> >> Amarula A64-Relic is Allwinner A64 based IoT device, which support
> >> >> - Allwinner A64 Cortex-A53
> >> >> - Mali-400MP2 GPU
> >> >> - AXP803 PMIC
> >> >> - 1GB DDR3 RAM
> >> >> - 8GB eMMC
> >> >> - AP6330 Wifi/BLE
> >> >> - MIPI-DSI
> >> >> - CSI: OV5640 sensor
> >> >> - USB OTG
> >> >
> >> > You claim that this is doing OTG...
> >> >
> >> > [..]
> >> >
> >> >> +&usb_otg {
> >> >> +     dr_mode =3D "peripheral";
> >> >> +     status =3D "okay";
> >> >> +};
> >> >
> >> > ... and yet you're setting it as peripheral...
> >>
> >> Though it claims OTG, board doesn't have any USB ports to operate(not
> >> even Mini-AB) the only way to use the board as peripheral to transfer
> >> images from host.
> >
> > I'm not sure what you mean here. If there's no USB connector, why do
> > you even enable it?
>=20
> I'm saying there is no host port on board. Board has connector
> header[1] comes with few pins includes USB D+, D-, ID, VBUS, GROUND,
> UART0 TX, RX etc. we have to connect wires to these pins to make
> pluggable USB to host pc. and here USB pins used for transferring data
> from host pc to target board like in peripheral mode.

I'm still unsure how it's relevant. If the wire is plugged on your
board's header, is there anything that prevents using it as a host
assuming you have a proper connector on the other end of your wire?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--e7gzo5xpcsc36slw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlsGfcIACgkQ0rTAlCFN
r3TBKw/6A1UzH7IDmW8Z8xjLBcDnrJiwZko3JMOHLVOX97DMqkhguyq7SqW9ripF
p4Xac/SNzae1XIVn3dgOEIHO2VANxI4zt7RAPB6Pc51CRI42Epw+vod63P96uqI6
LcduDNHPNkqNWzm1XIRoHpTyLu/KfcwturxG3gvjL+wVl64AZnoferBoF10dxXp6
r+MaiB0JdobQWTxc+D43hjd5yQSxyIBkDJh9ptOt/ZyZA5FWsoFhuHXsXUeSQaar
hBFguvzttpldLPbJLZHC9FYxAlwU+6wg/3eqCNUO5/GMU9OTtMIopn7WQ61rCd8f
EpO5cXVr7XA4P8aSywJVy2c2riHKgTwAr6kbA/+Amy+lfACkbuKeC4yREeMEd3Ib
jRDSjuonMNOJGM1UbQMNQGuV7zqJqUZT2VnEEXFGgFq6DYOdyKv7neAnQso2S8Nw
5LmugK1NbIa2WDmaEW18Pnwye8JE3EF1rBHlS/KlTM8cUAYiwov+cNtLHcXvXrb0
UdLSyoXUKrADKAY3zbyV93beu2iEj+Y2ER1BU1uJpn0uJTTlnRZ/HCJF5cUNCREo
rtyRYaQJb/oeF1KCraSGyRrWaAMjAO6fg6Sc4f3rNvqGh3CRIdPK2aoL/FNJyQlt
Wcnajz3dczIa3LgMzrBq+pFCqW3xVWOwyUB/6Wfl03rgD9fm9IU=
=2Lkk
-----END PGP SIGNATURE-----

--e7gzo5xpcsc36slw--
