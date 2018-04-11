Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeDKHsL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 03:48:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42462 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbeDKHsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 03:48:10 -0400
Date: Wed, 11 Apr 2018 09:48:08 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH v3] ARM: sun8i: v40: enable USB host ports
 for Banana Pi M2 Berry
Message-ID: <20180411074808.eogpgm3xtercmnay@flea>
References: <20180406140344.9457-1-icenowy@aosc.io>
 <CAGb2v651vpy3jdFY56CQi4yBU1wh01ecPn9cO9fiXkfed35QDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="og4ex2vm244qbsln"
Content-Disposition: inline
In-Reply-To: <CAGb2v651vpy3jdFY56CQi4yBU1wh01ecPn9cO9fiXkfed35QDA@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--og4ex2vm244qbsln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 03:33:34PM +0800, Chen-Yu Tsai wrote:
> On Fri, Apr 6, 2018 at 10:03 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> > Banana Pi M2 Berry has an on-board USB Hub that provides 4 USB Type-A
> > ports, and it's connected to the USB1 port of the SoC.
> >
> > Enable it.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>=20
> Verified against public schematics.
>=20
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied for 4.18

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--og4ex2vm244qbsln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrNvbcACgkQ0rTAlCFN
r3SliQ/+JhWN4KcdyeTTPTNjOhhyahYrxL5nKTrln4HQBxlfTH/jqi5+18w77kR1
PAgzNwKGOy3+hshtp8memLDwjphqKHkrnflZxQTnPuBVbj8o+tkvDsvTGdKb0hbI
N5ya/AWZsIxPe8UxfiINs4ePX65NYKegeP+yIh/YDxGTqVYono4jjhv05hO+q7vc
W9EKeyYZmut1ZU4pN+EPm1y0KuI/zM1mXSLUwVq0oKGyVUbCyRwZ48vee7V8aSFo
UvZzF0J+/8lFRZBueGvnPO3INx/RL6e7KaBxFM0mKcTJqkY521cqtBMLrEq+Lz31
YgmEhe9WH+4VyDVlTJyxXC0+QqbWCQVIBp4EQA5gd7m4+PF67jRrFeYBaN5D3NYS
Motne9gLATmC9YWMhD1abftgcA1lQPYCRZpp7lsFELXK2P4tA4412MeC4iqXkPqf
v5VagfsiKyprBnWpjNDJN5VeFr2dteaDiLrfbqRp6vvwPWJk0LCYU+bKycohN40n
0gUPpB3zQvJRZm6G5/1nJPYqREcR4v5/NlkYP5T77qkHh/5qAgQQmJ5R7JuR8anb
rWukIZPoXqgGhVo2N12u0P2BKla+gWIwrK273w9r7uthkgN6v7kTciEKKKJEaeM0
NPHDldio1TKG07LyKCfcIQb2cM9PAOIikSsF8OpMLh0j1xWKN38=
=DHFh
-----END PGP SIGNATURE-----

--og4ex2vm244qbsln--
