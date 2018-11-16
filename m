Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DA7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921A6208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 00:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="xGZ0dqv6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921A6208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389035AbeKPK35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:29:57 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35622 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeKPK34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 05:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qAub6yNInRsvxKOvguTNXIctuDjdrXnbTgSHeqaFviE=; b=xGZ0dqv6xcFZ87gtDXr9Q2Ye/
        F6K3HrRJGRwBSVY03+lzQ7yh/xVd/tDo9K7aPkKM2J7Jq+w9wmPGryGx/1FE10uQGXarovIi/MAZu
        fJ0y0zBXzLluQEpyssiuZ1Kc/6VQRMYj+6g/xflybIf/RJ8NtDmIl4wokaBvvTmfBwTOY=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gNRrH-0006e8-OV; Fri, 16 Nov 2018 00:19:40 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 85002440078; Fri, 16 Nov 2018 00:19:33 +0000 (GMT)
Date:   Thu, 15 Nov 2018 16:19:33 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        ext Tony Lindgren <tony@atomide.com>,
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
Message-ID: <20181116001933.GU2089@sirena.org.uk>
References: <20181115232747.23566-1-linus.walleij@linaro.org>
 <20181116000740.GT2089@sirena.org.uk>
 <CACRpkdZ4wVu+1bSXJQJGpUrf0LFndRGV9oKexjv80cNAb+YGaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R9lH2i8s2YEs6mH7"
Content-Disposition: inline
In-Reply-To: <CACRpkdZ4wVu+1bSXJQJGpUrf0LFndRGV9oKexjv80cNAb+YGaw@mail.gmail.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R9lH2i8s2YEs6mH7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 16, 2018 at 01:11:40AM +0100, Linus Walleij wrote:

> I just wait a bit more and see if the build robot find even more
> secondary build nits.

Sure, no rush - I was going to leave it for a while so people can test.

--R9lH2i8s2YEs6mH7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvuDRQACgkQJNaLcl1U
h9BFNAf/Q/yVb99qxouCDZ6p9jMnmTN5QqNlwA81fkSLB40pOmXXMq7PG+LEQU6v
0ZTAjIGXTIfwD8VMGa/HqkzjCK0Z/SDn2svYKjsMOAMJ2yB7xbOQAK+MTXtX4yvF
ynW91NdPgiNrDH1RwZKXPylr6SfKbfQXH6GUL1b1gpqU65W4Wx7mzVUpG9o3M2dC
tqBerfHHleSEb9cywTdWRy5lSnxADUzDjLueeVHVtceMfjVUAhQHqlFSWDqKxvSf
paHewP48uGTTfafgFHMGgM8GwI8OCKkkkfGswxjGrjoU/z4d20aUUa+lqasQH5O7
5awISHeQhXhFtpm2UHGd7IVrDBilaw==
=1noh
-----END PGP SIGNATURE-----

--R9lH2i8s2YEs6mH7--
