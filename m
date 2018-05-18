Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbeERHOu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:14:50 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49164 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbeERHOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:14:48 -0400
Date: Fri, 18 May 2018 09:14:36 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <contact@paulk.fr>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v4 3/3] ARM: dts: sun7i: Add support for the Ainol AW1
 tablet
Message-ID: <20180518071436.3vvyllghrdxptsxg@flea>
References: <20180507220413.21990-1-contact@paulk.fr>
 <20180507220413.21990-3-contact@paulk.fr>
 <20180511143647.ici2bfoeeldto3ju@flea>
 <0da5787f0ce2309a74db88820bc58b3b3501c451.camel@paulk.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nbdmosmxbine5fy7"
Content-Disposition: inline
In-Reply-To: <0da5787f0ce2309a74db88820bc58b3b3501c451.camel@paulk.fr>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nbdmosmxbine5fy7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 10:36:08PM +0200, Paul Kocialkowski wrote:
> > > +	backlight: backlight {
> > > +		compatible =3D "pwm-backlight";
> > > +		pwms =3D <&pwm 0 50000 PWM_POLARITY_INVERTED>;
> > > +		brightness-levels =3D <  0   1   1   1   1   2   2   2
> > > +				       2   3   3   3   3   4   4   4
> > > +				       5   5   5   6   6   6   7   7
> > > +				       8   8   8   9   9   9  10  10
> > > +				      10  11  11  12  12  12  13  13
> > > +				      14  14  14  15  15  16  16  17
> > > +				      17  17  18  18  19  19  20  20
> > > +				      21  21  21  22  22  23  23  24
> > > +				      24  25  25  26  26  27  27  28
> > > +				      28  29  30  30  31  31  32  32
> > > +				      33  33  34  35  35  36  36  37
> > > +				      38  38  39  39  40  41  41  42
> > > +				      43  43  44  44  45  46  47  47
> > > +				      48  49  49  50  51  51  52  53
> > > +				      54  54  55  56  57  57  58  59
> > > +				      60  61  61  62  63  64  65  65
> > > +				      66  67  68  69  70  71  71  72
> > > +				      73  74  75  76  77  78  79  80
> > > +				      81  82  83  84  85  86  87  88
> > > +				      89  90  91  92  93  94  95  96
> > > +				      97  98  99 101 102 103 104 105
> > > +				     106 108 109 110 111 112 114 115
> > > +				     116 117 119 120 121 123 124 125
> > > +				     127 128 129 131 132 133 135 136
> > > +				     138 139 141 142 144 145 147 148
> > > +				     150 151 153 154 156 157 159 161
> > > +				     162 164 166 167 169 171 173 174
> > > +				     176 178 180 181 183 185 187 189
> > > +				     191 192 194 196 198 200 202 204
> > > +				     206 208 210 212 214 216 219 221
> > > +				     223 225 227 229 232 234 236 238
> > > +				     241 242 244 246 248 250 253 255>;
> >=20
> > You kind of overdid it here :)
> >=20
> > What I meant to say before was that if you have 10 elements (and you
> > really should have something in that magnitude) each step should
> > increase the perceived brightness by 10%.
>=20
> Mhh I think 10 elements would fall too short to really depict the curve
> with appropriate precision. Given the usual size for brightness cursors
> in e.g. gnome-shell, it feels like a bigger number would be more
> appropriate. Let's make it to 100 with values from 0 to 255!
>=20
> > In this particular case, I really think having something close to <0 4
> > 8 16 32 64 128 255> would be enough.
> >=20
> > And in general, that kind of odd looking table without any more
> > context is just screaming for a comment :)
>=20
> Noted, I will explain the idea, but probably without the exact formula
> that's really a nasty hack written down on a piece of paper sitting in
> my garbage at this point.

So no one will ever be able to understand where this sequence comes
=66rom (yourself-in-two-years included). That sounds like a pretty bad
idea.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--nbdmosmxbine5fy7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlr+fU4ACgkQ0rTAlCFN
r3S0LBAAlASmQQOKGMJroq5yq9oJiwEjEV3xAuKQMdBNZH/awRSR4woLhbbC/hab
hWNTj/DRrui6VVBz53L9W7ewPoYf9X73m1NarZ02vA7WZpG46E/AXs7uZV+NC6/4
2akfQiWdeIArLP/TqTSIZJ33pqIkl/tT2hkpj6K51jqDlaT+iysUbaWN46KXi/mW
OR3k3JcSIUBbiNa6jM6f6YBOnbFbtK1rpKuQYK0OZMOCcRUW4wZJnwiQDULDKIQu
QCw59CB/kD/aEDGfG0ZMG13cUP0qPB3Tal56BsTOPpDnrOP54Ty1/8DPawxk4aZ/
+vyT2/e8uNH+vQERdWf4E0Z3iPnTznEjfvvDNGO1QiqVfPVnixcIwrPL5KB74+nD
aqD/ZUMewCkwc4UC7dkxTLEkt75dk0+egNkVQ+5fLBTGwNbu0WNatxAaFeqjtRlU
MOh1fBoqzrgt3qlFwMRk+EKZXEzR07ZlYh8XE8iVjGKFzc4TiVyKHv5xAcNxfRRz
TNwSnXlax/RkLu5ol5De2NebnBzyASwYuh5D3P4TMlUeuX8VcPYMkpCu2WIyztHL
Pg1WUYA8lFA3IzDBefSPn93Au6l+1sxG4czLVI+zOD2HOsuvnNScEHldioOEwFni
vPwkfOxk0D7zJqWbGtksGIkEfpxWP0atlDCpQXbMVtRYzsiA5+Q=
=ZGPN
-----END PGP SIGNATURE-----

--nbdmosmxbine5fy7--
