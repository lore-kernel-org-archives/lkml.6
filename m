Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690F8208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="BW7P+qy2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690F8208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbeKPKSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:18:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44546 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeKPKSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7nWsDoGzuEXV7z6gQ3C7dgu/UsKI/mlpxJTeDTqRvaE=; b=BW7P+qy2/pK3YiDKNb3bmoR1W
        uOvRIfQMC0xHtZZeDx6PX742NBouyrapzhLMEN/RV3NdRiITyyK/G6X0XxDW7++0V/k5kZ/yp6mB3
        OsN/AFc7+a+bw64UbwtLbqE6Na4zfBi5iP8iLCs2A4TxxwRHk9sy/8zbCz2EfjfDkWrho=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNRfm-0006cE-Fv; Fri, 16 Nov 2018 00:07:46 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6CA19440078; Fri, 16 Nov 2018 00:07:40 +0000 (GMT)
Date:   Thu, 15 Nov 2018 16:07:40 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Petr Cvek <petr.cvek@tul.cz>,
        Paul Parsons <lost.distance@yahoo.com>,
        Daniel Mack <zonque@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 5/9 v7] regulator: fixed/gpio: Pull inversion/OD into
 gpiolib
Message-ID: <20181116000740.GT2089@sirena.org.uk>
References: <20181115232747.23566-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oiTwr10F0DlNHtiD"
Content-Disposition: inline
In-Reply-To: <20181115232747.23566-1-linus.walleij@linaro.org>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oiTwr10F0DlNHtiD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 16, 2018 at 12:27:47AM +0100, Linus Walleij wrote:

> ChangeLog v6->v7:
> - Fix a missed .enable_high on OMAP1.
> - Resending just this patch.

It's much easier if you can resend the entire series (or at least the
bits that aren't applied) - having just one patch isolated makes it
harder to keep track of what the current version of the series is, which
versions of which patches need to get included.  Could you resend
please?

--oiTwr10F0DlNHtiD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvuCksACgkQJNaLcl1U
h9AE5Qf7BhSg6Rbif7IjBndaE3GHpA79OJf4CWw3BW2wnQslYS3PJYUfs88lOLp1
jpeI9sCSbhiamOEjuRngCfqEPeY1ysJQNwfz/ussod6ZsgHqXD9F+HLFrPFd50rM
AoPkuUIDEx2r0y/qntFA6W0R31/DokuZInpReaH78U3GeDlUFuan+c9gaixuOG8o
arddimpkTQkd8nIh/Ssgj27EeAxBn9MwuV9drpYKnu3TZ/VJ+i61wkm8eRgV7B5m
5T53qx+MPJUsAfEYZwbwra7TyKv55bfvheJFIYmUgvIhKMYVEjON8bVocpYBYb2Q
0S7Ov3dWqaD4fuGPM2q295AF+sOZAQ==
=P/UK
-----END PGP SIGNATURE-----

--oiTwr10F0DlNHtiD--
