Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F710C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCFA214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 17:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="SrzfgejA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCCFA214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbeIRXQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 19:16:50 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57062 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbeIRXQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 19:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ksTHndBxmHUoRTdw/O0TdUTimnwj+h8BDdSGJ1wwM4s=; b=SrzfgejAMxKkD3POEwlPgVEgK
        Yv3+k4LWxxzTASiJfKBwx2/hWfddYn/QtDe0bP/nqrWG9A38t6CXgnacGneQ2IjkHu083RoKW9hJF
        hLB82gGNisrsr/yl2VK0BKmrIvXNR42Jmgod5tMvdAmxw/F0dSfUR7E7hMaO4M6hn1Dsg=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g2K1h-0003WG-Sb; Tue, 18 Sep 2018 17:43:06 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B47EF440078; Tue, 18 Sep 2018 18:43:03 +0100 (BST)
Date:   Tue, 18 Sep 2018 10:43:03 -0700
From:   Mark Brown <broonie@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
Message-ID: <20180918174303.GU2471@sirena.org.uk>
References: <20180917113559.11101-1-lkundrak@v3.sk>
 <20180917113559.11101-2-lkundrak@v3.sk>
 <20180917175753.GE2471@sirena.org.uk>
 <54f5d070c8b0615baa26983e97e2a22401973096.camel@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4WCFFtl4AQpQKunj"
Content-Disposition: inline
In-Reply-To: <54f5d070c8b0615baa26983e97e2a22401973096.camel@v3.sk>
X-Cookie: Universe, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4WCFFtl4AQpQKunj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 18, 2018 at 02:15:12PM +0200, Lubomir Rintel wrote:
> On Mon, 2018-09-17 at 10:57 -0700, Mark Brown wrote:

> > > Changes since v1:
> > > - s/ssp@d4035000/spi@d4035000/

> > As covered in SubmittingPatches please put inter-version changelogs
> > after the --- so they don't end up in the commits.

> Will do. I was actually not sure about that, so I took a short look at
> the git log, and it seemed to me that commit messages with the
> changelogs are quite common.

For various reasons the drm subsystem explicitly does the opposite
thing and it does leak out in other places (eg, when someone does it and
then it doesn't get fixed up), it's a bit unfortunate that there's some
divergence here.

--4WCFFtl4AQpQKunj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluhOSYACgkQJNaLcl1U
h9AHkgf/cCVVEd+WCSVik9ryhlUhC1/wAgNrQri8wZDg/H5Ljb+1eVnzdtry1IHU
7sarVWP9dxDqyBro75/ECWPrB6+JEtOJ890j6eyf/4gpBjqSip0/4AKEBAT8ormp
wL4CSLpyCQhzOkeOKXVHS5la+tUFvbzcstJnzDl4hT6FoOFEJ3zPnOZOvBw3+HNT
zbcI3SiHIR+Mpp92Mn+ZhEA8tCDrSUyGMUXYxPlGMIT+0+wYdlubXDWFCQOrPQIm
VSe+0t7pM5yHPMWDkpUm00mFR3Q0LEGtsMpIAnkxu2yzYQyBC/TtV5ajoCkmqdJN
XXtDt31ZU8YSXyMeSw7Oh9XLEOdJZA==
=/CR4
-----END PGP SIGNATURE-----

--4WCFFtl4AQpQKunj--
