Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE94EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853AC2081B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 19:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546283675;
	bh=+A5qCuC/MLNrINoxxhwiUkMw3H4SiaV3NODrqD+IPbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p9b0OuR9f5CDpjlkvUWv0TMXo/dQz8BTy6CCVkxFESycR8LEMOcHipQQ0Z38KjGBH
	 Pi+SW0VV8m9VmUxHp58A5NuMaTdQ9B0aTRteoHF/lMjhSchXsXBV/M9vG5UbmpMWIj
	 SJ3VZzJhPJKc/pfzh0tgeyOPbXW3K6JrRsqJMlh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeLaTOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 14:14:34 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56948 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbeLaTOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 14:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+A5qCuC/MLNrINoxxhwiUkMw3H4SiaV3NODrqD+IPbs=; b=ofuy0itMy7sAn5lAWxfA3QKdf
        MBBuhCkL69D5DPsO47sysskrF4IuNsFjhnG05DR/4jVWOSef+ZZ/bGQVTEYXQQHu6yJhaPC6vwmw4
        phBWuANycMSA6sWHmDpMrdtsd5vgb5bCFovttFXmHDFCuk9lxzrVg2sxVQ9oClrrEMq7o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ge31B-0002e6-4R; Mon, 31 Dec 2018 19:14:29 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 72386440080; Mon, 31 Dec 2018 19:14:28 +0000 (GMT)
Date:   Mon, 31 Dec 2018 19:14:28 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mazziesaccount@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH] regmap: regmap-irq: silently ignore unsupported type
 settings
Message-ID: <20181231191428.GM1846@sirena.org.uk>
References: <20181227084443.GA23991@localhost.localdomain>
 <CAMuHMdUg=C+pNrbauM-f7LchXRnwu1ufYyUSp=jO+8hs_SrgXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nj4mAaUCx+wbOcQD"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUg=C+pNrbauM-f7LchXRnwu1ufYyUSp=jO+8hs_SrgXQ@mail.gmail.com>
X-Cookie: knowledge, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nj4mAaUCx+wbOcQD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 29, 2018 at 12:13:32PM +0100, Geert Uytterhoeven wrote:

> > Geert, do you know if anyone vould to test this?

> Thanks, that seems to fix the issue with da9063-rtc.

> I don't know how to trigger an actual interrupt, though.

If it's a RTC does it have an alarm you can set?

--Nj4mAaUCx+wbOcQD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwqapMACgkQJNaLcl1U
h9CgeQf/fjG7HJ8kklzN98fafIkQ5sRbyONFCSbBosdOVgstcxyaTKi5nutk3dmy
C/oWtQnxpFrcWj0i2KMX3SnMjlRmETHNZPjF5kRC+e0W7i3PcnEQ7SPYGm2QCyDg
j9GAdS5HKvdR8GKGxYYYQ9vFb2CVa0QQwdCkAF7Z7q60qyObOTrLZ132q+4KHqlp
oIEcuc5y7a8RWYMSYRbzoSdMnlypS8f9/uYr7xxehRxywtwkzRi5trLjEqiXeEUg
cloxj/o34UXVR6/YsfGZ7frECPRxdxAFjGCLSxE0loZMg0SZHRkVdm60q3sG1+jc
w7mR9Wp8srXgJluFKKTtjAcH7H0CGQ==
=O84J
-----END PGP SIGNATURE-----

--Nj4mAaUCx+wbOcQD--
