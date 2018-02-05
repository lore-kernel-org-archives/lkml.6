Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753018AbeBENj5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 08:39:57 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:55167 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752782AbeBENjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 08:39:48 -0500
Date: Mon, 5 Feb 2018 14:39:45 +0100
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/3] net: stmmac: dwmac-sun8i: drop V3s compatible and
 add V3 one
Message-ID: <20180205133945.ac3im2fu42evuxtb@flea>
References: <20180202180456.60378-1-icenowy@aosc.io>
 <20180202180456.60378-2-icenowy@aosc.io>
 <20180202221301.judzaafcu67h4c2v@flea.lan>
 <73B89FC1-9A58-4B08-80C0-971E1254CFD9@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fbximhq3eqkurhe3"
Content-Disposition: inline
In-Reply-To: <73B89FC1-9A58-4B08-80C0-971E1254CFD9@aosc.io>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fbximhq3eqkurhe3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 03, 2018 at 03:23:28PM +0800, Icenowy Zheng wrote:
> =E4=BA=8E 2018=E5=B9=B42=E6=9C=883=E6=97=A5 GMT+08:00 =E4=B8=8A=E5=8D=886=
:13:01, Maxime Ripard <maxime.ripard@bootlin.com> =E5=86=99=E5=88=B0:
> >On Sat, Feb 03, 2018 at 02:04:54AM +0800, Icenowy Zheng wrote:
> >> The V3s is just a differently packaged version of the V3 chip, which
> >has
> >> a MAC with the same capability with H3. The V3s just doesn't wire out
> >> the external MII/RMII/RGMII bus. (V3 wired out it).
> >>=20
> >> Drop the compatible string of V3s in the dwmac-sun8i driver, and add
> >a
> >> V3 compatible string, which has all capabilities.
> >>=20
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >
> >This breaks the DT ABI, so NAK.
>=20
> I have asked this at IRC.

One more reason why no one should ask questions like this on IRC.

> The V3s compatible string is never used in any mainline
> kernel, even not in any RC version.

$ git grep allwinner,sun8i-v3s-emac v4.15 | wc -l=20
5

It is there already, and the fact that we have or don't have a DT in
tree that use it doesn't matter. One could very well have written a DT
for it and never submitted it.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com

--fbximhq3eqkurhe3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlp4XqEACgkQ0rTAlCFN
r3QwBw//W5q/rro8AEMOTUSyT1Wa46DMFbR4Ga5CbFq90hggClkVaY5ws8LsBnjA
2mU1KMimjIumsvsQbIM6IL8uPVNi4YyS1PzdUQH1N5Nuwrl55XOxyx7KCFbsJnwg
7dbgVzwf6LGL6wkwoIXwgvdpkmGmm2A2oRY46T7q6Ny+n962tRF+2LoOYsy1oVbf
Z2JGL1t0vE2cDE6KK7ttn4gfGISTH7QM3IUY7+fCBegZoG8KOacQY4KYkhnI5z/U
kpRGMVodxSnu+TmZ1yXNxEQcg78NY+NKnhY5OGd5p7JRJ/Eq8XnEQcl9HJsKzdsu
QQfGbgY95C1MBvXnSukUxbE3PfGvVZd9ZD02o1CK7+ztsRyDl0JTN0efeH/Xc/On
OzOzqWOADkfZZUodAOG6tdQwaK5x5Bk98qxsXmXtP/e4W28Q345oXOZOp6qFkwYX
2UTsxOXXDkLuSuhCKpDU9hlDXFBJzDc8hD2uwIHa1igrlm5CcYxqskcrkBQnbY2u
hM1olJehFapuWILdxNpuWL+8p6/S9S1BHgyyMrq2IqOAGc1EFQflv63tVuSHvX7s
xK70jIZKrHwfzfwydozxGYbWERxaHDoPtVWnQHmqvD8Q8pCIQEV7PLIzjSbbZL2T
r/LVc/4Q5tTQV33si5Kle2VvZEW4A1fL1nrzKv6Hb7Y59c6pBh0=
=bw+O
-----END PGP SIGNATURE-----

--fbximhq3eqkurhe3--
