Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860E7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5722C20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547465098;
	bh=7ndevwlRaT+QtfbMG/d+aSukcRO/1iUNSKK8QOsDbF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vgh4n/MwGrfZlAz1sZ3mqItnG6Sn8Q88s3+wIBpkbb2y/9Os0hFrPbgvJkmnk2aT0
	 ijmZ8T0f9K5zFSjHvQP+oyFBs3z+XUehreQc10Xd7/bFyLrcbYWJA9QMfOdkaPd5ty
	 MipbzPYwicZ+nG6oeoR++ebJvpdcE8c3YlVchPSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfANLY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:24:56 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51968 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfANLY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7ndevwlRaT+QtfbMG/d+aSukcRO/1iUNSKK8QOsDbF0=; b=alH+b6sZd4l1viNIaIep12nNj
        fMLOExAUhIgM3z+sqM8Xu6oUqEGyMAYukVmuH85JpZ3wMByqMV2sYTh3tfty58mmixTeVJrWKmCU6
        rskQqx8kR+bVz1aC4HbjQ6zevYdGCy4m9s3XVR/MuGsOjkbWGGfYtWcQOQNxoqkA92VXQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gj0MG-0004rp-2H; Mon, 14 Jan 2019 11:24:44 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 70A87112708A; Mon, 14 Jan 2019 11:24:43 +0000 (GMT)
Date:   Mon, 14 Jan 2019 11:24:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     perex@perex.cz, tiwai@suse.com, brian.austin@cirrus.com,
        Paul.Handrigan@cirrus.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: cs4341: fix waring unused-function
Message-ID: <20190114112443.GA11073@sirena.org.uk>
References: <20190114095540.22956-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <20190114095540.22956-1-anders.roxell@linaro.org>
X-Cookie: From concentrate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 14, 2019 at 10:55:40AM +0100, Anders Roxell wrote:
> The driver cs4341 can be built with SPI and/or I2C, but it has to be one
> of them at least. When I2C is set as a module we see the warning below:

I'm missing patches 2 and 3 of this series and there's no cover letter.
What's the story with dependencies?

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw8cXoACgkQJNaLcl1U
h9AJHwgAgiocrClStcUh92WnpSwD5nQrZmRdfx6j4EVsN+EA+bRasylhwousCfCQ
vk/8h6FWqMkjGuIAdHw8X0OBgSAfOzFz8YJD68CAgFpWmH0FMwBDFny+uAkKm/tA
O8xQcfLZRpQbD/0+9Tw/EL6AfreE3x6g/h3EB1Uz5JEhBGMQB6rAZTmNpb9Yj0ow
sYE9KZVW2DDo557PAAVBPOvgjTYuXi+L0YsHzI7AUjPDjBEEnq/P1eWkUIIhZexJ
PQg1nGXw/FTmvgokIKi/DLiHC2Vh7LFZDsUjxbahMyu3cAc93m+cNvUc1OoP37Dg
ono2CIsZYCht49G3n0ly2eyxfqznaQ==
=WnUQ
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
