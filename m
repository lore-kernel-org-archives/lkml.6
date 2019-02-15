Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94301C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DCA72192D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbfBOGwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 01:52:49 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:37402 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfBOGwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 01:52:49 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4413qF2znJz1rQFD;
        Fri, 15 Feb 2019 07:52:41 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4413qD6Tl9z1qqkH;
        Fri, 15 Feb 2019 07:52:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id tjRFJW3Ct3kA; Fri, 15 Feb 2019 07:52:37 +0100 (CET)
X-Auth-Info: Vpbwe2tPG+Hx3nIR10noq9TTRB9awLl2ujuENhCrhM0=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 15 Feb 2019 07:52:37 +0100 (CET)
Date:   Fri, 15 Feb 2019 07:52:26 +0100
From:   Lukasz Majewski <lukma@denx.de>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Biju Das <biju.das@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Michal =?UTF-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ebiharaml@si-linux.co.jp" <ebiharaml@si-linux.co.jp>
Subject: Re: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Linux.
Message-ID: <20190215075226.413d55dc@jawa>
In-Reply-To: <TY1PR01MB1770A46D7FA45A8AFA923DADC0670@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
        <1547663874-29411-2-git-send-email-fabrizio.castro@bp.renesas.com>
        <TY1PR01MB1770A46D7FA45A8AFA923DADC0670@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wj+P4vAPcNRdVV5g/G=RD.I"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wj+P4vAPcNRdVV5g/G=RD.I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Fabrizio,

The best approach is to run:

git format patch -1 <your patch sha>

And then=20

scripts/get_maintainer.pl 0001-xxxxxxx

You shall see the the list of people to send the patch.

> Dear All,
>=20
> Who is the best person for taking this patch?
>=20
> Thanks,
> Fab
>=20
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Sent: 16 January 2019 18:38
> > Subject: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon
> > Linux.
> >
> > From: Biju Das <biju.das@bp.renesas.com>
> >
> > Add Silicon Linux to the list of devicetree vendor prefixes.
> >
> > Website: http://www.si-linux.co.jp
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > b/Documentation/devicetree/bindings/vendor-prefixes.txt index
> > 4b1a2a8..02a7037 100644 ---
> > a/Documentation/devicetree/bindings/vendor-prefixes.txt +++
> > b/Documentation/devicetree/bindings/vendor-prefixes.txt @@ -344,6
> > +344,7 @@ sgxSGX Sensortech sharpSharp Corporation
> >  shimafujiShimafuji Electric, Inc.
> >  si-enSi-En Technology Ltd.
> > +si-linuxSilicon Linux Corporation
> >  sifiveSiFive, Inc.
> >  sigmaSigma Designs, Inc.
> >  siiSeiko Instruments, Inc.
> > --
> > 2.7.4 =20
>=20
>=20
>=20
> Renesas Electronics Europe GmbH,Geschaeftsfuehrer/President : Michael
> Hannawald, Sitz der Gesellschaft/Registered office: Duesseldorf,
> Arcadiastrasse 10, 40472 Duesseldorf,
> Germany,Handelsregister/Commercial Register: Duesseldorf, HRB 3708
> USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WEEE
> reg. no.: DE 14978647




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/wj+P4vAPcNRdVV5g/G=RD.I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlxmYaoACgkQAR8vZIA0
zr2TBQf9FXaGvyW4v5bMvAdUNoZNE+ofxBnDxKYg4GSPwr7GQ/A9uaCmjz0ULGJa
jdmEvYzePHkM4dNgf4nfRWdoPmpgYxGANf3P8NrlVFAxKwFhrG2m5OyS9sfIPgYJ
4BHBKTwfl+zECtrCkeELyYzN7rG9Ftg+hdfjZ+Nw0uLibKy82tYSRUlSLzIYPyI0
J7MHBxuSDUejbZfCCkzDt6dSBTGqT7Z2qiy46v14XZUn1vztviV23Wv1y/0Sqopk
pdysD0NkYQILSRn8oqId5CPo5egHuwb23lF9xZTstuUv+sc/25t15wEvFZfj8Lt4
52IQuLZfwZV07TeE6+msv9vRFuEQgA==
=JQsx
-----END PGP SIGNATURE-----

--Sig_/wj+P4vAPcNRdVV5g/G=RD.I--
