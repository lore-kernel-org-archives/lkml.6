Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461C3C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CB420851
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="d7TPB9Ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CB420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbeJ2SeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:34:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45226 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbeJ2SeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PuM/YVr2So/dmG84HTc1LgCHTadvBadxAXV9Fq06hs4=; b=d7TPB9AhsXigINRCK813cnCOF
        tOEnFIzllQjyq48n+aLrOpWg0A6Zfa5bMa5VqPIenUZcIA2l2pKyDrDXyUuC4zhvIviuEdYdYi9JL
        +v8CP4Kz1OBb9sbWwdgBq7wiV9q54QjWZO78R2qtqPsMbkCRVWFd/p3PtV8HK7lGg85Cg=;
Received: from [87.246.78.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gH47t-0000uM-JC; Mon, 29 Oct 2018 09:46:25 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B1FBC440078; Mon, 29 Oct 2018 10:46:24 +0100 (CET)
Date:   Mon, 29 Oct 2018 09:46:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: bd718x7: add missing linux/of.h inclusion
Message-ID: <20181029094624.GV2103@sirena.org.uk>
References: <20180919071400.GA12191@localhost.localdomain>
 <20181029094041.GB20774@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N4FnyIpcgIJc+tmW"
Content-Disposition: inline
In-Reply-To: <20181029094041.GB20774@localhost.localdomain>
X-Cookie: Piece of cake!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--N4FnyIpcgIJc+tmW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 29, 2018 at 11:40:41AM +0200, Matti Vaittinen wrote:

> Should I just create another patch to you where this inclusion is done again
> or is there some better way to handle this? Can you cherry pick or
> re-apply the commit

Just send another patch, it's easiest.

--N4FnyIpcgIJc+tmW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvW1u8ACgkQJNaLcl1U
h9Chrgf/aICEqWh2fgKwBmywnecmpIKyHveUOprDsYcZ79AkbmfvJze27oUfKJCp
WZHKNWEP/Zivw10OMpDm91/A0L9sqhx6FzI25Ny4IdAH8kZoubpjx7isrLWqVVQg
Kbe0BI2m37SxjuJ187fy7k3vbVJRlsr6ndm48McCiJIcx+ty+LflxuySbsSFmp8y
KptHTAslha/8BbQ2/nlJlHdbWNpQnDg0iCwRnSNOG3xMF0S3oG1zypOYCCYbK/MX
WLxIYEVwcVMzNvvmGVAm7FVEedKTi5AmZpfrNLJS4tTSEM5+8ldPPTfPsZUtWp51
tynVLehN9mYTMN93Qixd3kwT1IQWSA==
=aDLI
-----END PGP SIGNATURE-----

--N4FnyIpcgIJc+tmW--
