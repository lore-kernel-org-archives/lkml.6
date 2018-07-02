Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A7EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A344253E9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="pdvHCk+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A344253E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933968AbeGBKFh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:05:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34060 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753269AbeGBKFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t+wQuTk2GuYXUPp6wQ3NRm2dnMOWY4Wr3aiv5G1lDlg=; b=pdvHCk+OayzizXwra/TpXjBS6
        iAAZFW/shO7KAc6q7LpyCEDfdhHS+YnedtYqAv9LWgoeMFcN/PyFZ599CZjygb6xDkdx1FY6V8Eoq
        +oP5mVAH40Q/XzMJldy3FAFvbYHN5IShX354uvJBemBQkwU1FamJAYMFW7D4sfaq1mBO8=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvi9-00042T-K7; Mon, 02 Jul 2018 10:05:33 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fZvi9-00069R-2g; Mon, 02 Jul 2018 11:05:33 +0100
Date:   Mon, 2 Jul 2018 11:05:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] ASoC: es7134: add support for the es7154
Message-ID: <20180702100533.GD18211@sirena.org.uk>
References: <20180629150924.18197-1-jbrunet@baylibre.com>
 <20180629150924.18197-6-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
Content-Disposition: inline
In-Reply-To: <20180629150924.18197-6-jbrunet@baylibre.com>
X-Cookie: A good memory does not equal pale ink.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 29, 2018 at 05:09:24PM +0200, Jerome Brunet wrote:

>  	{ .compatible = "everest,es7134", .data = &es7134_chip },
>  	{ .compatible = "everest,es7144", .data = &es7134_chip },
> +	{ .compatible = "everest,es7154", .data = &es7154_chip },
>  	{ }

This needs to be added to the DT documentation.

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAls5+OwACgkQJNaLcl1U
h9C4Vwf/VXD6wsjvJICRurg1X4zocpRgWmsENAmmPsEmNx/hB+/T3gatzbRpNnGi
zrMdoZGOQ/euHQLsZ6vNvWy4//VMC5vcdzfpJ9pvJ2M8ku8ev3uZaEZWycx0HXe0
iiSWhLf5xc1mb5OwuxUqMg3NXi8UEqQVXDEWwE1eKOf2lGSpo58VM+CKCrN3Coh5
i7l7cXBKPJh95yinpI4Z8wZsxsxqb+vG0CpnqLHOUzDN6YzuChSQ9ha49VQYUE3B
TCh+b6mFud6aeJW0RJbKcwGCGN2yyQSR5C0JFn1Jddlc5gGME3PIvbsed1v9IjpU
uGGm8R9GssdwzsLImjXigWb+94Cpag==
=BtKP
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
