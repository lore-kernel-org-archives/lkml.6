Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF325C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFD720850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFD720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeLEQkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:40:15 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:38175 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLEQkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:40:15 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4394GN4jzyz1qwqW;
        Wed,  5 Dec 2018 17:40:12 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4394GN3yY6z1qqkc;
        Wed,  5 Dec 2018 17:40:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id cvHAHjcKQdw8; Wed,  5 Dec 2018 17:40:11 +0100 (CET)
X-Auth-Info: xGJCVNlhDAF4aOgyzEM4Q5QNTDar0kCVp367zsoigzk=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  5 Dec 2018 17:40:11 +0100 (CET)
Date:   Wed, 5 Dec 2018 17:40:04 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
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
Subject: Re: [PATCH] ARM: dts: Provide support for reading ID code from MVB
 device (BK4)
Message-ID: <20181205174004.71f54042@jawa>
In-Reply-To: <CAOMZO5AJPiexbvHUq+vsz5zz6gNwL3O1KJ9ka_XPFotac2Sb=A@mail.gmail.com>
References: <20181113121213.14296-1-lukma@denx.de>
        <20181126143619.GB31334@dragon>
        <20181203103333.111c2463@jawa>
        <CAOMZO5AJPiexbvHUq+vsz5zz6gNwL3O1KJ9ka_XPFotac2Sb=A@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/zBu5tezDSu05=agJwMr.Hrn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zBu5tezDSu05=agJwMr.Hrn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabio,

> Hi Lukasz,
>=20
> On Mon, Dec 3, 2018 at 7:33 AM Lukasz Majewski <lukma@denx.de> wrote:
>=20
> > > > +           72xx165@0 { =20
> > >
> > > Please use a generic name for the node. =20
> >
> > This is a bit tricky. =20
>=20
> What about using 'gpio@0' like described in
> Documentation/devicetree/bindings/gpio/gpio-pisosr.txt ?

Seems like a good idea. Thanks.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/zBu5tezDSu05=agJwMr.Hrn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlwH/2QACgkQAR8vZIA0
zr0WLwgAvK6HXDHE6u5f/QF28kmiVcuLqopfyHnLPnGs/EMn/jrcq0Mfpjn9FJ7/
hlmmga8W+4W6bMb7mrdEkfTRRkeORISNn1Y5VXXTnfqFrbRw74L/ooxWcAE+cu0t
KidkntQwMxr6msaLQUy/bJKSHKmDT5YF720dusi3B6lJccmiqckV/23X1v45qE2j
yJL65GpaD3Yyx7eHlYekbipj58GkUYE16s/SxOBr9AyhIkUxWr2ZvtoChohI5ZBp
Xq1uo8mFSqLKmY4Ane1PWQeh3K+6g1jtP5ySa8pNs/VK55xXpkQe/nDuIi5fDT3Y
rYNee+BQ2vaaMbh4O9Hq67GCcx1cRg==
=4+TV
-----END PGP SIGNATURE-----

--Sig_/zBu5tezDSu05=agJwMr.Hrn--
