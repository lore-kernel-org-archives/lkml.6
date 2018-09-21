Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F533ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498392146E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="CkTpRzQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498392146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391270AbeIVAlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:41:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52790 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbeIVAlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pfMs97wtgveph8mP0NamPkwistftoBCSYTn9S81WFM8=; b=CkTpRzQrpF3Tq1ECRMsUQL31m
        cr9d3hiPNYDEYJ+N0BQGecDrzce1nTYX2vzBmPNbvT1KTp0ya3t56MTcTWjeOx91wjBax6LoYvzJT
        uhlN0HVdCbDIUDSD1rYDhpER/Q6n7p5Jgxifu4j/JHBgkyrrrW8GIwozedtGm3ss0HVbU=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g3QWD-0000ke-8O; Fri, 21 Sep 2018 18:51:09 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 8EAC8440078; Fri, 21 Sep 2018 19:51:06 +0100 (BST)
Date:   Fri, 21 Sep 2018 11:51:06 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>, ryandcase@chromium.org,
        boris.brezillon@bootlin.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI)
 documentation
Message-ID: <20180921185106.GJ20825@sirena.org.uk>
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
 <CAD=FV=Wbj+bgdSBeHSFr+nz6fzCMcmQS-D9oyzkR0yVkxiRb8A@mail.gmail.com>
 <153755522409.119890.5471037050114193@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1ou9v+QBCNysIXaH"
Content-Disposition: inline
In-Reply-To: <153755522409.119890.5471037050114193@swboyd.mtv.corp.google.com>
X-Cookie: Disc space -- the final frontier!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1ou9v+QBCNysIXaH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 21, 2018 at 11:40:24AM -0700, Stephen Boyd wrote:

> It seems that everybody has misunderstood my email. Let me try to
> clarify.

> I'm not saying to replace the sdm845 qspi compatible with a generic one.
> I'm recommending that a generic one is added in addition to the SoC
> specific one. That way, we get to put the generic compatible string in
> the driver and not need to update the driver compatible string array
> each time a new SoC comes out with a new compatible string.

> If it turns out later that we need to handle some bug in that specific
> SoC compatible string then we're good to go and we can handle it by
> matching the more specific SoC version compatible.

Right, the policy is generally not to have these strings at all.  IIRC
the argument is that they tend to either become unclear as the marketing
and technology changes.

--1ou9v+QBCNysIXaH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlulPZcACgkQJNaLcl1U
h9C0BQf9Fshy+ezWZkTSrgEQ3NGWsVxbZeRzrShDSv7SKUi6RMolLG49Uir+yHKW
oKzui9ZctJgJ7gm0eWwC93pv8IRrad7D4OboXV9WhBgbm+2jAZXva3mlPQtC97/2
VVPeBEnRxD8h3azct5dAM4Tv7t7MA6xD6JDToC8kYuVUJrAqXxPhxH3fhORYZVwk
xqzqqC4GMzM8UpjzR8v8QloS9F2YVbLuKuKRbXdJpBxrDQIZM/ot4+9g18kfS5z8
SA9rWix9UzupOnheaCpJfqcn6dYNOv4TgOV+or5H4gxBn9fn3Zxi4wsJMMnkvgNx
9nKlWL22qdTAaCWSDFdFeyXKR8Cj8g==
=geHU
-----END PGP SIGNATURE-----

--1ou9v+QBCNysIXaH--
