Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D02CC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0998E2156F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0998E2156F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeI0DtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:49:07 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:42623 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbeI0DtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:49:06 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42LB5r46sxz1qv3Q;
        Wed, 26 Sep 2018 23:34:08 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42LB5r27g2z1qqkS;
        Wed, 26 Sep 2018 23:34:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id q62fezgbOq1u; Wed, 26 Sep 2018 23:34:06 +0200 (CEST)
X-Auth-Info: soh5N9TX3ZDMEq2F4w4+ve27dxSSbkIfRkqywMd9zOc=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 26 Sep 2018 23:34:06 +0200 (CEST)
Date:   Wed, 26 Sep 2018 23:33:59 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: spi: Provide bindings for fsl dspi
 working in slave mode
Message-ID: <20180926233359.2ca0d344@jawa>
In-Reply-To: <CAMuHMdWWYvhGX+SmG+WuLJZAX6PdCSd0hzNqiNB1r_A+B6tbSA@mail.gmail.com>
References: <20180918093437.26799-1-lukma@denx.de>
        <20180918093437.26799-2-lukma@denx.de>
        <5baa1aee.1c69fb81.cc7c6.340b@mx.google.com>
        <20180926163212.17646e43@jawa>
        <CAMuHMdWWYvhGX+SmG+WuLJZAX6PdCSd0hzNqiNB1r_A+B6tbSA@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YPc5BhSZ8A/Cni0/zVR7toh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YPc5BhSZ8A/Cni0/zVR7toh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

> Hi Lukasz,
>=20
> On Wed, Sep 26, 2018 at 4:33 PM Lukasz Majewski <lukma@denx.de> wrote:
> > > On Tue, Sep 18, 2018 at 11:34:35AM +0200, Lukasz Majewski wrote: =20
> > > > This commit provides the description of new property:
> > > > "fsl,spi-slave-mode" which enables support for DSPI driver
> > > > working in slave mode.
> > > >
> > > > As the new compatible shall be used with SPI bus equipped with
> > > > master device a new "spidev" based node has been introduced to
> > > > avoid confusion.
> > > >
> > > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > > ---
> > > >  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 8
> > > > ++++++++ 1 file changed, 8 insertions(+)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > > > b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt index
> > > > 18eeafe359d8..b30af19a2bc5 100644 ---
> > > > a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt +++
> > > > b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt @@
> > > > -26,6 +26,7 @@ Optional SPI properties for slave nodes:
> > > >  - fsl,spi-sck-cs-delay: a delay in nanoseconds between stopping
> > > > the clock signal and deactivating chip select, at the end of a
> > > > transfer.
> > > >  - bus-num : the slave chip chipselect signal number.
> > > > +- fsl,spi-slave-mode: if present, controller runs in slave
> > > > mode. =20
> > >
> > > There's a standard property for this. =20
> >
> > I've just realised that there is "spi-slave" property in the
> > Documentation/devicetree/bindings/spi/spi-bus.txt
> >
> > I will convert the code to use it.
> > =20
> > > =20
> > > >
> > > >  Example:
> > > >
> > > > @@ -56,6 +57,13 @@ dspi0@4002c000 {
> > > >             fsl,spi-cs-sck-delay =3D <100>;
> > > >             fsl,spi-sck-cs-delay =3D <50>;
> > > >     };
> > > > +
> > > > +   spidev3@1 {
> > > > +           compatible =3D "fsl,vf610-dspi";
> > > > +           spi-max-frequency =3D <30000000>;
> > > > +           reg =3D <1>;
> > > > +           fsl,spi-slave-mode; =20
> > >
> > > This doesn't look right for how slave mode is described. =20
> >
> > You mean that I shall replace fsl,spi-slave-mode; with "spi-slave" ?
> >
> > Or is there any other issue with this code? =20
>=20
> According to Documentation/devicetree/bindings/spi/spi-bus.txt:
>   1. "spi-slave" should be a property of the controller node, not of
> the slave node,
>   2. the slave node should be called "slave", without unit address,
> and without "reg" property.

Thanks for clarification.

>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/YPc5BhSZ8A/Cni0/zVR7toh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlur+0cACgkQAR8vZIA0
zr3bjwgAsuYJZZ2Q8RQJosawxvqIMAiG7KLKjE6cIc9gPTY5QcpULYUM4mAa84wc
1AZqKHUO5MyrFd/OcrGLA758mf5f0AmV/h4dS2qJO7veFFZVfovgX0qpPBMvSbK5
Vm/TnG04009T8Cha047ioaVpSnljM5x4ztAXW0Takl76NxhwrLUvVkEN6xZwXtFj
TspzdBAHWUpywoT2xx/COR7ZU0rt8vr98COmnHWLdQ7G6WCDoO0WiUKIKJe6a9Eq
leXTRJzS0IdDUpa5Cb0KhcwuFCNUV+fYKp7P1puFJA+ljf4gfC5+4ZSxf3Zdos/I
RD3y3o3n+0N/dDNVPUdu4Lrsgmg0zw==
=r8ku
-----END PGP SIGNATURE-----

--Sig_/YPc5BhSZ8A/Cni0/zVR7toh--
