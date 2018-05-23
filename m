Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934912AbeEWWU0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 18:20:26 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:39037 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934666AbeEWWUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 18:20:22 -0400
X-Auth-Info: nEhTM1XWKMmdF+CupLZ2wd1Zg5NzVffKPEgynt8QJK8=
Date: Thu, 24 May 2018 00:18:33 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: DTS: imx53: Add support for imx53 HSC/DDC boards
 from K+P
Message-ID: <20180524001833.58b9b59d@jawa>
In-Reply-To: <CAOMZO5DoLwEmQz5BQHDLk8sBq7mDH_UxBjRA0RGKb+PunMYu-Q@mail.gmail.com>
References: <20180509153428.1440-1-lukma@denx.de>
        <CAOMZO5AexXNEGVoXa9K_GAm+aFLNRQOXOhF_SdKAjV1qmuD2nA@mail.gmail.com>
        <20180519140202.3449e3c1@jawa>
        <CAOMZO5DoLwEmQz5BQHDLk8sBq7mDH_UxBjRA0RGKb+PunMYu-Q@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//Jhrf4jMObQ6LFENPwbIPV1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//Jhrf4jMObQ6LFENPwbIPV1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Sat, May 19, 2018 at 9:02 AM, Lukasz Majewski <lukma@denx.de>
> wrote:
>=20
> > After removing imx53-kp-ddc and imx53-kp-common iomux subnodes I do
> > see following errors in the dmesg (v4.17-rc5):
> >
> > imx53-pinctrl 53fa8000.iomuxc: function 'iomuxc' not supported
> > imx53-pinctrl 53fa8000.iomuxc: invalid function iomuxc in map
> > table =20
>=20
> Could you please investigate this error?
>=20

Ok.

> I have just tried the following change on a imx53-qsb:
> http://code.bulix.org/ik01yu-339697

I've noticed that this is the "common" dtsi file:
imx53-qsb-common.dtsi

Is there any board inheriting it? Is it extending the iomux node with
its own code ?

>=20
> and it works as expected:
> # dmesg  | grep iomux
> [    0.100046] imx53-pinctrl 53fa8000.iomuxc: initialized IMX pinctrl
> driver




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_//Jhrf4jMObQ6LFENPwbIPV1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlsF6LwACgkQAR8vZIA0
zr20+gf+J2hrtfcLBfqnvvYkTZrGiMYqV6mhq7nE5vh0pxVezR1m0Uwv0iVZfeJL
i5ELl7IFgS73Mn9zdLoEug4pBB+xBCt8kPg2ixO8YbohaDS1+gviOcSflmLY8Hsj
9X7KMpKjjHQvlyF6uHGs38bLGbTysnk6E+Q+DBb6COReLpsLHequoQ5Aa63GTFVk
IMj/PEpCnS1279An3eNK4WhwLFn8OrTXzJL9vFzr3MSQCRE+Ix9I0ik2yB8AwUhE
CKpbpGvc3FZP/V3su73WLj1NhZBHwDNZQv1PBR6ntSuV9OEnjj3IqYkCDUtAtz8l
mZk2UC1PanoYhjlZvRc9StMf7b0I4Q==
=1ag9
-----END PGP SIGNATURE-----

--Sig_//Jhrf4jMObQ6LFENPwbIPV1--
