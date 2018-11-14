Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3957C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2BD22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="HdxoHmo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2BD22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733143AbeKODf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:35:57 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40594 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbeKODf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WY+A2GSKNZKavc/OhxH9D+6/6aKTalIZNhXFi3IJzrY=; b=HdxoHmo6k9mt+AiRyi3krUrz1
        I6jT56/xrBHKhm97Dz7HLZ+PpvpvJNn2unc7W8wOUtF+IraR55xla/2IwqAFl+FWHvkp4fWAO2iBJ
        z4QRZk3Zu3gw7Fmw3Amw0d2yd6PUYv0IVORKcGyVq6o/bYKFxsmsHI0P0EBsjB1KfbYDY=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMz0q-00041z-B1; Wed, 14 Nov 2018 17:31:36 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 76057440078; Wed, 14 Nov 2018 17:31:29 +0000 (GMT)
Date:   Wed, 14 Nov 2018 09:31:29 -0800
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Adrien Charruel <adrien.charruel@devialet.com>
Subject: Re: [PATCH 1/2] ASoC: ak4118: Add support for AK4118 S/PDIF
 transceiver
Message-ID: <20181114173129.GY2089@sirena.org.uk>
References: <20181108124934.32381-1-peron.clem@gmail.com>
 <20181113225135.GQ2089@sirena.org.uk>
 <CAJiuCcewYbt4SDZfFzDfTfTzj_Z1cm=S3_GAA-zcYGW-jzXR4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="agGyne4gKHM29dDu"
Content-Disposition: inline
In-Reply-To: <CAJiuCcewYbt4SDZfFzDfTfTzj_Z1cm=S3_GAA-zcYGW-jzXR4w@mail.gmail.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--agGyne4gKHM29dDu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 14, 2018 at 11:55:17AM +0100, Cl=E9ment P=E9ron wrote:
> On Tue, 13 Nov 2018 at 23:51, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Nov 08, 2018 at 01:49:33PM +0100, Cl=E9ment P=E9ron wrote:

> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * ak4118.c  --  Asahi Kasei ALSA Soc Audio driver
> > > + *

> > Please make the entire comment a C++ one so this looks more intentional.

> I check from other files and also this article says :
> "For normal C source files, the string will be a comment using the
> "//" syntax; header files, instead, use traditional (/* */) comments
> for reasons related to tooling"
> https://lwn.net/Articles/739183/

Right, and what I said was that you should make the entire comment a C++
one which means that the magic line will be C++ as required.

--agGyne4gKHM29dDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvsW/AACgkQJNaLcl1U
h9ARfAf7BUJ2TjdjCO1OP/yZi+Fz/tBTVFUVwsvmt3t6tDcgAnvBddRaxNkf2UnI
Ku02xMMRFJVIlPiWqh0HqT1l758GfvSVaZC2YdDFSO+JVQnP+svyxnx0XaSuM8QF
wU9yP4kUyOALyfBNqMcF2YaTfNSxxmiO49XIr0dVH6Sik+xdRbiY2apra+/oKmRt
LRcnJLty1t6VyrZdAnUNWMH/L3oF/lEzOLrqTthEqpxfnaVhsReWu42qJeFmYI8n
rJmR/6oe+mx+0y2USzduCUUn8syd0YExUkQSoF/sDgkwaFb7dWtF7bZ6s2CXGpqI
6Se4ft3a4WA6K0hrGJbZMwr5iD7awg==
=zoBY
-----END PGP SIGNATURE-----

--agGyne4gKHM29dDu--
