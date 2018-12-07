Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221B8C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA32720838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:29:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA32720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeLGJ35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:29:57 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:52522 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLGJ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:29:57 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43B6cx36Fjz1qxJg;
        Fri,  7 Dec 2018 10:29:53 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43B6cx1SX8z1qtf5;
        Fri,  7 Dec 2018 10:29:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id pUj3_NZ6NVJ5; Fri,  7 Dec 2018 10:29:51 +0100 (CET)
X-Auth-Info: NN4zlPuwTyG8aFRdCNLD3bu84PYxG0DVoWzQqiRsrkI=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri,  7 Dec 2018 10:29:51 +0100 (CET)
Date:   Fri, 7 Dec 2018 10:29:50 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH v3] ARM: dts: Add support for Liebherr's BK4 device
 (vf610 based)
Message-ID: <20181207102950.68796cf0@jawa>
In-Reply-To: <CAOMZO5CUfN7uLf7bsw6Xg4+TNrRYodw11Ekg5ypqyXU6q-UFtg@mail.gmail.com>
References: <20180921152726.31742-1-lukma@denx.de>
        <20181009105028.17971-1-lukma@denx.de>
        <CAOMZO5BN5KJ+s6F9CJXQPX=Ta0Ow0PaV_AmFHYSDNr78jLjziQ@mail.gmail.com>
        <20181206092255.2359f7e6@jawa>
        <CAOMZO5CE2ei-Pu-85zpYHTg-MamMT3DahLxBHNFjX4uLEi1XWg@mail.gmail.com>
        <20181206140840.53d49cd6@jawa>
        <CAOMZO5CUfN7uLf7bsw6Xg4+TNrRYodw11Ekg5ypqyXU6q-UFtg@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eOd0DIfTyV7kvaKrSrv+R8x"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eOd0DIfTyV7kvaKrSrv+R8x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Thu, Dec 6, 2018 at 11:08 AM Lukasz Majewski <lukma@denx.de> wrote:
>=20
> > I will check this latter this week... =20
>=20
> Reading the spi dt-binding it states that the spi slave node is
> optional.
>=20
> If I remove it like this, then the warning is gone:

Unfortunately, the "slave" node is necessary - the "lwn,bk4" compatible
causes the spidev driver to be bound.=20

Use space applications on this system use it to perform SPI
transmission.

IMHO, removing the node is not a solution - we shall discover why on
current next we do see such errors.

>=20
> --- a/arch/arm/boot/dts/vf610-bk4.dts
> +++ b/arch/arm/boot/dts/vf610-bk4.dts
> @@ -109,12 +109,6 @@
>         bus-num =3D <3>;
>         status =3D "okay";
>         spi-slave;
> -
> -       slave@0 {
> -               compatible =3D "lwn,bk4";
> -               spi-max-frequency =3D <30000000>;
> -               reg =3D <0>;
> -       };
>  };
>=20
>  &edma0 {
>=20
> Does spi slave still work without it?


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/eOd0DIfTyV7kvaKrSrv+R8x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlwKPY4ACgkQAR8vZIA0
zr2RUgf/YnEIV68dKxAVESsSbAZT8jOZkqAz/boXBXrfzYkXZRBbygWJwH0DpW1Y
KXADq+lujl2DIWo+Ip4usgcOoRteRv8yTzJEGGzN8Xkpufm10l9+bheJr2vJDF0q
vmwdpFqhd5zo5L9gJBkQDh06GD10zTVWjN+FdvivEw5b8Je04HZtbqyDAirPB4FH
kRxRZjxSAQHEEoU3tkzjCxG/36qt44ZXJwmP62L/qOYzPdO82UpCXQAlQlOhXzO4
aXSMf/BmM0i9M5LfCNRZw6isYM7diTVZnkhtVI0OcBKeNpqZSGEcEO8B9eQyOeml
bksQDEKef00es8wxCu3IpG5ezd9VlQ==
=weB6
-----END PGP SIGNATURE-----

--Sig_/eOd0DIfTyV7kvaKrSrv+R8x--
