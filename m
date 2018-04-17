Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbeDQIGW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 04:06:22 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:59886 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeDQIGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 04:06:16 -0400
X-Auth-Info: vm/B6Vy17TRBm/p/lVkG7anlYgrCqShqSbVXrpm60+Q=
Date: Tue, 17 Apr 2018 10:06:03 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] doc: Add vendor prefix for Kaohsiung
Message-ID: <20180417100603.0f5bad79@jawa>
In-Reply-To: <20180416192341.4fhy674fprei3zlu@rob-hp-laptop>
References: <20180412143401.6433-1-lukma@denx.de>
        <20180416192341.4fhy674fprei3zlu@rob-hp-laptop>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bOZ/b9ubSbqTA+mftvzW_0R"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bOZ/b9ubSbqTA+mftvzW_0R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

> On Thu, Apr 12, 2018 at 04:34:01PM +0200, Lukasz Majewski wrote:
> > The 'kao' entry has been added to vendor-prefixes.txt to indicate
> > products from Kaohsiung Opto-Electronics Inc. =20
>=20
> kao or...
>=20
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > b/Documentation/devicetree/bindings/vendor-prefixes.txt index
> > 8ff7eadc8bef..f995a876d2cc 100644 ---
> > a/Documentation/devicetree/bindings/vendor-prefixes.txt +++
> > b/Documentation/devicetree/bindings/vendor-prefixes.txt @@ -184,6
> > +184,7 @@ khadas	Khadas kiebackpeter    Kieback & Peter GmbH
> >  kinetic Kinetic Technologies
> >  kingnovel	Kingnovel Technology Co., Ltd.
> > +koe	Kaohsiung Opto-Electronics Inc. =20
>=20
> koe?

Ach... typo. This should be koe. I will fix this in v2.

>=20
> >  kosagi	Sutajio Ko-Usagi PTE Ltd.
> >  kyo	Kyocera Corporation
> >  lacie	LaCie
> > --=20
> > 2.11.0
> >  =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/bOZ/b9ubSbqTA+mftvzW_0R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlrVqusACgkQAR8vZIA0
zr24GQf/QIxcpYk+Svo6Wsqo4zMdsrbj1vuz28hJjIsWKgO3lWFvliHNdFnhvxUE
pVrhZ7RD64yTDg57Ex1SxN9vEkEMXYsIIoAeRMFfRhs26lBqOy5r3DBcyJMguKdp
u93nYkS2vBMIZiid//m2h0P94FSu756mXy0bGsIOaXuxEfJ+qr3c7ANaxcG4jQpq
4fu6IK+ko1Ewcn6S3YoQyKrrI8bjih9YysAkDWQOhZUJAA2YwStFfjFsXMZGP+iE
obgWnn0p8PfrPxXhciBBBPYkrTIelEr0JJbsBjDN7CQYnklfOQnd4x+1UzfLhpUF
Rk0lV7Bzextl8by7Vqwi4+PqN8qaDQ==
=izwO
-----END PGP SIGNATURE-----

--Sig_/bOZ/b9ubSbqTA+mftvzW_0R--
