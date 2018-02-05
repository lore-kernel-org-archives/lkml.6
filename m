Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeBEE4g (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 23:56:36 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:35108 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752253AbeBEE43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 23:56:29 -0500
Date: Sun, 4 Feb 2018 22:56:24 -0600
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
Message-ID: <20180205045624.t5g2c2o7l3dkokzl@gentoo.org>
References: <20180112110445.1876-1-dh.herrmann@gmail.com>
 <CAHp75Vc66ZfRmOoOKJRODpV0mS2aZru=b-r0cr8SKYH=hm+W6Q@mail.gmail.com>
 <CANq1E4RGo091oaG=0owKVfxOV8wR2qQ=nXfXzZsRxg6Q7_C8zw@mail.gmail.com>
 <20180113063309.iryfhufpilas3jnf@mthode.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hax7konvqwaawvau"
Content-Disposition: inline
In-Reply-To: <20180113063309.iryfhufpilas3jnf@mthode.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hax7konvqwaawvau
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
ability to find out what lenovo actually wants this for.

--=20
Matthew Thode (prometheanfire)

--hax7konvqwaawvau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEExFR3cOKGRpGbcMHPZKN76q4ZpOgFAlp34/cACgkQZKN76q4Z
pOi9HQ//X/e7XumXEd4wWQ/ivljJdoee2/TopBs94TuJZkQSpHYslhgbDWk+FeKq
guFgAnA7uMkkNBmmM1Y4fZv95le1EZ1KczUq6j/OOcFUek/NANcg99/MqkdXbHjv
puXwG9IXkzjBPcnLQFvh+5o0Hy8NYdpibhbp5BXmmfFnF7brANMiqiz7pk7iKqBd
XQTHRT6tS296XbKlwh5n7mruVSTlacObk04l/UxDZfP5LvVXvaGnlSGJdj+IHqpE
r+6R+QX/i9SFiNKy+xwztDR83JywfZvALgr7IMoTZSjrWPAwtCDRfRcNGIMbXdvb
ANLUk1l0wyWaPWLL2ybw61qEY9Wb30vwsOoZ0mXRHhW/NdczBnQfA8HXbtW8LzgN
F2p6SvaMBY8xErSNrp6Fnj/bejAcSquW7R5gK0M4ENu8uaNP+OmG5mRfOKr3Jogu
putGiy6HcTavY7h9BFPAkp5YsCuxJ1Xpk+3tqrpU2DKrTR5wM7PAQqN0W6wro58d
k6hX4/M2LLp6tOKthIjcSyXDDWLv7vZPKB9fFP59XGZWfnHfmaPzfcwbozy5FPzS
I2/uqm55uPBv+kdEZAxXmPXdwjUoNYoDLViNgfe+YQpqZaJCfjTviOutePIADLV7
UVhs7GYNbwQEZMNnCPgKCZX8v+UvDFJc8KqN99fZXoSp4zMLSVw=
=7V0W
-----END PGP SIGNATURE-----

--hax7konvqwaawvau--
