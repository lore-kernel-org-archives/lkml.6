Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754032AbeDYLNZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 07:13:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50260 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753882AbeDYLNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 07:13:21 -0400
Date: Wed, 25 Apr 2018 12:13:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: linux-arm-kernel@lists.infradead.org,
        Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi@googlegroups.com, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 2/3] regulator: add support for SY8106A regulator
Message-ID: <20180425111313.GD24769@sirena.org.uk>
References: <20180423144657.63264-1-icenowy@aosc.io>
 <20180423144657.63264-3-icenowy@aosc.io>
 <20180424170733.GD22073@sirena.org.uk>
 <C0C1F042-221A-420F-A8C1-5FADCFC687F1@aosc.io>
 <20180425105309.GC24769@sirena.org.uk>
 <15C93A9B-6EEB-49EB-A942-35F761E86569@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
In-Reply-To: <15C93A9B-6EEB-49EB-A942-35F761E86569@aosc.io>
X-Cookie: MS-DOS must die!
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 06:55:10PM +0800, Icenowy Zheng wrote:
> =E4=BA=8E 2018=E5=B9=B44=E6=9C=8825=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=88=
6:53:09, Mark Brown <broonie@kernel.org> =E5=86=99=E5=88=B0:

> >> SPDX identifier is special -- it should be in a seperated
> >> comment block.

> >No, it just needs to be a C++ comment on the first line to ease machine
> >parsing.  The rest of the file doesn't matter for that.

> Okay. Thus I will use a seperate /* */ block for it in the
> next revision, to follow the rule.

Just make the whole copyright block a C++ comment.  It's much easier and
even with a blank line between the SPDX line and the rest of it it'll
still look messy and odd.

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrgYsgACgkQJNaLcl1U
h9Ak3wf9GZtm/4mnEWPn9EQiK6adnyQX1tR7KYDwhWjs1mrQl1WZO7/1fF9GIu4v
8w54QoveWz8Mj5ivVT1Z12qY4A+HM3R2Swi4HIHhvlixemolTuZ+74LUk+tdqW6B
hmCSC/WGV7G8WhBJDSQDB3jNJ47rxCsxkbwhU8pjeu6RJDf3WuE9ebaFh6Q3oQkT
PucMnQyogGuSFU+sTyIy1iVl98gXTuAyuEgNF2KTjdWPQTBssw0Pb2Uuz6JHeZr0
QvwVVpdx5L1ga9yakqew1Ld/JfoU7rRGyYUy86ijK+JkFqWpIcfVeweNL1liMsmm
iTX8Jlq6AuiaFhznDPuQLOIf4wmM1Q==
=sftl
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
