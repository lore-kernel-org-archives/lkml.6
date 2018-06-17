Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B468DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 07:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1652086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 07:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1652086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932505AbeFQHb5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 03:31:57 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:33362 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932171AbeFQHb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 03:31:56 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 417mBZ3dpsz1qtFb;
        Sun, 17 Jun 2018 09:31:50 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 417mBZ1NJ1z1qqkL;
        Sun, 17 Jun 2018 09:31:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 33A_w8dqVFSh; Sun, 17 Jun 2018 09:31:48 +0200 (CEST)
X-Auth-Info: rGbmAQQv8jubLwfhJ006XdPvRigHawc5KDPKSuvZk2o=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun, 17 Jun 2018 09:31:48 +0200 (CEST)
Date:   Sun, 17 Jun 2018 09:31:38 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] ARM: DTS: imx53: Add support for imx53 HSC/DDC
 boards from K+P
Message-ID: <20180617093138.30e925ee@jawa>
In-Reply-To: <20180617065700.GK16091@dragon>
References: <20180509153428.1440-1-lukma@denx.de>
        <20180612133208.22458-1-lukma@denx.de>
        <20180617065700.GK16091@dragon>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qly1ALCncSw=Pt=pAqzhvf_"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qly1ALCncSw=Pt=pAqzhvf_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

> On Tue, Jun 12, 2018 at 03:32:08PM +0200, Lukasz Majewski wrote:
> > This commit provides support for HSC and DDC boards from
> > Kieback&Peter GmbH vendor.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com> =20
>=20
> "ARM: dts: ..." for prefix.  I fixed it up and applied the patch.
>=20
> Shawn

Thanks :-)


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/qly1ALCncSw=Pt=pAqzhvf_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlsmDlsACgkQAR8vZIA0
zr0d7wgAlYr6gc1pFHoexpAGECIN+48cykmtLkPMCgjybGvDSEKhoGyT1KhcGXCK
I6ph0jiVRi8gcGow2xZXw/fPytH27bpiGfs7GwziB97QMJix70AmrwYylSks8usI
mv9lCqv1Jcf7u8wS0SF9z6eB673H5c/VCTcF8adVyBW34Uji2/YZG4yDfWitaAd8
S7J4OLRDrSsqwg+JENwi3RWtHCGtVzjsPdWGOC/AYOyxZ9f6c5M3mooz6TxFIjE1
ZjfqvWtHwOcgH6dkqCIgTzXP1bGQyhrBK/oJSalGdBAEbYzLdUlk52yPJHs2R0T3
A3/LNIGM0lRt1k6+yZEP3AZjjGNDpw==
=gGpO
-----END PGP SIGNATURE-----

--Sig_/qly1ALCncSw=Pt=pAqzhvf_--
