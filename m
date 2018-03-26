Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeCZLsR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 07:48:17 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41483 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750984AbeCZLsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 07:48:16 -0400
Date: Mon, 26 Mar 2018 13:46:45 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Paul Kocialkowski <contact@paulk.fr>,
        Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/7] ARM: dts: sun7i: Add pinmux settings for LCD0 RGB888
 output.
Message-ID: <20180326114645.lxvw5twhfzwfsswz@flea>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-4-git-send-email-giulio.benetti@micronovasrl.com>
 <1521986953.5301.4.camel@paulk.fr>
 <20180326100114.fa7vjw342ad6vrb6@flea>
 <e3e51afb-bb32-7f2f-877e-b6c74d71ab06@micronovasrl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nmuan7bpy7aqwqnc"
Content-Disposition: inline
In-Reply-To: <e3e51afb-bb32-7f2f-877e-b6c74d71ab06@micronovasrl.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nmuan7bpy7aqwqnc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2018 at 01:27:05PM +0200, Giulio Benetti wrote:
> Hi,
>=20
> Il 26/03/2018 12:01, Maxime Ripard ha scritto:
> > Hi,
> >=20
> > On Sun, Mar 25, 2018 at 04:09:13PM +0200, Paul Kocialkowski wrote:
> > > Le mercredi 21 mars 2018 =E0 21:03 +0100, Giulio Benetti a =E9crit :
> > > > The A20 supports RGB888 with H/V sync from LCD0. Add a pinmux setti=
ng
> > > > for the needed pins.
> > > >=20
> > > > Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > > > ---
> > > >   arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
> > > >   1 file changed, 8 insertions(+)
> > > >=20
> > > > diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi
> > > > b/arch/arm/boot/dts/sun7i-a20.dtsi
> > > > index efb5607..bfe6728 100644
> > > > --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> > > > +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> > > > @@ -922,6 +922,14 @@
> > > >   				pins =3D "PI20", "PI21";
> > > >   				function =3D "uart7";
> > > >   			};
> > > > +
> > > > +			lcd0_rgb888_pins: lcd0-rgb888-pins {
> > >=20
> > > It would be more consistent with other pins definitions to have
> > > underscores in both names and to indicate the index, such as:
> > > lcd0_rgb888_pins: lcd0_rgb888_pins@0 {
> >=20
> > Both your suggestions will generate DTC warnings, and we'd like to get
> > rid of them eventually :)
> >=20
> > > This way, other set of pins for LCD (PH0-PH27) can be declared as @1
> > > when they are needed in the future.
> >=20
> > A better idea would be to call it lcd0-rgb888-pd-pins, and introduce
> > the ph variant when it's done.
>=20
> As I know, only PD is muxed with LCD0.
> And PH is for LCD1 only.
>=20
> And LCD0 seems to come out only from PD port according to datasheet,
> this is why I didn't put @0 after lcd0-rgb888-pins.
>=20
> So I don't think it makes sense to handle pins in the way Paul suggests.
>=20
> What do you all think?
y
That seems sensible in this case, yes.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--nmuan7bpy7aqwqnc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlq43aUACgkQ0rTAlCFN
r3Q4OA//fyGcKzs88JAjhcgSMW8Etvgnu+u6zQXlRaqXNkCT5+tdwaseextkdKuu
+TxmCwdzYRKxemRKQDLWa9xTszOMLQs89AshL9kG5DfVtdiJ/tQUyOOJCHUEm7W8
EpSNb9pGEpZHq/AEFQv591ESYehaC5OZQ362cNua+/jR4R/EKOlNUFkwywfVuhkt
nAhpUC2DjLJRN8A3VzVOm3uNUzp/OcTjHmjm7DdyzXZ7uNGwT6Xbo7ikthUYQxnm
EKbUmUYx5/mHvBgLh3MM9NRhLCxc69ARDqXVTsQ8usyK68TXgW2lW0VwsWivlzY9
BgUwHyLFNUlZabblpSdiA3SVD5FO3QiJ+o2HQztENhIEKcdGAWCK4h2UdnSkC7sF
3mmUir0ZfCMt3Wkl6kZTwbq/RleGJD311NxIEvXzBC1QciuES9V/d+MhvvM1b449
Jpy3kLr/sWfckG3J5wJzDbrY5N/wsci8gjpQTAmx5ZM1i3lV0shu1xC4WCsaCpN0
xisYvVLx6+PJKyXZG7ClR+s2oEiMyh/eCZr6zQUhOgnEE5fCeWkJY64j+87hiih5
dMNV2Kz+mhsCP/juizjfwrC+wiO81/+5VDh1iMI5FQM5LNpRSF6Ewka3/zO/EdFE
LLMlIJkmw0PQ69zumEH2kxpI5tvwjR3fJat+SGHSxBhk57xYoJQ=
=gjNK
-----END PGP SIGNATURE-----

--nmuan7bpy7aqwqnc--
