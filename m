Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C2CC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD4242086A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4242086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJOP6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 11:58:32 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:49738 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbeJOP6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 11:58:32 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42YWS95ZT6z1qwRL;
        Mon, 15 Oct 2018 10:14:17 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42YWS93nX2z1qr27;
        Mon, 15 Oct 2018 10:14:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 2mhmkdah7aHp; Mon, 15 Oct 2018 10:14:16 +0200 (CEST)
X-Auth-Info: eLsoengL1YTwV1aboCtMYpz6we6Mk8X9c2H8L0bT8Tg=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 15 Oct 2018 10:14:16 +0200 (CEST)
Date:   Mon, 15 Oct 2018 10:14:04 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH v3] ARM: dts: Add support for Liebherr's BK4 device
 (vf610 based)
Message-ID: <20181015101404.52643184@jawa>
In-Reply-To: <20181012004027.GB3587@dragon>
References: <20180921152726.31742-1-lukma@denx.de>
        <20181009105028.17971-1-lukma@denx.de>
        <20181012004027.GB3587@dragon>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fbOpQnBhotqXKQP4ozRLJAw"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fbOpQnBhotqXKQP4ozRLJAw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

> On Tue, Oct 09, 2018 at 12:50:28PM +0200, Lukasz Majewski wrote:
> > This commit adds DTS support for BK4 device from Liebherr. It
> > uses vf610 SoC from NXP.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> As v3 just incorporates a few minor improvements over v2, Stefan's
> review tag should really be carried.  I applied the patch with Stefan
> and Fabio's review tag added.=20

Thanks :-).

>=20
> Shawn




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/fbOpQnBhotqXKQP4ozRLJAw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlvETEwACgkQAR8vZIA0
zr0FCQgArh85P/37Uas5kQp4FPL8TmaEbbP0HxlTZtRXJvugcPKbsTGNp5oPXTIJ
NPCMBGrxmQqF8d8h9tkgEtbSMjQAHBQRhKoACYz9vszQc8YlVPCpN+xcrur+Wa9G
XwIp29SRz5KI5UrUsk561+BCSjchwOeWVcElMntgu/kGTbeWpugxyOKYs5NmexyN
KozEL5iV5NDg8yjtCtsKJHUjMgML8zpz4pNEuGk+xxWlPjAxRgDb3Y8RyrufjT1T
TYH8a7WD4zqWpbXYP6Qr3elFPQyzS9g0vPGd9XtK27AGN5KlZwice6ffEjP8nBpA
JCAjNmd7ZZs473EAzsc6sRaRlP9mNg==
=4/wT
-----END PGP SIGNATURE-----

--Sig_/fbOpQnBhotqXKQP4ozRLJAw--
