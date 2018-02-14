Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967197AbeBNKXQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:23:16 -0500
Received: from www.zeus03.de ([194.117.254.33]:54212 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967071AbeBNKXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:23:14 -0500
Date: Wed, 14 Feb 2018 11:23:11 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Rich Felker <dalias@libc.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 00/16] mmc: tmio: another batch of TMIO MMC fixes and
 cleanups
Message-ID: <20180214102311.w7hfbnpfkecnjlkb@katana>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <CAPDyKFp3dPjsEeyrKAbW_duErCS+xYD0K8zhcRPCY65eRNtMqg@mail.gmail.com>
 <20180207191152.kvqrugblst2cko3c@ninjato>
 <CAPDyKFoxp7p0atQTV=PoQ7Bwt0fOs2aEq1KJHPtrq+zA3eFYgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="chnywmmjtoeycwvc"
Content-Disposition: inline
In-Reply-To: <CAPDyKFoxp7p0atQTV=PoQ7Bwt0fOs2aEq1KJHPtrq+zA3eFYgw@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--chnywmmjtoeycwvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> You need to check again. :-)

Seems like it. Sorry for the noise.

> I am eager to apply those patches you already have reviewed (to
> patch14), as those mostly seemed rather trivial and should be nice
> cleanups.
>=20
> Do you mind me going ahead, then you can continue and review/test the res=
t?

Yes, we can work incremently from there. I'll send patches if I discover
something unexpected.


--chnywmmjtoeycwvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqEDgsACgkQFA3kzBSg
KbaVOxAAnEIyy0lswAOLrIpsQ+2pdHoH9MoOE+lfqFoXg28YvNHF6YfWKA47gWoD
lmklgXxahFD/Dz07hngX21PF0kujg01iUC78nBNdXeN+pm1NIdipUahohuDQgRGj
Pac163PpS4CPjPLA7yRLz44pXg4LQsIratlR1O1Nnw8mRRFY7aRr42+r/1kBKdYY
LRehZe+7FoFgYAws224BNPOzvOX5n8Hg194c5rLRPif3EV21XQlc9tygG8A4bW6g
m86jriqDUEYeE1RCgqiRlyxDZqyLFqLzsAHXWrDLoDpFMgmnLAX7Uihi37N38mw7
SGjmZOHQnD5vtblop+rINnt5eZn3oevvgmQogwB0HasjjtwjOxUlARyNPicxrir8
SVt5A/fA+ix52owdXN+SH+D0T5biGJEO3vd6zWOxOiKLmmRp0vrBsGNHUyh/Mxeo
q+1kQ2OnsSxkZmyg4cYXYh2cHe3fYQb5DCj4oomraVLSzb+txk0dXc/RGwRArGQB
0W8sMIVWj1f46mQs/XYJkbyqQEe1CJQU+O6TNsS4We3vXyMQdBUSH6ow35ShcUlF
84I5u/K/q4ALhaRbVsKfs0jg4M7HOvUnflLJJlzhZAiOD59yXlUWI2Ttmxls/VsS
BIEIhEZ4bai8g9q4s1lr6AP4xcigtQJXytLhJIG+rrrUckuXrM8=
=AECR
-----END PGP SIGNATURE-----

--chnywmmjtoeycwvc--
