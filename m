Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97702C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5762054F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="bIGLi4cD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F5762054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbeH2TMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:12:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36314 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbeH2TMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/inR5By6OFUMZuoZPwhEZeBPZZMVYMW7NEHO+WVOSUg=; b=bIGLi4cDRCH2m0pS1WFXEby1l
        9cUA6mllb1zbd5bLhYGPKUbeIPDB3a+oIc6vDfUSgorc7fdfEN7pPw2+liC/tSzzwX/WKJ0+Rq0kz
        B13p3/QodvW6Cyk8ZvHECEkj3y1lj3l3QkVrIDAegXPAxEBXXd74DT0mK5RXu/sRG12ok=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fv2BS-0000RR-FS; Wed, 29 Aug 2018 15:15:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0BF1A112486B; Wed, 29 Aug 2018 16:15:02 +0100 (BST)
Date:   Wed, 29 Aug 2018 16:15:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [andriy.shevchenko@linux.intel.com: Re: [PATCH] spi: dw-mmio:
 add MSCC Jaguar2 support]
Message-ID: <20180829151501.GE27808@sirena.org.uk>
References: <20180829150955.GB7459@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZInfyf7laFu/Kiw7"
Content-Disposition: inline
In-Reply-To: <20180829150955.GB7459@smile.fi.intel.com>
X-Cookie: Not every question deserves an answer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZInfyf7laFu/Kiw7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2018 at 06:09:55PM +0300, Andy Shevchenko wrote:
> ----- Forwarded message from Andy Shevchenko <andriy.shevchenko@linux.int=
el.com> -----
>=20
> Date: Wed, 29 Aug 2018 18:08:31 +0300
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> To: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Subject: Re: [PATCH] spi: dw-mmio: add MSCC Jaguar2 support
> User-Agent: Mutt/1.10.1 (2018-07-13)
>=20
> On Wed, Aug 29, 2018 at 02:45:48PM +0200, Alexandre Belloni wrote:
> > Unfortunately, the Jaguar2 CPU_SYSTEM_CTRL register set has a different
> > layout than the Ocelot one. Handle that while keeping most of the code
> > common.
>=20
> > -#define OCELOT_IF_SI_OWNER_MASK			GENMASK(5, 4)
>=20
> > +			   0x3 << if_si_owner_offset,
>=20
> Perhaps,
>=20
> #define MSCC_IF_SI_OWNER_MASK		GENMASK(1, 0)

Oops, sorry - that seems to have been eaten somewhere.  :(

--ZInfyf7laFu/Kiw7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluGuHUACgkQJNaLcl1U
h9A3Wgf9FGUxQNQ9H6VkM/ASsULfuvIMMQP/kUf0mCRd/HvsxZaaS8AeWq74/xZW
EF1NoUrPIca/Gq+Xrrp6cOsKxIuQPorfne96wdJYuY0t5M6BogiWIxF5OIQuGjV1
EQIgDANDMI9SpYP8KYFMZ9+yc6Cp48F/UM6DUjtzKLAMw1NHAsosCwutZX7rCuoY
fKqOY14cwgzsDNCjIVPJjzbuxaW0zcKWY4cDmtZeytRuZpgVnp3nPtTxyvKwHURt
3k063gA7Y+x+pUbhCF8tolkCIUVc5y1wv64xQuaKB/t+VDiHL+rAQWpzPOCxF9aM
P5G2CcA0+J29YvyM5Go9Ghp1pGaSHg==
=bH0e
-----END PGP SIGNATURE-----

--ZInfyf7laFu/Kiw7--
