Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754743AbeBGTcb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 14:32:31 -0500
Received: from sauhun.de ([88.99.104.3]:44362 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754320AbeBGTc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 14:32:29 -0500
Date: Wed, 7 Feb 2018 20:32:27 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 11/16] mmc: tmio: deprecate
 "toshiba,mmc-wrprotect-disable" DT property
Message-ID: <20180207193227.hu6cyh2e27dmrqwt@ninjato>
References: <1516206496-16612-1-git-send-email-yamada.masahiro@socionext.com>
 <1516206496-16612-12-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQUJw-fjuJO68Kvskn8BRYW3rZj4YMtbo-Oxfv7c=6Ggg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n64esxgg2ls3up2p"
Content-Disposition: inline
In-Reply-To: <CAK7LNAQUJw-fjuJO68Kvskn8BRYW3rZj4YMtbo-Oxfv7c=6Ggg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n64esxgg2ls3up2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 10:58:36AM +0900, Masahiro Yamada wrote:
> 2018-01-18 1:28 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> > This property is equivalent to "disable-wp" defined in
> > Documentation/devicetree/bindings/mmc/tmio_mmc.txt
>=20
> This is mistake.
>=20
> "disable-wp" is defined in
>=20
> Documentation/devicetree/bindings/mmc/mmc.txt

With that fixed:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--n64esxgg2ls3up2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlp7VEoACgkQFA3kzBSg
KbZ2MQ//cTK2L1RNvVTODkTz7P/XIz7dtmszlYSZXMagmYtqh1rW19FRPo40yo89
XL0DNLiXTgN0yEWv6178HBPe4QGASdxxpjIJBH5CT5/uQT2nX8C2VG0d+w82WESO
zwTshuqKfRDYWWFIII6FPu4YZZQT+Nk9pSBvAUR0l9MPrI7uSkrVdOCK/DpK60Jf
bkuXqvo3QmCI76Cz6cBAiF9lAM9d0mIFst247fH3Cvf0IE/elXkWej3elZiOgZVt
orqcdGZDBbCmGFx0OCUItl5o+Zb2wIefAG/lfk3ULPoajNAiHHgvjTKfoxWD7s3d
b1P/WT3Yx3VttVTOvIaUWOV6NXoOehFIVxiuufrzyUIuiM11s2VTHTa1PeyJf/L/
QTrnG67yvOhyKLtrQ4egaxF+NMKySbd3Wl7apAB3yMvz72t2gnrFm86W+WUHy5kY
2VuBxP4iDToRaQ+dqVLq+csnbOG83jf7O2jk3h6M0eIuULhRp+XcyqBfsMkhmaP1
OddjI5LBdU2oIMkVzXxo36JaNKgyWjJgHq1ztJ/nZGfL4KNckHTj0VRJgvftmiwa
vbr4FJ2/jy9H3pva0qLEcTuynk11jA0onZ+4uK2YBIvs3zJbai2YQyBUvVBDfCOJ
gKA5cI3mmZ/Is3zx8pL1L4egtK39eGmGo57oJ/KJpsK3FrgKavI=
=mKCt
-----END PGP SIGNATURE-----

--n64esxgg2ls3up2p--
