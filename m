Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFBDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299AA20881
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="sP13Cm1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 299AA20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733179AbeGKPK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:10:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59920 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbeGKPKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j994AZmqUGzilHTm2RG/zqbFQth8J529hGPvEAQVDv8=; b=sP13Cm1ZqG4UP6ukQdRugbmlq
        AenC+kz1Zy8IX2ab6wUmZ2CyvVTJcl0/gW/NgJ24pblT7AXK3EysicZL/x41vf2T7hxQwXVVATyAP
        TYRsUSOkTiKZac1pW6fZIGW88IyqBSjeJ/Zes7ocYRvsXivyGyAv3OpKmzb8Lvn464sEU=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdGgx-0002zh-Ht; Wed, 11 Jul 2018 15:06:07 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fdGgx-0006Lh-41; Wed, 11 Jul 2018 16:06:07 +0100
Date:   Wed, 11 Jul 2018 16:06:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mikko Perttunen <cyndis@kapsi.fi>
Cc:     p.paillet@st.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: Boot WARN with patch "regulator: core: Link consumer with
 regulator driver"
Message-ID: <20180711150607.GC9651@sirena.org.uk>
References: <83491a3e-cfed-6673-244e-e720f338db92@kapsi.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <83491a3e-cfed-6673-244e-e720f338db92@kapsi.fi>
X-Cookie: Short people get rained on last.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 11, 2018 at 01:08:14PM +0300, Mikko Perttunen wrote:

> I'm seeing the following spew during boot with Tegra210 with the patch
> "regulator: core: Link consumer with regulator driver", recently applied to
> linux-next:

Someone reported this already, it's a limitation of the device link API
really but we've not seen much of a response from them.

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltGHN4ACgkQJNaLcl1U
h9AOmgf/eJykFhEVTVL/i+nXz8/R7N+K5q/MotehXhbssNgNJppfhmIF+zrwMX+I
jTASG1YCwsX7Y0fGLcgtRYS6QLr09AKgoT8kyA5I3f+f8o6oDhBgCQsPulzZsIkq
PvjTQuA8FG7Q6ybnwgfABdBVWq8pYbS7h+tiWDBTzH34gaepY6vhIRkJpHEDzC2P
OTsFvIL/997L+cBViFiyD/4Q4DIe/A4aQsTXsO5uUIB7eqfV+0b8is/WY9uZu9cu
jiWkUrFtp48uV8tp2owALNlwWnz0LhgGObz+F1c20WbQNzjHa786HsOCfLDgwEg3
MsQx3eogxJQLOU2+0tx6vNKRB6I0eA==
=8TN9
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
