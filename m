Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbeCZLPH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 07:15:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:40566 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbeCZLPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 07:15:06 -0400
Date: Mon, 26 Mar 2018 13:14:54 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagannadh.teki@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, dri-devel@lists.freedesktop.org,
        Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 0/7] drm/sun4i: Allwinner MIPI-DSI support
Message-ID: <20180326111454.jqq5dchw27iqhxhe@flea>
References: <cover.14d017af44a2140bea674731b60a0dd7f992f5f6.1520344489.git-series.maxime.ripard@bootlin.com>
 <CAD6G_RSfiPC2qPjFFukqx6ihzS=_qBOdsP1KnWTP8BJ9Zsekew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="o44d22k5nptwpobw"
Content-Disposition: inline
In-Reply-To: <CAD6G_RSfiPC2qPjFFukqx6ihzS=_qBOdsP1KnWTP8BJ9Zsekew@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o44d22k5nptwpobw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 23, 2018 at 10:36:35PM +0530, Jagan Teki wrote:
> Hi Maxime,
>=20
> On Tue, Mar 6, 2018 at 7:25 PM, Maxime Ripard <maxime.ripard@bootlin.com>=
 wrote:
> > Hi,
> >
> > Here is an preliminary version of the MIPI-DSI support for the Allwinner
> > SoCs.
> >
> > This controller can be found on a number of recent SoCs, such as the
> > A31, A33 or the A64.
> >
> > Given the sparse documentation, there's a number of obscure areas, but
> > the current implementation has been tested with a 4-lanes DSI panel on
> > an A33.
> >
> > The support is a bit rough around the edges at the time, and some artif=
acts
> > are still shown on the screen for some reasons. Wider testing with
> > different display will hopefully nail those down.
> >
> > Let me know what you think,
> > Maxime
> >
> > Changes from v2:
> >   - Added a ports node under the DSI node
> >   - Changed the huarui panel driver to an ili9881c driver
> >   - Changed the panel vendor to bananapi
> >   - Made the init table static in the panel driver
> >   - Dropped the huarui vendor patch for the DT doc.
> >
> > Changes from v1:
> >   - Rebased on 4.16-rc1
> >   - Constified a few function arguments and structures
> >   - Reworked the DT binding example a bit
> >   - Reworked the panel driver to check for DSI return codes, and use DCS
> >     helpers when possible
> >
> > Maxime Ripard (7):
> >   drm/sun4i: tcon: Add TRI finish interrupt for vblank
> >   dt-bindings: display: Add Allwinner MIPI-DSI bindings
> >   drm/sun4i: Add Allwinner A31 MIPI-DSI controller support
> >   dt-bindings: panel: Add the Ilitek ILI9881c panel documentation
> >   drm/panel: Add Ilitek ILI9881c panel driver
> >   arm: dts: sun8i: a33: Add the DSI-related nodes
> >   [DO NOT MERGE] arm: dts: sun8i: bpi-m2m: Add DSI display
>=20
> Any dependencies for this series on linux-next? it is not applying direct=
ly.

Last time I rebased on top of 4.16-rc4, there was no dependency but
the regmap patch found in the v2 that got merged. I haven't tried
rebasing on next though.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--o44d22k5nptwpobw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlq41i0ACgkQ0rTAlCFN
r3Qe3w//ehSw4WAyVFs7pxvHWVrPtuTJ5YQ3ItSyDPnZaZsK/zUH4AJJj8MBGnju
ydxiBCV8bfpbl1hqeqAcfqVA0VZXhFqspZvNUoX7BnObzqh3s77LqMSn+/Glldgr
nTjXc9hbVA1zoQuXd8NyIzdSjTPzGLAZ81KXx/XdjqyuUJrNEGuo8FTRlNZJ/Cx6
v8qg3cQFlz7ENulgzcL1ikHrF2IACn+HlaWLohQ8whXrHAnwW5gEea6wTREFzKuj
gKBlF8ZkcaL8QDJ5L55AnEwfmv1CnWxbrY/5NfsggB1D/zmFTIXUn6zYKWRxIxof
6tytgi1xx6d36aLNfRXrE73aVFHxFFW1EL1ORmndDyaORb8Xs+oFWpGR5R8++aRx
64x8zGEnPnhbLYm0BDiHF4LW+xx49WD3FHS83Ay0iHtM+A+51CkqFz/wUYTm/ZHZ
XA3kmdCfAiBcg72RK6VHp3iyGKUWph7Puq96vrpwzRd+PkR5p6GtnPsTkSgWqULQ
d99CwtzixIwYuWGRF96M+MGQmSbK5eZzCLnIoyd21g6AOxBzaL08MooNvh1SeLKj
Dc9i0ZtWdIElZyqsCyT6/WIDFyOn6fgxtJ1MUyHNxf+O3UzRXIY/bv5GIaHPsoRA
+NHn3euWojWi/wSBKw9yLAmDdB/MbdFH3PyKfZj9QYXoZRTfVU0=
=GVvI
-----END PGP SIGNATURE-----

--o44d22k5nptwpobw--
