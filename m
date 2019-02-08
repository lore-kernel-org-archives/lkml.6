Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96541C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE30217D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549626828;
	bh=kx/1SyNNzt9ThrOAeX9Q7yM2hO+SGKLMzzY6A/wc3ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FD4uueXZh/OfUHSna85X9gbatUduCVDPXDokkTR+qJFBUwk3u0ARFuYMT/a7gwBs9
	 aCUTFOWMKi9GaKBDdCROgWx7xxyLFw+1vSUoKVfnEXsX9+udyCgCLFvvtOJNgYZHwV
	 0ovhiT2DSAc4C8TEiPF7bXhYDN6CKWdXEvdQiFP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfBHLxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:53:46 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48836 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBHLxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kx/1SyNNzt9ThrOAeX9Q7yM2hO+SGKLMzzY6A/wc3ng=; b=G1qbMEZbnI7YgnUkNhzecWvzK
        Kx7J4+/QIKUURVin0pxII2R7xtZNy/ZoUd9AGHBcVWpvx6zGP4yczKTRaVWSs2sCsB3ELeFR5cN4r
        lRAJVaa3Z4sbcrEpY31BNxHSnWuCY34wYMvSkyvHaD0Fbw21qaXyYeAc5NPRnmS2Ph2RU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gs4iz-00019w-GS; Fri, 08 Feb 2019 11:53:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 222011127F2F; Fri,  8 Feb 2019 11:53:41 +0000 (GMT)
Date:   Fri, 8 Feb 2019 11:53:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: msm8916-wcd-analog: add missing license
 information
Message-ID: <20190208115341.GB6695@sirena.org.uk>
References: <20190207165755.1548-1-johan@kernel.org>
 <20190207165755.1548-2-johan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
In-Reply-To: <20190207165755.1548-2-johan@kernel.org>
X-Cookie: Mickey Mouse wears a Spiro Agnew watch.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 07, 2019 at 05:57:53PM +0100, Johan Hovold wrote:

> +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> @@ -1,3 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
> + */

Please use a C++ comment for the whole thing so it looks more consistent
with the rest of ASoC (and a bit neater in general).

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxdbcQACgkQJNaLcl1U
h9Be0gf/QKPELmLG6FLa7UU3wNmtZtk2U+HBGyrAbim9AINmmojTCIvjVnwng7w5
8CVUVLC3gWlQ7U1OR3E9nvhrl9Ximk1rqsWFLwI754LJgmkTLjrh925lFf4LVd+q
PpAjJP/IN5YQa5ZX5A3XcNcsvwJI6ASCE8I0WBS6g/OHQ/3IKrpH7ghaiTgD4kiB
JqiOVTrGHDJWl1VneZRHTT35Bgwnods9tyUUQewKnL9bm/F0zXNZFNK+cA7AyZNi
k/Ldkd98RjS2aottEQoxBSwO02f8GT83zWmH3XKZcQ/4pBYYF7JLjHjed/QDxFFh
hTJQ3nHmR5IUtANcGssJtVpmn/JZXg==
=4nTm
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
