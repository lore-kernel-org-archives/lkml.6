Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752559AbeBEFBY (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 00:01:24 -0500
Received: from mx1.mthode.org ([216.82.208.22]:38612 "EHLO mx1.mthode.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750854AbeBEFBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 00:01:17 -0500
Date: Sun, 4 Feb 2018 23:01:16 -0600
From: Matthew Thode <mthode@mthode.org>
To: David Herrmann <dh.herrmann@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: suppress warning about palm
 detection
Message-ID: <20180205050116.isaz6pmgsquzjmqr@mthode.org>
References: <20180112110445.1876-1-dh.herrmann@gmail.com>
 <CAHp75Vc66ZfRmOoOKJRODpV0mS2aZru=b-r0cr8SKYH=hm+W6Q@mail.gmail.com>
 <CANq1E4RGo091oaG=0owKVfxOV8wR2qQ=nXfXzZsRxg6Q7_C8zw@mail.gmail.com>
 <20180113063309.iryfhufpilas3jnf@mthode.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7fnz55mbyfs4jstu"
Content-Disposition: inline
In-Reply-To: <20180113063309.iryfhufpilas3jnf@mthode.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7fnz55mbyfs4jstu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18-01-13 00:33:09, Matthew Thode wrote:
> On 18-01-12 15:07:12, David Herrmann wrote:
> > Hi Andy
> >=20
> > On Fri, Jan 12, 2018 at 2:50 PM, Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Fri, Jan 12, 2018 at 1:04 PM, David Herrmann <dh.herrmann@gmail.co=
m> wrote:
> > >> Cc: Matthew Thode <mthode@mthode.org>
> > >
> > > Shouldn't be Suggested-by or even Signed-off-by?
> >=20
> > The patch is different (Matthew originally suppressed the ACPI event),
> > so I did not copy the sign-off. Please add Suggested-by, if that is an
> > acceptable tag.
> >=20
> > >> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> > >
> > >
> > >> +       case TP_HKEY_EV_PALM_DETECTED:
> > >> +       case TP_HKEY_EV_PALM_UNDETECTED:
> > >
> > >> +               /* palm detected hovering the keyboard, forward to u=
ser-space
> > >> +                * via netlink for consumption */
> > >
> > > Comment style is
> > > /*
> > >  * Multi line comment.
> > >  * This is an example.
> > >  */
> >=20
> > All other 6 comments in this function follow the style I used here, so
> > I tried to be consistent. But feel free to amend this change.
> >=20
>=20
> I'm fine with a signed-off-by or tested-by or suggested-by.  There is a
> spelling mistake though, 'hoveres' should be hovers.
>=20

Is there anything else I can do here?  I'm not sure any of us have the
ability to find out what lenovo actualy wants this for.

Sorry for the double reply, dmarc can be hell.

--=20
Matthew Thode

--7fnz55mbyfs4jstu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEExFR3cOKGRpGbcMHPZKN76q4ZpOgFAlp35RsACgkQZKN76q4Z
pOh0Tw/+PFKElFvPV+ior11CLK4haH+IwI5WirzZiz6t7FFTPGCaT0DXPEEV3YND
2QoCk4qvk9FwYwZ3h4lamsoQ339dsXeCy/+uD7Z/TBM9KFfX1MhkBV3bPQI/cRkE
7kqfLd7JcJgwgORAL6eHc0artWNh0WBF2OeeGk7EpFU0MLibsJ7ys7KdXLtu+eig
IVfrXXjnVx67uE/KrS3GURIT38awoaXcEDDDutevAHVTkQnsoldfKQuSILsUYnS1
tn2oYsXcYmdcOizX7vc7rSi+aDFagiL+yY4gKcILQ/DHtTnwc8ZvPo1kRDfVw6Rx
fLnYwX+oVJ/gcuZR2cKLKUemxKbWYzSNRKVcQQI8ad/7KRoHPnviHR/FRF3Wzo5J
UjkSY2NFD7BAIkAh9hHrEWNGfwPXyCCCOHOvUyBw/nave2lDaGtcVssV5bn2b66u
GL6nhuw+Z2rT9DUJeGpLOoFtflbw1yNxu7YQJbTWWEfj9DkbxUT49Rgb+EuFuMwV
oYIDnwgjf4l8FO0f8wWx55EeTNIrSv1lOLjPWPDHXvcpwzA0b7vjbY3oG+lyyvqT
GcuGNNrOD7dc7F7Ou+2b8OL6z3gDuK+WBfcOQVN7xQ0xq6RWg0tHx99ivrpemmyf
+D/iSKIOVKkHFXaH5xastcoWoVw3ct9pYJD/6BbtEXZ8D2qNUy0=
=uKZt
-----END PGP SIGNATURE-----

--7fnz55mbyfs4jstu--
