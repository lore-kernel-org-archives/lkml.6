Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1303C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764722087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 12:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbfBDMw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 07:52:56 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:41484 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfBDMwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 07:52:55 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43tSKv6pGtz1rVvW;
        Mon,  4 Feb 2019 13:52:51 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43tSKv5rVkz1rVwZ;
        Mon,  4 Feb 2019 13:52:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Dyv-WNvR6vCU; Mon,  4 Feb 2019 13:52:50 +0100 (CET)
X-Auth-Info: 6zDkxgZOziFuJiml0VipMCH66G9Tb0Xv4QmhCbl5JE0=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon,  4 Feb 2019 13:52:50 +0100 (CET)
Date:   Mon, 4 Feb 2019 13:52:42 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH v5] ARM: dspi: Provide support for DSPI slave mode
 operation (Vybryd vf610)
Message-ID: <20190204135242.7112d48c@jawa>
In-Reply-To: <20190204105737.GE23441@sirena.org.uk>
References: <20180927150709.17010-1-lukma@denx.de>
        <20190109082644.14941-1-lukma@denx.de>
        <20190204113001.77d59570@jawa>
        <20190204105737.GE23441@sirena.org.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/F.zUuRU1SQQ7HjrB2HRAYut"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F.zUuRU1SQQ7HjrB2HRAYut
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> On Mon, Feb 04, 2019 at 11:30:01AM +0100, Lukasz Majewski wrote:
>=20
> > Is there any interest in adding new code (or fixes) to VF610 ?  =20
>=20
> You've been sending ARM: patches to me (the SPI maintainer) and one of
> the DT maintainers.=20
> You need to send patches for that platform to the
> relevant platform maintainers, I only maintain drivers/spi (and some
> other subsystems).  Similarly the DT maintainers only maintain the
> generic devicetree stuff (but apply relatively few patches directly).
>=20
> Please see submitting-patches.rst for details.

https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
Point 5):

git format-patch -1 e26e01ac03aae6cf296e7b4de47354d3151b21e7
0001-ARM-dspi-Provide-support-for-DSPI-slave-mode-operati.patch

./scripts/get_maintainer.pl
0001-ARM-dspi-Provide-support-for-DSPI-slave-mode-operati.patch Mark
Brown <broonie@kernel.org> (maintainer:SPI SUBSYSTEM)
linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

Moreover, I've CC'ed developers (Esben, Andrey, Martin) involved in the
changes for previous work done in this file/driver.

And those changes are solely related to SPI work in this driver, no ARM
Vybrid.

What else shall I do?


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/F.zUuRU1SQQ7HjrB2HRAYut
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlxYNZoACgkQAR8vZIA0
zr1NRgf8CH5Sc12KgowOsWlBhD7ixLeZAihKwP/LV7loEyTPoavCSahgCd9u6Au3
g2V9AHmew5s8j1eFmEixI7dXZHBBXL0j24DaH4dMJCBUQ5POfqz1cXOBgxo2/V+p
fc+QJkNlH5p8kmxDwmjO+yyvGVNpjAo6MZTvQU2UBiCVh793YqlodOQMajX5AYnK
uawizR9WcwIN9644Dj1RcRkYi5dF0NGWiRxl56cn1PdD5L6b3Fgp1l/evfy0c16Z
GbCXLUwl24RpUdsYxwVvdN9jPuXvytWXrl0ZRLfHl2TxNgT69PSvo8//H4GlHxA3
zc1zHhDy162j2S56jIq0B6M+VyDspg==
=oXFs
-----END PGP SIGNATURE-----

--Sig_/F.zUuRU1SQQ7HjrB2HRAYut--
