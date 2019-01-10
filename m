Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49197C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C1E218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="l4XXsrD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfAJRHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:07:45 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:38312 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbfAJRHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=scNwPhXPLsyx0PJdP8SiCDSozRa9MNPaFiu/trMl1ns=; b=l4XXsrD4nDhmcpfBFmO6iCt9I
        6x9x4BOem+JL6fr9aAUnM7PrwqJU8LFoVR10XuWtsVivOPkFurPdt1ld4B/a5IA4Ct7U6MgTiAMq1
        IchaW5u8UM/aW/lHTcfRNqnUIlQHDVQTZ8FmlZ8lHQNqkFTIDQlZGyUuRSaJmEajrwro4=;
Received: from p200300ccfbdcb9007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:fbdc:b900:7ee9:d3ff:fe1f:a246] helo=localhost)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1ghdnx-00022x-MQ; Thu, 10 Jan 2019 18:07:41 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1ghdnw-0007K4-Ns; Thu, 10 Jan 2019 18:07:40 +0100
Date:   Thu, 10 Jan 2019 18:07:32 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Johan Hovold <johan@kernel.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 5/5] dt-bindings: gnss: add lna-supply property
Message-ID: <20190110180732.75490757@kemnade.info>
In-Reply-To: <20190110122757.GB9725@localhost>
References: <20181209195150.5192-1-andreas@kemnade.info>
        <20181209195150.5192-6-andreas@kemnade.info>
        <20190110122757.GB9725@localhost>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/kogTsdgB3P=GJqkn3Pu7N.f"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kogTsdgB3P=GJqkn3Pu7N.f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Jan 2019 13:27:57 +0100
Johan Hovold <johan@kernel.org> wrote:

> On Sun, Dec 09, 2018 at 08:51:50PM +0100, Andreas Kemnade wrote:
> > Add lna-supply property.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > Changes in v2:
> >  - reordering
> > Original order had a
> > Reviewed-by: Rob Herring <robh@kernel.org>
> >=20
> >  Documentation/devicetree/bindings/gnss/sirfstar.txt | 1 +
> >  1 file changed, 1 insertion(+) =20
>=20
> Ah, missed this one at first.
>=20
> But shouldn't this go into the generic binding since it isn't specific
> for sirf-star based receivers?

That idea was formulated with a question mark towards Rob.
And no reaction from Rob about that.

Regards,
Andreas

--Sig_/kogTsdgB3P=GJqkn3Pu7N.f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAlw3e9QACgkQfb1qx03i
kyQJ8A//at4YsJK1yECSuQsCChA8HxdLQ/mCI4OESmDhNY2tEN1m36RPMh80SpXk
KVmtT+6NTnjn4xzw0jGPHVH1yaAN2/egT7UnyBpjsA5Xj/smLmKajQ2VTarMFs5x
5a4Q83f5NcDeVt03/0hnzbp7rdGp3BtHWiInBd8Fm18giY2BEFANnOLIyPMR1P/3
ZIf8uBnnJhM0vmrRklI6kvZLoAjnpOZPDXK6n7SLTKT7Io8WuavG9Im/xjm3no8o
/ko9aqE0wjf0fs/PDlYA8x59KVlLzd/2+0Bn6F0HN+kjYJomDgcmACMIvlj6bp39
8SDzzQWhU1nASmRaHKm1LnNabrla37N2Uaxa0DCwUhTyhuh5lcVHerNQQRTD1oX3
9mRcZIcJ4M+gKig287DgECHSpqWN3SIHSqSdnrze+BW2K8+/g1AbqJp4Z8HzGQSd
Gq4LbgImEgEHaekSY/CaqpE98Cs/LQVbeiAjqSyNoIhc8Tc7xOylQ01dN0C+F6dF
eOPF4Icxw226yzIk8mekzoxGrgA9kx+YVOjsiYEB643FFowggr3Doqg2LxGG3pnS
jAPclnnt6F7Xdy7G2ncrkQ2B/85G4D/K4kTVnTqmChLDopaV0H8BvGmVusudyIbp
zrNMeDaUjn1Q5/lWKWlZt/0gD3vDS18oUneu6CMqB99lhVSxJMQ=
=JKBw
-----END PGP SIGNATURE-----

--Sig_/kogTsdgB3P=GJqkn3Pu7N.f--
