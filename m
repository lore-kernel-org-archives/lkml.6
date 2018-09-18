Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9672AECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C49C206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C49C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbeIRPOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 11:14:36 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:33611 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeIRPOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 11:14:36 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42Dyhj40GBz1qyLX;
        Tue, 18 Sep 2018 11:42:45 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42Dyhj36NTz1qr2b;
        Tue, 18 Sep 2018 11:42:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id C1JgGDB0FUqp; Tue, 18 Sep 2018 11:42:43 +0200 (CEST)
X-Auth-Info: Q4ymsop31JoIXRNKcTHMPoGvs5SafIWRSPAhi4wV6KQ=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 18 Sep 2018 11:42:43 +0200 (CEST)
Date:   Tue, 18 Sep 2018 11:42:33 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>, Esben Haabendal <eha@deif.com>,
        Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ARM: dspi: Provide slave mode support for Vybryd
 vf610
Message-ID: <20180918114233.0622399c@jawa>
In-Reply-To: <20180918093437.26799-1-lukma@denx.de>
References: <20180918093437.26799-1-lukma@denx.de>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vk1mDwG/8QNvqvfmzq9ddah"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vk1mDwG/8QNvqvfmzq9ddah
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear All,

By a mistake I've forgotten to add (to CC/TO) some developers who worked
on this driver before (they were not generated from get_maintainers.py
script).

I'm sending the notification now.

> This patch series provides support for DSPI slave mode operation.
> It tries to maximally reuse current DMA driver (including its
> limitations).
>=20
> For testing the spidev_test program has been used.
> Test script for this patch can be found here:
> https://github.com/lmajewski/tests-spi/blob/master/tests/spi/spi_tests.sh
>=20
> Lukasz Majewski (3):
>   dt-bindings: spi: Provide bindings for fsl dspi working in slave
> mode ARM: dspi: Provide per DSPI instance of the MCR register (SLAVE
> mode) ARM: dspi: Provide support for DSPI slave more operation (Vybryd
>     vf610)
>=20
>  .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  8 ++++
>  drivers/spi/spi-fsl-dspi.c                         | 54
> ++++++++++++++++------ 2 files changed, 49 insertions(+), 13
> deletions(-)
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/vk1mDwG/8QNvqvfmzq9ddah
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlugyIoACgkQAR8vZIA0
zr2iwwf+JDDXKnvZjSt3h5f4uCKBZ1g48uQLvdPZUdxvlryuUL9ZaXCjaxJ1nQMs
StKx8nZAQZlAV92Bgr7FdJXX+R7RDb9rRBRUUfKT5Fh1jZHAgMHUTibnyAC43UQO
0TAUMf1OTFuHUMLmfcgsoOTx3S2MnGGgOJP0vyrn8jkItEk5SVsQuBUAINbzQlNy
WKI24AQ3PP7NLv63JaGKMwNt049i66On8/RHyzL6uLvIGFMOi3lFGNKxy4FdvsAR
uG7iXfiHaHxv8kyqnVZL39bXqmzrK7xPKK78sSOAolHmbqq8BZTMdLd9Hawx2ohN
u+xZSjpW3uLA4VWGFlBbCq4yhhZypg==
=T+bD
-----END PGP SIGNATURE-----

--Sig_/vk1mDwG/8QNvqvfmzq9ddah--
