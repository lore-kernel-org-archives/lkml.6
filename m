Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A534C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1957020684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="YpEcWZBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1957020684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbeKUDbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:31:18 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58238 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeKUDbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aSRscq1Yg5KFJKbbpyNb6ovVbz2a/f33A13mlAhQVQA=; b=YpEcWZBaD+gI3hIjNU37Ni+dC
        ZTIvWtyDn4/GFChyedVGXotxIWQkJSkUg7L9BMmcVLO6tyUTqrsj8Vm/UFvFUcA8SVlrqD8UMMisQ
        JY4OmNoZiLTbd0mGvAAElSE6VZsaHU3UmDvSf0CkYx+b1f2RSMpWAScadxdmxCPBpQ3nc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP9OZ-0001pM-Oh; Tue, 20 Nov 2018 17:01:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 71E1B1124DC2; Tue, 20 Nov 2018 17:01:03 +0000 (GMT)
Date:   Tue, 20 Nov 2018 17:01:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: Applied "regulator: wm8994: Pass descriptor instead of GPIO
 number" to the regulator tree
Message-ID: <20181120170103.GP3894@sirena.org.uk>
References: <CGME20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137@eucas1p2.samsung.com>
 <66d3b74c-0152-b17b-89d4-a21d33445b25@samsung.com>
 <20181120144700.GB16508@imbe.wolfsonmicro.main>
 <f1c7e9fe-aa57-c7c4-1c2f-02105a5a7474@samsung.com>
 <20181120153215.GC16508@imbe.wolfsonmicro.main>
 <20181120153610.GD16508@imbe.wolfsonmicro.main>
 <9314db6c-9498-579d-430c-5a2992fe513e@samsung.com>
 <59879030-93a4-f562-b03b-c5e579d44e89@opensource.cirrus.com>
 <772b6fdc-57af-fef2-0c85-78446bec2c2a@samsung.com>
 <ea2b959c-0d04-6a50-4d69-3f03576fdac9@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="D3I0HgOdJ5+6n+7I"
Content-Disposition: inline
In-Reply-To: <ea2b959c-0d04-6a50-4d69-3f03576fdac9@opensource.cirrus.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D3I0HgOdJ5+6n+7I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2018 at 04:57:16PM +0000, Richard Fitzgerald wrote:
> On 20/11/18 16:34, Marek Szyprowski wrote:

> > Deferred probe was there already. This patch however introduced the
> > warning from gpiolib and I would like to have it fixed somehow. In both

> I don't follow what it is you want, are you asking that it shouldn't probe
> defer, or that it shouldn't log the reason why it deferred?

He's complaining that gpiolib and/or the driver's usage of it shouldn't
be generating a backtrace in normal operation.

--D3I0HgOdJ5+6n+7I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv0Pc4ACgkQJNaLcl1U
h9AePgf/c4pgxmZx7gALp8MEikURGaCJ7x7MVdA3yOcmPVaI/8Kyck7ZN0+ARlmE
tBbWdkBSEVbV0dPxEU9pvfDOkKFgSfHakIMWLdF+ilF3vVxiKHraut3Hq65zNOvn
Wwf3/JFPbF/mDXOGqEoqHPyjusemYget/3SCat6v94z4fU2SbqkYoeAPbeqC5Pxa
Gk8Zo3KQeGOmkUtai2Tcku8TnFUX8pAcT+xopqID1N1YsfZeB3D2oR7qs8Aw3bdk
fHyJeEDOv0jylyybPWwkMXvFN46pvraOkIQzD3rSgaUyW9frHK48B8Y3pr/DgxI6
PlUKAgmcsejoBMfAAfCZSff0OYTbEg==
=wS2i
-----END PGP SIGNATURE-----

--D3I0HgOdJ5+6n+7I--
