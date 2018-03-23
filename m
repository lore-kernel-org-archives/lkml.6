Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeCWOZB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:25:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:40835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751687AbeCWOY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:24:58 -0400
Date: Fri, 23 Mar 2018 15:24:55 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/8] Move most GPIO documentation to driver-api/gpio/ and
 ReST
Message-ID: <20180323142455.laugwxxv2yeqwijd@latitude>
References: <20180308234024.24145-1-j.neuschaefer@gmx.net>
 <CACRpkdaCn2OnOW7GsiqeUffw4ajBo+Tw31KUyRcuLWvxx271sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yzo3z6vuofhimjuf"
Content-Disposition: inline
In-Reply-To: <CACRpkdaCn2OnOW7GsiqeUffw4ajBo+Tw31KUyRcuLWvxx271sA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K0:3RdUXcvXziJdskpMFEOj4s31nKRt0Y2A9VAIxQ+qdadfLbB4TMC
 DaBc2Ra1fPhzaWNZjkfVGw3b/chNdwR6UZLxHHs8oPnduttxmzms2RRqF+7ly+N+gW5Hy7E
 3t5HlvcvXjg7sLktAOULXLRwzTbNDM5Un7bJ7fsHEUht3HKlakKF2o2GVEHfOV0c5INPCR7
 KowAJFLEbwWPR3Qcg0BWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ikdPQM39lnI=:2SqsptrEQ+4PEaYWsAOxMo
 nWoy7clgJuhy7xy21QkcOdfUFtomfxVSqnq9PTymvzqXUqOjRYKfj334sGKPcTlB7M6uHpziY
 xdFMIC4vNqX2UiV2BiiRbCgdwZLZ9MkurbKa7YhAlMO0uLSWfDidl4zICE2Z8xBdLDkFC249h
 i11UtA4Fw97kpIRMBL2QZHM9wKhD2TBh0AsFDDq6y1TC3EOe09iSUcqbd7eEUVtQ0ABuGrI0p
 YmxQJCWGPtnIenqEAuS0pxVD1FP/HBpW0v9s6eZs+uRuUTLcZoFvS6oRkZ77M9fItE0gu30PR
 66kskpYZR6wEjINMnATQuFje31S06VJqDLnAzwm0XBgp2ytYB88CBVFbR5k3vAJkoFor7Coi9
 cFSVuSY4EqX+LjJS7HJmqFSP0YqR1LdfpkIY+HF1gDYMTtjyLGylJtGwaSyFIFWkP7J4rlYrB
 Xd1IbvfWBeLYN6OjeRJpjKV+rECZ8V9Gvg02i00spcuP5Yc1uf2UMF4b40QQHk8zFZAH2SwuG
 pRt4VYjJ/qDAtnueJdbwkh1OAzLh39++JqUGx7NauxTx/zwlT28wuJvKtc/t4eHtPLtuCRzq5
 hfF+d1wnD+ymoviDolCL4YkNOSKPx2AH0uIZsa9kRmR8eFHD0snF5zHriZ6sGRmjNWCQA8qsb
 /MMUs1R6UblD3E6O70sLCMVoQTedaMkX5lZXYKWWb/NLQ1nD50hDYT9MrqhrO+K6j4rUAnlVT
 7hmPvJWCfjSucSbgcax4W4X2jCVFdfeTFeD9ZHoaZCisZmruiBz/6CB+WDlsNawd6Rbflmy0O
 B2kOf2oB3tesxKKdOisPgG2IRNC0w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yzo3z6vuofhimjuf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2018 at 04:23:21AM +0100, Linus Walleij wrote:
> On Fri, Mar 9, 2018 at 12:40 AM, Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
>=20
> > Jonathan Neusch=C3=A4fer (8):
> >   MAINTAINERS: GPIO: Add Documentation/driver-api/gpio/
> >   Documentation: driver-api: Move gpio.rst to gpio/index.rst
> >   Documentation: gpio: Move introduction to driver-api
> >   Documentation: gpio: Move driver documentation to driver-api
> >   Documentation: gpio: Move legacy documentation to driver-api
> >   Documentation: gpio: Move gpiod_* consumer documentation to driver-api
> >   Documentation: gpio: Move GPIO mapping documentation to driver-api
> >   Documentation: gpio: Move drivers-on-gpio.txt to driver-api
>=20
> I applied all 8 patches to devel for v4.17.

Thanks!

Jonathan Neusch=C3=A4fer

--yzo3z6vuofhimjuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJatQ4wAAoJEAgwRJqO81/bKKoP+wRy+67X3Rps/BAXk8ITW4ul
ef5KuQZe680DSItJzekUCE3fDdGSm/hd0uvzH063cAUNEDTJfFeGENYNfmyiRP3K
GIbXocf+RCp5N3isQ0FIKS6FNRyoINbuirwWddCmPOdOWXb9B7B8FRGNUvU3xzEq
3glK/RfWp9/b69mXGWTz6cUQIhF1thUDG77GDolOHleCYp/8zfbI03WEU4y/7ExX
vLOwPeXrLgMcrLD3naf2pP7ZjwvsBM3God2dUcqbbRCFLwd/jKCSqjttVA1qnV2m
lfw7HS8OrTebQwkTC1A6o8ZLE0bbg7oiHOG1vP4yW2lUSTUJPs/0jnd30JDbmUJw
1kfxgFiEBZ3vTG6GgxyKGcFmz61D2PGhGCgKonZVYvCckmaX0d6/M/BTdN/nWkHm
sZpgGIUhBgXoSqseq1nDtZwBODUfAFKOK+++uey1Ioh1G4GnwWcMd15aEksiChpp
7ZehScTj0meitKDYVE2QdLquh7w8/MCdwCjkdtTEzxH0iB2YH8SOAUJSGL6UGQ3k
h1RCwKOVIYR6e4c1U36oe9SwvkSxk2aYvRCB9tlRfxOG+QysE4B8tNHeedgKfeGs
6nZz2CZ8cJpVHFefg96d/ykwavsDWUKwUgbAqdzkaKgk8HucHr/w6+f6YpSdXzYc
ebt0v1LOupCkBCh5Pssq
=i5jw
-----END PGP SIGNATURE-----

--yzo3z6vuofhimjuf--
