Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752612AbeBSLGY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:06:24 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44070 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752486AbeBSLGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:06:23 -0500
Date: Mon, 19 Feb 2018 12:06:18 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Rob Herring <robh@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv2 4/8] dt-bindings: panel: common: document orientation
 property
Message-ID: <20180219110618.7hgsf3g6womvecay@earth.universe>
References: <20180208183035.8461-1-sebastian.reichel@collabora.co.uk>
 <20180208183035.8461-5-sebastian.reichel@collabora.co.uk>
 <20180218232424.47ejrqdze7nm7g5d@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qhcmj2p5ihe2p6al"
Content-Disposition: inline
In-Reply-To: <20180218232424.47ejrqdze7nm7g5d@rob-hp-laptop>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qhcmj2p5ihe2p6al
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 18, 2018 at 05:24:24PM -0600, Rob Herring wrote:
> On Thu, Feb 08, 2018 at 07:30:31PM +0100, Sebastian Reichel wrote:
> > Introduce new "orientation" property for describing in which
> > orientation a panel has been mounted to the device. This can
> > be used by the operating system to automatically rotate the
> > display correctly.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  .../devicetree/bindings/display/panel/panel-common.txt     | 12 ++++++=
++++++
> >  include/dt-bindings/display/common.h                       | 14 ++++++=
++++++++
> >  2 files changed, 26 insertions(+)
> >  create mode 100644 include/dt-bindings/display/common.h
> >=20
> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-comm=
on.txt b/Documentation/devicetree/bindings/display/panel/panel-common.txt
> > index 557fa765adcb..c646b8908458 100644
> > --- a/Documentation/devicetree/bindings/display/panel/panel-common.txt
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-common.txt
> > @@ -18,6 +18,18 @@ Descriptive Properties
> >    physical area where images are displayed. These properties are expre=
ssed in
> >    millimeters and rounded to the closest unit.
> > =20
> > +- orientation: The orientation property specifies the panel orientation
> > +  in relation to the device's casing. The following values are possibl=
e:
> > +
> > +   * 0 =3D The top side of the panel matches the top side of the devic=
e's
> > +         casing.
> > +   * 1 =3D The top side of the panel matches the bottom side of the de=
vice's
> > +         casing. In other words the panel is mounted upside-down.
> > +   * 2 =3D The left side of the panel matches the top side of the devi=
ce's
> > +         casing.
> > +   * 3 =3D The right side of the panel matches the top side of the dev=
ice's
> > +         casing.
>=20
> The rotation property in panel.txt already handles this, right?

Yes, looks like it can be used. I guess panel.txt and
panel-common.txt should be merged, though?

> >  - label: The label property specifies a symbolic name for the panel as=
 a
> >    string suitable for use by humans. It typically contains a name insc=
ribed on
> >    the system (e.g. as an affixed label) or specified in the system's

-- Sebastian

--qhcmj2p5ihe2p6al
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqKr6cACgkQ2O7X88g7
+po8cQ/9EVteOZx3fXZjuP4II4ARxZC9O6ylnbMakNUSqww40FfzU23Jjfu+4e0T
KxtluJxmzIkDSFr7FyUqH5p3d1zCpPiqVywvl1sw/66Ixm1XnrXsw84r7+r/ZVAA
1Yy6YT8UCAQiIa7ktzdLkK1sTIeyQAiHPvjYUxORuxWi3ozOg372uEt3+iw32u5+
rp0NMPV/ty2HVcOW19un+pbcJdt3bBKMTl3fgW7t9wzGu4u0V28hEzZrxk0LzTXb
9fxRodwfza9vDzaQ1izeAQ7li//f/PUp7xT8jZglQnI60Sobr6AVYs6nIZWimXSP
aahP5Il3+eLUjEFIrzQX/CW3dVTNAkZk10OrGurxc8TmT0cFx232OzAGW9fZKpXR
dYox9VlDRfOdJLWAszLMB3MMYmm1zZ2W9iivl9FrX2Y3qSy8/mLvDwG79bcF2fXa
+m00+Orw8u16Q7reMgaRgd5BvXilnTT6dIxRrco0xXMiA1z86pHRLgLkS3YOICKF
tPnUcSTmX9iXW77ceWPLf9lBBhRLr/xRCHK4o9ApsOKJToDO+/gQmHmowSuma+W3
skA4CTIpFtlSXSVVrHxnF7Tv/+WKCtV+fXzUNuFr3co5kEfZPBIBKFzYRyZpeVHM
S+kFDrbl5jy79zJW+sEKXHj9s5omTyAzDxp+zX9OS8OVcnOYKsY=
=96Q3
-----END PGP SIGNATURE-----

--qhcmj2p5ihe2p6al--
