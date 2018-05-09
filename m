Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933755AbeEIHHo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 03:07:44 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46465 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756107AbeEIHHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 03:07:42 -0400
Date: Wed, 9 May 2018 09:07:40 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>,
        linux@armlinux.org.uk, wens@csie.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, robh+dt@kernel.org, horms@verge.net.au,
        geert@linux-m68k.org, magnus.damm@gmail.com, opendmb@gmail.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        clabbe.montjoie@gmail.com, quentin.schulz@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 00/12] Sunxi: Add SMP support on A83T
Message-ID: <20180509070740.x4nl7efu4ptw6c4d@flea>
References: <20180504190545.5114-1-mylene.josserand@bootlin.com>
 <20180508131914.6sy7cd6urnfg3tam@flea>
 <7491f58f-d24d-8f7c-c195-87d13457fd80@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nngtanzdsds3yhmc"
Content-Disposition: inline
In-Reply-To: <7491f58f-d24d-8f7c-c195-87d13457fd80@gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nngtanzdsds3yhmc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Tue, May 08, 2018 at 10:11:07AM -0700, Florian Fainelli wrote:
> On 05/08/2018 06:19 AM, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Fri, May 04, 2018 at 09:05:33PM +0200, Myl=E8ne Josserand wrote:
> >> Hello everyone,
> >>
> >> This is a V9 of my series that adds SMP support for Allwinner sun8i-a8=
3t.
> >> Based on sunxi's tree, sunxi/for-next branch.
> >> Depends on a patch from Doug Berger that allows to include the "cpu-ty=
pe"
> >> header on assembly files that I included in my series (patch 01).
> >=20
> > I applied the patches, with the remarks done by Russell on v8 fixed,
> > and the function sun8i_a83t_cntvoff_init made static.
>=20
> Did you push those patches to sunxi/linux.git yet? I would like to make
> sure I have the same copy of patch 1 since that is necessary for some of
> our Broadcom ARM SoCs for 4.18.

I forgot, I just did. I tested to merge the latest next tag though,
and it went fine without any conflicts, so I guess we're fine?

Maxime


--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--nngtanzdsds3yhmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrynjsACgkQ0rTAlCFN
r3TZwA/+NK/QgR7t6HLmZMEq9qrvkK1WGT5Usdqks7WV3BYxGueHfXZTl/YeYeMT
F8aaAC247CyictqQMz2slBcFzWTpMVAwYdxFUj+LJKGf2gPFmBZM0uMxbF3m/e/7
4h1AuspmmuHSR7xB/lVG207eckjXKla9J6DmJdQnau59HHdAQhD81LLD0xZiw+9Q
KJ8wrVxVSxEj/RxfUnrX/VWRcvGB/CWYlMt/2NyPx+dAPW7a7XNHbMIKhUnn/9gF
h14YPssTqbgC9FXlf/s6Sr1/uTI+I+ZjPxY5gCA2BcSKx8ig3DHQpADUMhUcmbF4
uu10XlsOImNpOiPB/LJnfV7zhTIHveE4nZgRMZFKqHuRsSce26Q7BdJK30BdUdZw
FH32W8FTwYz3F3FKufOfGZjj0h0vdLQ1CREOhys2G4COVHr+ELvkt+wMfOxd6NE6
u5OP8vHYMu091kpEF4ZASJSrf3tlUuW8rYtXzD6Ptxbcf2r3pvfaTrFq6IJpZSlg
GrfKCsRWnoXMnolz4kp7vIdS+GiCCnd8oYZFijjBVH4Xew2Jb+ud0bAwY3SWcvHT
3B9yKEadJibPYvwdzedEahCanH1PuCW9QLY3nwgKkcfvurROds2xzFvZv03Zd1IQ
fMpwqwDPbii9mNqw7c0HViq+v5ljiqQdxIaJNiO/NEG212ihi5U=
=vD5G
-----END PGP SIGNATURE-----

--nngtanzdsds3yhmc--
