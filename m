Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B089C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF56221479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 10:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF56221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJIRhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 13:37:40 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:51784 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbeJIRhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 13:37:39 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42TtYb170Gz1qvpF;
        Tue,  9 Oct 2018 12:21:23 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42TtYb0MwJz1qtdw;
        Tue,  9 Oct 2018 12:21:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Ae7z3LHCDINz; Tue,  9 Oct 2018 12:21:21 +0200 (CEST)
X-Auth-Info: iQeUYJXmGvOGm0erLRhJYqUfVzCxqbUG3KKBpWADV5U=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  9 Oct 2018 12:21:21 +0200 (CEST)
Date:   Tue, 9 Oct 2018 12:21:14 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: misc: bk4: Add device tree binding for
 Liebherr's BK4 SPI bus
Message-ID: <20181009122114.39ff3553@jawa>
In-Reply-To: <20181008144350.GS3587@dragon>
References: <20180927222655.24482-1-lukma@denx.de>
        <20181008144350.GS3587@dragon>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/8gpAw4s9jZow/4LHh6SfTxs"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8gpAw4s9jZow/4LHh6SfTxs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

> On Fri, Sep 28, 2018 at 12:26:55AM +0200, Lukasz Majewski wrote:
> > Add Device Tree binding document for Liebherr's BK4 external SPI
> > bus.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
>=20
> There should really be a patch series consisting of this one and
> spidev change [1].
>=20
> Since spidev has already been picked up, having a series including
> this and dts change would be the second option.  With DT folks' ACK,
> I can send bindings change together with DTS using it.

Any option will work for me :-).

>=20
> Shawn
>=20
> [1] https://lkml.org/lkml/2018/9/28/48
>=20
> > ---
> >  Documentation/devicetree/bindings/misc/lwn-bk4.txt | 26
> > ++++++++++++++++++++++ 1 file changed, 26 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/misc/lwn-bk4.txt
> >=20
> > diff --git a/Documentation/devicetree/bindings/misc/lwn-bk4.txt
> > b/Documentation/devicetree/bindings/misc/lwn-bk4.txt new file mode
> > 100644 index 000000000000..d6a8c188c087
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/lwn-bk4.txt
> > @@ -0,0 +1,26 @@
> > +* Liebherr's BK4 controller external SPI
> > +
> > +A device which handles data acquisition from compatible industrial
> > +peripherals.
> > +The SPI is used for data and management purposes in both master and
> > +slave modes.
> > +
> > +Required properties:
> > +
> > +- compatible : Should be "lwn,bk4"
> > +
> > +Required SPI properties:
> > +
> > +- reg : Should be address of the device chip select within
> > +  the controller.
> > +
> > +- spi-max-frequency : Maximum SPI clocking speed of device in Hz,
> > should be
> > +  30MHz at most for the Liebherr's BK4 external bus.
> > +
> > +Example:
> > +
> > +spidev0: spi@0 {
> > +	compatible =3D "lwn,bk4";
> > +	spi-max-frequency =3D <30000000>;
> > +	reg =3D <0>;
> > +};
> > --=20
> > 2.11.0
> >  =20


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/8gpAw4s9jZow/4LHh6SfTxs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlu8gRoACgkQAR8vZIA0
zr2I5QgA1rwcD72qjO/pbSM/PriYIzhlokJ20Pg24TpC2BZeSl1ND2Dhi1yEHmxp
y40hF3+64nGuUlbJmAL+tPTBuO65xdBSTDXrhfIr5zCCwCOZXif+MphRg3n1NYBq
ep8iD8QWtjGC2IkxuBlK0az77vJgYg51JfBGywabJCBHwyFKCsMbBONn2xjjvciw
rLBIQTLHhGL/bhrhAjBOnY1nG37OWtjtD+Xk1s74BwtWwt1AWoUDcJM/jG+wuLPI
Xh24CaFFNdENg4ZhxwFyacRKfrloc8G8fDKXiaMhBLa3c/kx5qiIi1SJ5ZmF3yF/
KVPjbdDla/l2rjC87AkLnFjU0jj+PQ==
=RGBJ
-----END PGP SIGNATURE-----

--Sig_/8gpAw4s9jZow/4LHh6SfTxs--
