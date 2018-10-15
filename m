Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7CCC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F69205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:23:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F69205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJPFKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:10:50 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40066 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbeJPFKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:10:49 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42Yrz66ZCxz1qtXt;
        Mon, 15 Oct 2018 23:23:46 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42Yrz65PM7z1qr2D;
        Mon, 15 Oct 2018 23:23:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id kHnr3yz34TSt; Mon, 15 Oct 2018 23:23:45 +0200 (CEST)
X-Auth-Info: sg+o82iT9jNDNDrbj7cSWpyuqESjJvepf2VH4dA6eGQ=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 15 Oct 2018 23:23:45 +0200 (CEST)
Date:   Mon, 15 Oct 2018 23:23:36 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: misc: bk4: Add device tree binding for
 Liebherr's BK4 SPI bus
Message-ID: <20181015232336.643bc335@jawa>
In-Reply-To: <20181015184627.GA23207@bogus>
References: <20180927222655.24482-1-lukma@denx.de>
        <20181015184627.GA23207@bogus>
Organization: denx.de
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ZDwnx6VQnqDQV5rlWtg4MGN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZDwnx6VQnqDQV5rlWtg4MGN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi All,

> On Fri, Sep 28, 2018 at 12:26:55AM +0200, Lukasz Majewski wrote:
> > Add Device Tree binding document for Liebherr's BK4 external SPI
> > bus.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  Documentation/devicetree/bindings/misc/lwn-bk4.txt | 26
> > ++++++++++++++++++++++ 1 file changed, 26 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/misc/lwn-bk4.txt =20
>=20
> Applied.
>=20
> To add to Mark's comments, the status of binding patches can be
> checked on patchwork[1]. There's no reason for pings to me. If it is
> in the "New" state, I will get to it and you can see where you are in
> the queue. ATM, I'm rather backed up.

Thanks for explanation and the hint regarding patchwork usage.

>=20
> Rob
>=20
> [1] https://patchwork.ozlabs.org/project/devicetree-bindings/list/




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/ZDwnx6VQnqDQV5rlWtg4MGN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlvFBVkACgkQAR8vZIA0
zr3FtAf/Zqj1ranCIlnjxXEXUDqaRNK14K20ruEPU9okXaFrg4JPq9Gfc9Tzh6py
15c+xzytkaxgwyQb3kYvIrzpzA/seA1k1m7ZaAlRxUf8OAbCpoJbql8efROpdToa
BZbKONSY9tRw6GIVJbUk+LbCEtp3NVOFacBh7EecZNR3iFtISaBRbJQu7+6d/Q7H
rX6GZoGSuimYyeldIb4AXxBytvoU+SNP74tlsB0/RuVEYNKMQBSSAG6ElxIeahVK
RJT3tkmIx0qVK+rR0321M0IxvPAKxLgZhTRk9Y0JSBmffKD/mnoCmTQ8p4w5yNd4
p321VOatU0Qsj+lUnZ/cqHc6FLIdjg==
=/EYV
-----END PGP SIGNATURE-----

--Sig_/ZDwnx6VQnqDQV5rlWtg4MGN--
