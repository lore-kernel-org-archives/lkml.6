Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A12ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4F720846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="HvlZd9oS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4F720846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388141AbeGWL0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:26:14 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45772 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388021AbeGWL0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wO+g2Y34hM32cBZw1e18HnlLgpVubsQ0Bk99t/BHUB4=; b=HvlZd9oSewxF64PxuIB3u68MX
        hbV+y3GkLn8lCrqwkp7/gLzS0nS6mxyvbmW24QlSJxhyARu8DTz/HHDUFHEOoS1hil01eY5Cs9lol
        xP0eyn59vPCweQOYhAnmZiPoNCl/W3/sij/Kk4ehErPljMa3PQVeF7m7gH0bnhm4a0MdY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fhY1x-0003xf-0N; Mon, 23 Jul 2018 10:25:29 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B7BEE112387B; Mon, 23 Jul 2018 11:25:28 +0100 (BST)
Date:   Mon, 23 Jul 2018 11:25:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 2/2] ASoC: tegra: probe deferral error reporting
Message-ID: <20180723102528.GA13981@sirena.org.uk>
References: <20180720080424.31505-1-marcel@ziswiler.com>
 <20180720080424.31505-2-marcel@ziswiler.com>
 <20180720121612.GC10784@sirena.org.uk>
 <1532089865.19673.13.camel@toradex.com>
 <20180721095615.GG16228@sirena.org.uk>
 <1532167581.19673.21.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <1532167581.19673.21.camel@toradex.com>
X-Cookie: If in doubt, mumble.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 21, 2018 at 10:06:23AM +0000, Marcel Ziswiler wrote:
> On Sat, 2018-07-21 at 10:56 +0100, Mark Brown wrote:

> > > > > -		dev_err(&pdev->dev, "no codec-sync GPIO
> > > > > supplied\n");
> > > > > +		ret = ac97->sync_gpio;

> And here I assign ret with that return value from of_get_named_gpio(),
> right?

> > It's not in any way involved in setting the value of ret, whatever
> > value
> > that has it's nothing to do with that operation.

> I really do not understand what you are trying to get at, sorry.

Didn't see the above assignment you'd added, sorry.

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltVrRcACgkQJNaLcl1U
h9BPnAf/X7WpWwT+ycthPvj/M4GzQ9pY0c+5oUCBO66OIRz5TjmLDck3P0oSGlwM
tquV26H2D8YwAjE2QUE9QWH4rMmvObuf+yKEUuBhknCe4Uyk3Jcm3+A+BMtVZQ9d
9GPCyvwG/MeT2YukiJOlsh7TmVgU5qiPNJc2Gb40zeMJf0TxpEHLMut1vU0rqD5i
lwrqnD/iep0GhLrZAPIQ8b+kVBT7kQmrzkHf+YuVCmWqcsvPy7lEIfAYuI+OaNuw
SoF1Yu5t+gMwVgYhxpR/Ta1PHZqapX5yjpWmDtm31052akyXiDXQ0+9p/OOTSO8K
pxH071GVUcHGZPQ5Id9IFfaP4CnAew==
=DxoV
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
