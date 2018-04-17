Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeDQLTQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 07:19:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54783 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752694AbeDQLTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 07:19:14 -0400
Date: Tue, 17 Apr 2018 13:19:02 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>,
        Simon <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        "open list:ARM/SHMOBILE ARM..." <linux-renesas-soc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 08/11] ARM: sun9i: smp: Add is_sun8i field
Message-ID: <20180417111902.4u6d3mxehxjqibe4@flea>
References: <20180416215032.5023-1-mylene.josserand@bootlin.com>
 <20180416215032.5023-9-mylene.josserand@bootlin.com>
 <20180417075233.f2z6wxcazwqheoib@flea>
 <CAGb2v643iepq4B9ukNag8pzAFWiQ6A31ChfXLkxeExhK4jRm=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mgjhdnizrdjxc2v3"
Content-Disposition: inline
In-Reply-To: <CAGb2v643iepq4B9ukNag8pzAFWiQ6A31ChfXLkxeExhK4jRm=Q@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mgjhdnizrdjxc2v3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 03:57:07PM +0800, Chen-Yu Tsai wrote:
> >> @@ -697,6 +700,8 @@ static int __init sunxi_mc_smp_init(void)
> >>                       break;
> >>       }
> >>
> >> +     is_sun8i =3D sunxi_mc_smp_data[i].is_sun8i;
> >> +
> >
> > Do we really need to cache it? Can't we just have a pointer to the SMP
> > data structure and use that instead?
>=20
> I recommended that. We don't need any of the other fields in the SMP
> data structure once we're past the init phase. This saves a dereference
> or two.

Fair enough.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--mgjhdnizrdjxc2v3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrV2CUACgkQ0rTAlCFN
r3QFRw/+JjrjBNJt+HNnDm8GaE7ITOndVszG5cE5okgfzSBft3JehFRr3mfM6d0I
9dhnN4pMpELEyf6ElSqCd60wKPpVaEzLZ/XvOHIHKi12SqoZbSJ05A0DcDLwolyv
FD7KRCd4336kERulK+tGnxkv3FOR2q9mPvqXtpehwVoI0z3rNu2HxnpDnfbKyXyD
PTYNtFCU+04O+hY4WNZPdW0bBFevzKqxCI0ZLpAfx9UILeHh6Mdd3WBXINnPpffw
B/XJ1m9vhtsQtnUiIpXF9+B6nJ6UPInU/gzmyIHEUetV26rN0eUm6beOPHOgiuLu
Et5JDY0MNwqQWf5R76OqFJ7RtqkUZ9jiJM/g5RJdXSf3NUTesKRqOYWXnAMVowRy
tO6y/KYhqoyZ4nUQ+kA0wx7spNUoVFjU4Tc8/SfZBGjKFjczWaax83m7/JgjZrk6
ItAvTWcR7EhtBrD6gMUspHssLX0/0czjzMflEdgFVteSWiWHxbE0T4B1GWA5AKpM
8TofCx0JKMcJ2kugCI2h4CPs+8Od0DbzLzhzAltc/+H4wU0oIyRiH+HDDy0g2wBA
UB8s8aJWofnKwHRzhyW+wZDqYYHPwo1LdG0Y7fZRnGKZMWCk+JmjD42ZDfv9jtb7
zM/XN6mdfXvsHw+VYBop1IoNF896m83Q85LVrXDdZGQCLnSFWqA=
=2G36
-----END PGP SIGNATURE-----

--mgjhdnizrdjxc2v3--
