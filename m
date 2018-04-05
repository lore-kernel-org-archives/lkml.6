Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751506AbeDEOmq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:42:46 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:48186 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeDEOmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:42:44 -0400
X-Auth-Info: CiOP02em4dAjvEbPqs7urniMFAlUrSDsIV11FK7+Oow=
Date: Thu, 5 Apr 2018 16:42:32 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] ARM: dts: tpc: Device tree description of the iMX6Q
 TPC board
Message-ID: <20180405164134.5ae71ea9@jawa>
In-Reply-To: <CAOMZO5DHtvX64oseDFsLGiYmQPcb3thUrGeLxX8dgp69vUNZMg@mail.gmail.com>
References: <20180405070939.22245-1-lukma@denx.de>
        <CAOMZO5DHtvX64oseDFsLGiYmQPcb3thUrGeLxX8dgp69vUNZMg@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/TIacNO7LMssG4Z_oN2llEqO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TIacNO7LMssG4Z_oN2llEqO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Thu, Apr 5, 2018 at 4:09 AM, Lukasz Majewski <lukma@denx.de> wrote:
>=20
> > +       reg_audio: regulator-audio {
> > +               compatible =3D "regulator-fixed";
> > +               regulator-name =3D "sgtl5000-supply";
> > +               gpio =3D <&gpio6 31 GPIO_ACTIVE_HIGH>;
> > +               enable-active-high;
> > +               regulator-always-on;
> > +       }; =20
>=20
> sgtl5000 has 3 supplies: VDDD, VDDIO, VDDA.
>=20
> Which supply does this reg_audio supply to the chip?

It supplies none of the above. This regulator is needed to enable
amplifier output placed after sgtl5000 device.

>=20
> Can't you use any of the existing sgtl5000 regulator bindings to
> describe this supply?

As stated before - this supply enables the output of the amplifier.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/TIacNO7LMssG4Z_oN2llEqO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlrGNdgACgkQAR8vZIA0
zr0w/wgAsJt1lPSubFuoGe0c3+6cE/5LozTI/GFYzrspSaGsCIoh1phNWb2a89PN
5yYEJztErGuCtE742GPvL0167PHlYPd7As0VlofqPPI4Aro8z6qU5Dp98AxsPkQb
7O7+zhPCBuFL8q8bl/p66iqQl8O+SJm2p6apOnqBkMlMXqwq82CkwBMGLh8AUoUa
bXIhNBW0SHwAh18/Ggr+y6taXn1t6PV7aX0Mhvbshpkm99wsQFo3EDZH6tK2mAf/
JInxb4BJz+gaSUS304Um7G6Sk/qIaQ6IwsxZFd6rNUUYspbtalMsQdFJkHw6N3Go
+ohaMdTj+IydZ2TjtkwwHQG5LZnWFw==
=96D9
-----END PGP SIGNATURE-----

--Sig_/TIacNO7LMssG4Z_oN2llEqO--
