Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeC0JSi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:18:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38828 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750913AbeC0JSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:18:35 -0400
Date: Tue, 27 Mar 2018 11:18:23 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH 02/10] drm/sun4i: Disable YUV channel when using the
 frontend and set interlace
Message-ID: <20180327091823.sbmvvo4jsh3x7p4i@flea>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com>
 <20180321152904.22411-3-paul.kocialkowski@bootlin.com>
 <20180323095529.5nptn5achjt3esog@flea>
 <1522137643.1110.4.camel@bootlin.com>
 <20180327081731.he3lhnvqffuimsi5@flea>
 <1522140259.1110.43.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kc4leoetoyymc6x6"
Content-Disposition: inline
In-Reply-To: <1522140259.1110.43.camel@bootlin.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kc4leoetoyymc6x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 27, 2018 at 10:44:19AM +0200, Paul Kocialkowski wrote:
> > > Also, is interlacing actually used on any of the video outputs we
> > > support? Perhaps RGB?
> >
> > Composite would be a better guess :)
>=20
> Oh and I was wondering what CVBS was about. Now I know!
> It seems that we don't support it for now apparently, anyway.

What do you mean? We do support it.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--kc4leoetoyymc6x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlq6DF4ACgkQ0rTAlCFN
r3Rxng//cQ8Kjzt4O/OGhNJWRbzj1B6rCmEO/XcAPNS1Udkq3n3PfvqA+yfPNUzJ
z3yJCzHQ8nuk1pjDPzdgbOfm069qZhlc2PIEulWua2uko70O8AfRcLJ9hlKnlGsu
vX1VtBLGnWXogmp6AdfDMZMFgkvfTgRPz2lg/sMoWTaMQTjtsJubpPtWT7I6t+x4
iznY9Ib8bGUhHpnRCAQVt4WoY/xIxwbecqxPqsSYvXTJNR3nHLDJPWOuCX2AB9s4
Q+qStnTCHxc5W8I24q+kPUd75vo0Jzps5WmjT4+JoCVjcNhv1110zgSMFjHa8Mcq
e+8UNpMyNJrEN7BrAzj00TF2Brw+f3BZXnLPsUOjlTIO+qiByXML1Nn4jx1O/g97
YSAikJHsMy+0DCL2ZzsNtKJYV3Z1w7bBop7JHBTRAgHDDXUE7zsur5a49Iby0KB2
A3PRJibGr+KRefqTRgyGU3cSrqMnQxV2pWMUhs9c/4mBleOufVXbFQsntDS8W45c
qENUaDyTJ7INYg7GsYLToN5kIoUQIN7eKHl/SVXrM13+e1SpD/0f6DCxJEJthalH
AGMTrwiWV6ALuHYhOWroszZ8ko+lbcRPLxI4cgahqJ+/CTHQh6zhC+sCM0csDNNM
IZNtwLdKriQq4hbyATvuHC3JFParQw8YTChgtQMAHPawoTIBrw8=
=mcfG
-----END PGP SIGNATURE-----

--kc4leoetoyymc6x6--
