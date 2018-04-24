Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933084AbeDXImL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:42:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37445 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932951AbeDXImD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:42:03 -0400
Date: Tue, 24 Apr 2018 10:41:37 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 7/7] ARM: dts: sun7i: Add dts file for the A20-linova1-7
 HMI
Message-ID: <20180424084137.7xfwji2gcibxavvt@flea>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-7-git-send-email-giulio.benetti@micronovasrl.com>
 <20180322180508.my64gobhh5rc2x2m@flea>
 <8ef3b259-03b4-6987-286e-36ff627a8b76@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gdizi5czxofbgsf4"
Content-Disposition: inline
In-Reply-To: <8ef3b259-03b4-6987-286e-36ff627a8b76@micronovasrl.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gdizi5czxofbgsf4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 23, 2018 at 04:37:33PM +0200, Giulio Benetti wrote:
> Il 22/03/2018 19:05, Maxime Ripard ha scritto:
> > On Wed, Mar 21, 2018 at 09:03:13PM +0100, Giulio Benetti wrote:
> > > The A20-Linova1-7 HMI, also called Q027_2_F which is printed on produ=
ction
> > > label, is an industrial Human Machine Interface.
> > > It features:
> > > - 512MB DDR RAM
> > > - 1 Sd-card >=3D 4GB
> > > - 1 Usb otg(programmable via software) with A-Usb Connector
> > > - 1 Usb host
> > > - 1 Buzzer
> > > - 1 Input for LiPo
> > > - 1 Relay to signal absence of power supply
> > > - 1 External Rtc with 56 bytes of ram + CR2032 battery
> > > - 1 7" 24-bits Tft 800x480 with PCap on
> > > - 1 Mono audio 1-watt amplifier
> > > - 1 RS485 port
> > > - 1 Power On Line through +12Vdc reaching 57.600baud,
> > >    from where it can be supplied and placed in a network of 50 units
> > > - exposed jtag pins
> > >=20
> > > HMI is supplied from +12Vdc.
> > > Ethernet is absent, so for debugging, need to enable rndis on Usb otg
> > > port through an A-A usb cable.
> > > It comes in different flavours for connector types and can be found w=
ith
> > > umounted features as requested by customers.
> >=20
> > So this is essentially the same board than in patch 6, but with a
> > different screen?
> >=20
> > You should have a single DT then, and handle the two different panels
> > using DT overlays.
>=20
> Ok for having different DT overlays.
> But do I have to submit them as patches? Or keep them in my company's rep=
o?
> I ask you this because this involves sending also patches for displays
> and other little modifications to mainline ex:
> - rgb888 pins
> - 2 simple-panels
> - 1 uart iomux pins
> etc.
>=20
> If I don't submit those overlays, the other patches wouldn't make sense
> alone as I've seen, just like rgb888 pins.

We don't have a repo for overlays yet

> > > +&usb_otg {
> > > +	dr_mode =3D "otg";
> >=20
> > You're saying that this is a USB-A connector? Then it's not OTG since
> > it doesn't have an ID pin, this is an host.
>=20
> Right, with a special overlay I will activate Usb Device for RNDIS,
> so modified as host

That doesn't really make much sense. The USB OTG is wired only using a
daughter board?


> One last question:
> now I have some patch already reviewed-by.
> Do I have to re-submit entire patchset?

Yes

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--gdizi5czxofbgsf4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlre7cEACgkQ0rTAlCFN
r3RVkhAAk7jvGeipN7uTzO3GHHwIz7NmV7Dm4MuOuBcH5V+IviMUr5anTp/b8Isd
MH2xmnHy/ZuUexS8U19mD0Tw746nRcT7hZxkbjUixJFn4EtZTf11GrFaNaYoOMoi
H1CHLZdcKPGp4Z56v6lLIQK7RKiYnY2kYK3A25tFAv3tCFGG2PafFMesrkAHtqKg
G3PlICbk7Ilz9FgFxRvcPlAvqRyjcuRCYuZXK+N6Lzp1e+zG8bke+63Cmmp/xTnC
GcRdj4NbEucziVIs0oJY/k713m70rN+JVwdxyTigj7YD3QGWi55jLckAOQ0gLrTi
cQH1yTMm68uhIDmf55llehXfeTnAzy6+lFtVvUDNJ19yw9W90M60F0SRFnFyNjqX
EnhN0+/hbpDPTGjaXLZ4E9retaCHubiv0PjUbDr3/3yt9UcJoxO6Ez0TWpbpIhmL
n7cqWW60qkonqA/hOK6v0vwUbya6QHLug95GtGeiN8KSqyWJ93XL6Am16AZDsPKS
fLZ7zrupiwVHQV2xHgqFgCcSgYZvSk8nRi8DaGbMQZuHSgY+IrneMUXRy7oTt20z
6AKe5oBhROjrEkKU8gLi+Rpcppi3xQmSbYS5uWWyCBsM8ePDIXtKqXeqZSpSdHQx
ErVtb4C9M50uCVRGLiWxLvcVBWPdJ3M2dtAuAgxnI939bzolbyM=
=gnYd
-----END PGP SIGNATURE-----

--gdizi5czxofbgsf4--
