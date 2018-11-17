Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138ACC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD39F20869
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 03:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="nD9CyWWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD39F20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbeKQNZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 08:25:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54956 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeKQNZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 08:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ck6ocEZj8V4jZ51zH5HazNtGOhSAVHkW/STcIt/EOho=; b=nD9CyWWzQA4xwfDi0hg6j6oaV
        p+OTSB4rziIPxfLnO8KFgdT1t52pQb9wDi+Qgov0Dy2NrxCvDIc+5iFcjPaqvnkh/eH/iuMbesqLl
        ItoL8Pgtg3w7xsdcRaY0W1gjG36O/3GuC2JZ0SAOVttwHeG64X8rcf9zzN6M4xPRBSSYg=;
Received: from [204.239.253.216] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNqza-0008Jb-VY; Sat, 17 Nov 2018 03:09:55 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D64B9440078; Sat, 17 Nov 2018 03:09:47 +0000 (GMT)
Date:   Fri, 16 Nov 2018 19:09:47 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Colin Didier <colin.didier@devialet.com>
Subject: Re: [PATCH] ASoC: imx-audmux: complete dt-bindings for imx6
Message-ID: <20181117030947.GX2089@sirena.org.uk>
References: <20181105135802.30486-1-peron.clem@gmail.com>
 <20181116025938.GH5829@dragon>
 <CAJiuCcerEanEobbi8zPb1-eb=zCJsDAbM=p6T64+wtuXjtaMTA@mail.gmail.com>
 <20181116144520.GO5829@dragon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t54s24TTWYm6oOX+"
Content-Disposition: inline
In-Reply-To: <20181116144520.GO5829@dragon>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t54s24TTWYm6oOX+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 10:45:22PM +0800, Shawn Guo wrote:
> On Fri, Nov 16, 2018 at 11:25:07AM +0100, Cl=E9ment P=E9ron wrote:

> > It's still quite new for me to submit patch, but if this patch should
> > be sent to ASoC maintainer maybe there is a line missing in the
> > MAINTAINERS file no ?

> @Mark, comment?

Adding a file pattern for this seems sensible, yes.

--t54s24TTWYm6oOX+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvvhnsACgkQJNaLcl1U
h9DP2Qf+NCg2qakRTqm4Nl59V4nGhjYib4S6ak3q8O0zJk+HbUyC0KJ+Ep9OuR95
aPN0hl9YXWLhiLBf3LYBZCSBC+76gzwCAGRphNomR8f6dLRg/NfPSJwZz7wEttSn
XmueW9QjoSdFtrYwZy9GVoJW43vKDK7F545GqLWOK4kvUzap8y/ovtHCBRz5WWT2
jAun20s7p2TxB7ubJmMCtBhO1kK9lUtn4eolsnGUgDGaErwBq+bf94dbqsrJSj5e
Vy4AWIta6/kALjBlcpAsvoYxy1yxGoq1o8LYU7T0o5quwtLCLYtfj0RGPKGnWGP7
9LvH54nwxub/n0gfzGf66cwOZmBr7g==
=/Vez
-----END PGP SIGNATURE-----

--t54s24TTWYm6oOX+--
