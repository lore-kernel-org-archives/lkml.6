Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD86BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE3A20821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549476674;
	bh=LhJmLMfymTUSA5sOc/silIzRODW9r2RzDkRvQ0Q4N8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K6efOpbAilGYr7wSga06Tb9ROHdGjAoh6mrVI1tGv4zL5Crr0epx00fCjxzGdXbJD
	 vvX+/MUB28NohAuOIoHzcxBLsh6WUUKpfvb4WXz0rtSfdT22niJEbgRIXhVCFuOrfz
	 S52pHDkzOQr7yKSbZm7+BxCqZF5UM89oDbLPa1oM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfBFSLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:11:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55226 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfBFSLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GDOIfaCNsuHx4awkfMWy4r84WH8WTHE040DlvmA5f/o=; b=f59u5lHPuEMG20gqlkqRbBmUB
        bJkjZWykVfYH8h+bSIjm3OZgvhCjS3jk5YSH5O6YI34EXY5nhegbeH5WZQpL+34f8R0f8rwM6B+hs
        YApyKopjnX+LIRQeF9azvrdyP6n6mi8QGtrHKsqVLwvzpf4x/VZvdWjA0gLSn32XFirtQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grRex-0007WF-5s; Wed, 06 Feb 2019 18:10:55 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 842791127EA3; Wed,  6 Feb 2019 18:10:54 +0000 (GMT)
Date:   Wed, 6 Feb 2019 18:10:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] ASoC: codecs: jz4740: Use SPDX license notifier
Message-ID: <20190206181054.GF17630@sirena.org.uk>
References: <20190205031108.26171-1-paul@crapouillou.net>
 <20190205031108.26171-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aPdhxNJGSeOG9wFI"
Content-Disposition: inline
In-Reply-To: <20190205031108.26171-3-paul@crapouillou.net>
X-Cookie: In space, no one can hear you fart.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aPdhxNJGSeOG9wFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 05, 2019 at 12:11:05AM -0300, Paul Cercueil wrote:

> +++ b/sound/soc/codecs/jz4740.c
> @@ -1,14 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (C) 2009-2010, Lars-Peter Clausen <lars@metafoo.de>
> - *

Please convert the whole comment to C++ style so it looks more
consistent with the rest of ASoC (and itself).

--aPdhxNJGSeOG9wFI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxbIy0ACgkQJNaLcl1U
h9C9ygf+JHkT2svpsqkGAQ0zFVpciiYkmRlqFlvGQOo0Uyb57bINoJCazjYc4WLv
xoTLbn56dDNWyi8Sn0N69v5qTiAlE9lCHAi/OrkcCQBncggpXiYAdVxWYn/AYBU4
UmK7Vb6RdEiwD140Q51SX2fh7DVVo/YSRPEgCB4QLPRfZiGKkzscIqsmxV/mOqio
pNtIY5XReEQ1nBmFk0Kyf14C/q7nK89SYzhu+Frdruy7GnJ4gB3PooUWLUvmEEzh
S3zGvLqEDynPaIyCjKOCS9QegWOz1TPOPDQSYVjjMpBgB4liera/dU+ehaC17TDW
sgysn4Y6m1a9F5ffhyx3Tt5JFNvsyg==
=/XhK
-----END PGP SIGNATURE-----

--aPdhxNJGSeOG9wFI--
