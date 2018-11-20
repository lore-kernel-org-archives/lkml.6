Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78331C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE4320851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="CYjMeD/D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE4320851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeKUCMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:12:54 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40074 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeKUCMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JFCZycFUeSq0lZ4Nu7Yey1sobD9jXUjk6ZlCpB24TFY=; b=CYjMeD/DXRwyCE2oY6JRgqHWO
        s0zWslGfZd5RXZv2YhhJraQ9gjg23/atPBxqwpdQ52dqz0xmxTu2Ay6/7CCgT8fY25xq7kU7Eh+Rk
        66isXLFJRSk7WGurSfGEJaOXBBu+Sj3cCLq/fTaicoCQCeYhCcuxHP+/vVtofj/2hNh0E=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gP8B5-0001jE-7O; Tue, 20 Nov 2018 15:43:03 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9BFB51124DC2; Tue, 20 Nov 2018 15:43:02 +0000 (GMT)
Date:   Tue, 20 Nov 2018 15:43:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: Applied "regulator: wm8994: Pass descriptor instead of GPIO
 number" to the regulator tree
Message-ID: <20181120154302.GF3894@sirena.org.uk>
References: <20180517164120.485F844007E@finisterre.ee.mobilebroadband>
 <CGME20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137@eucas1p2.samsung.com>
 <66d3b74c-0152-b17b-89d4-a21d33445b25@samsung.com>
 <20181120144700.GB16508@imbe.wolfsonmicro.main>
 <f1c7e9fe-aa57-c7c4-1c2f-02105a5a7474@samsung.com>
 <20181120153215.GC16508@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Content-Disposition: inline
In-Reply-To: <20181120153215.GC16508@imbe.wolfsonmicro.main>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 20, 2018 at 03:32:15PM +0000, Charles Keepax wrote:
> On Tue, Nov 20, 2018 at 03:58:59PM +0100, Marek Szyprowski wrote:

> > No board file, everything in DT.

> This is really weird, because the error in your log relates to
> DBVDD1 which is an independent regulator supplied by a separate
> regulator. I am really having some difficulty seeing how the
> patch interfers. It is definitely that patch which causes the
> issue, like you revert it and things work again?

It's a warning in the GPIO code, the switch to the gpiod API will have
triggered it.

--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv0K4UACgkQJNaLcl1U
h9DOHwf/doBkRO+cG+zcjwZo+vjnnFDFaA+aYobDk58LzykYcHEfiwYXjjiwGS7g
tGiuM6Zy9oSTt83RM26nWUUr0s690C0GRq2ygyIA3cRHLun9A9a67iE7D35K/UJO
iKVTsXtkDHUErUxLFCPPuHlMrp03NAPXlwpE7uYuPD4WuijtLZcuVRDrzqQnrFOM
yXxaBQVF7tTiGflfuodmtCeUecc6gcxgtqT4Yik7NJJFkZfYOZhUgn3rah9cEFqN
z+jrH6Ohi9k4BeB2FUoBMNaQ4pQStL1Ii7b4WrGDBymPg2BKoQiyOVVtc60IyTXE
1xEqYx+ZSWMkszcsmyULPs4PeFQkuQ==
=Fpbn
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--
