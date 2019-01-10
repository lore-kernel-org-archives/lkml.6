Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F34C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D10B213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfAJXQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:16:08 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:42457 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbfAJXQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:16:06 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43bMLW0R5vz1qxF0;
        Fri, 11 Jan 2019 00:16:03 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43bMLW0460z1qqkk;
        Fri, 11 Jan 2019 00:16:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id BJeujJ5RqRYi; Fri, 11 Jan 2019 00:16:01 +0100 (CET)
X-Auth-Info: mcnnRA4dcIe58/drF+pQAtIErghM142Ytn+xxppGE5Y=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 11 Jan 2019 00:16:01 +0100 (CET)
Date:   Fri, 11 Jan 2019 00:15:59 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Shawn Guo <shawn.guo@linaro.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the imx-mxs tree
Message-ID: <20190111001559.12d91530@jawa>
In-Reply-To: <20190111095605.129a93a2@canb.auug.org.au>
References: <20190111093003.2f00829e@canb.auug.org.au>
        <20190111095605.129a93a2@canb.auug.org.au>
Organization: denx.de
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QVj=FuFKawjdAOpl/CuZ5sV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QVj=FuFKawjdAOpl/CuZ5sV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

> Hi all,
>=20
> On Fri, 11 Jan 2019 09:30:03 +1100 Stephen Rothwell
> <sfr@canb.auug.org.au> wrote:
> >
> > After merging the imx-mxs tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this: =20
>=20
> Actually this is only treated as a warning.

Thanks for the notification. I will look on that (soon).

>=20
> > arch/arm/boot/dts/vfxxx.dtsi:550.24-563.6: Warning
> > (spi_bus_bridge): /soc/aips-bus@40080000/spi@400ad000: incorrect
> > #address-cells for SPI bus also defined at
> > arch/arm/boot/dts/vf610-bk4.dts:130.8-142.3
> > arch/arm/boot/dts/vf610-bk4.dtb: Warning (spi_bus_reg): Failed
> > prerequisite 'spi_bus_bridge'
> >=20
> >=20
> > Caused by commit
> >=20
> >   cf91ce9696a0 ("ARM: dts: vf610-bk4: Provide support for reading
> > ID code from MVB device") =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/QVj=FuFKawjdAOpl/CuZ5sV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlw30jAACgkQAR8vZIA0
zr0xHgf/ZmcfVOGZ+UKqY3/XZ3n1aFmtRECfyNW0XZ20AXPaHU6ui0c71qA4XY6l
xCjhW0o4hmIWRLToZvKzTO+bUfj+3u68P9ABvHZXjlqP1ITa3dpi1ldtD8tzftH1
cX9WIjG3iEeet39ajUFziUI2lS2yVtJc7np2Pl3UpwMDnUiTTlhtbpYaJ2EXtWv4
6mLvS2ov6hPXz6FaN9nAKQy5f/uYNymlOIOkpnqmucWSxbGVU96bWre32p4sbs4G
1XPh1JPkpOjyrc6xrSbVQkaWWeqQQqxT9SPrBtEaRwK6vaJwToG39am9Nf31HbME
UzJSJa70Dd/pKNatBhaEcV+Mr3/h6A==
=6cAi
-----END PGP SIGNATURE-----

--Sig_/QVj=FuFKawjdAOpl/CuZ5sV--
