Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B97C67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C236220832
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="CqjNKmq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C236220832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeJXTMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 15:12:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34062 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeJXTMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 15:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MuNNxvx+1+ZN+ze5op33G4It9NyJYyCb3PunQuF0V/0=; b=CqjNKmq2eXzcy+/EMzlNMUrjt
        EJ91kD66tg53Sy6weZ9Dbu0bHyenXbdiBplV1oG6r0zZVaPC/KfEUbnZFM8dANcTPjBMDWQW8K8Bf
        LtOH4IFF5RgqLViqVeaDfa6XGVG0VQ9dxEvactIqu40A82yLnrQf1F9F/gAOFTqhjcaNI=;
Received: from [185.7.230.213] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gFGem-00017F-L1; Wed, 24 Oct 2018 10:44:56 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 4394B440078; Wed, 24 Oct 2018 12:44:56 +0200 (CEST)
Date:   Wed, 24 Oct 2018 11:44:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Clark Wang <xiaoning.wang@nxp.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Han Xu <han.xu@nxp.com>
Subject: Re: [PATCH V2 4/5] spi: lpspi: enable runtime pm for lpspi
Message-ID: <20181024104456.GP2103@sirena.org.uk>
References: <20181024075617.19548-1-xiaoning.wang@nxp.com>
 <20181024075617.19548-4-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3bc47Eih9dS+biPM"
Content-Disposition: inline
In-Reply-To: <20181024075617.19548-4-xiaoning.wang@nxp.com>
X-Cookie: Piece of cake!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3bc47Eih9dS+biPM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 24, 2018 at 07:58:30AM +0000, Clark Wang wrote:

> Enable the runtime pm for lpspi module
>=20
> BuildInfo:
> 	- U-Boot 2018.03-imx_4.14.y
>=20
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Reviewed-by: Frank Li <frank.li@nxp.com>
> Signed-off-by: Xiaoning Wang <xiaoning.wang@nxp.com>

This looks like Han Xu wrote this patch, Frank Li reviewed it and then
you are sending it on but it doesn't say that you wrote it - is that
what's going on here?

--3bc47Eih9dS+biPM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvQTScACgkQJNaLcl1U
h9D93wf9EQUZ5MMqEsDkIYvm7eUCXUNGM8pdl50zZDEevyleUZ9+NvKjLwvG9HMo
MGPCi2a4nHQpbkc5nZ2GdVdnU0bGCRH/zcGUhvEobAvAN9ujtkqpTzj2hRa2GSlm
TzZoYe41UsI0g8IcgIMFovxKgBeYaQtRDeymm0U9lF/lgunEBc3VxD8P2qNxRpXh
9EqRzrR6mFPwrM64Byq7prNQ8GdqyWnTXFPZYxnX6mlXcxzRrY/uRoiySv5ZP4ct
1QqztSSTzj2ksAUtVaClkKa6ymh4kZ0Vhnv1AvQ06SVzDGS4Q+7lcW+fXNAfO2w2
lJ9kB9pNl3So7WMxneRu4NSdHZ5mDA==
=vlfN
-----END PGP SIGNATURE-----

--3bc47Eih9dS+biPM--
