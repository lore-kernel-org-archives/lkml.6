Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C838C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AD542186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 18:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549476773;
	bh=tOHWVdGZyCMuHxw+PMw5719tqdYLXhKjImHo0BGmhGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=se/aH0y7JHFaVTABuB6du5J+4Bx0R+39Ot9XKSn+im6lbppuWmK8+/7+jf5lot7JJ
	 CeG9UlgnEr7WrfY/P9XjoK83BfmphMwi9CHJ6nHaWYAfvymGZPGUVaCDprXpPcsXNg
	 DsQtptRftD2Ljf1Fg710MSfDelZaMAjRY+CZW9nU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbfBFSMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 13:12:51 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58016 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBFSMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 13:12:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZFrYcOCrju52R4Oi7pIddbPhnGQYikaA5Hytyh3ovao=; b=VO/RLznV/kUT8iAex2DrbED6m
        yw/K2hupp4Y+B3buUx2HrVumWOhF9NnZ2eeeLfVbvAYuESl/bhc+ZtkmmsZ8TBsWs7wdW5OPCD6A3
        +upM7aHKL9eXIycB+LVqtZJThgkD0y/FPrKRTAQL/U/jJPaVdm+u/CJMyGXppbkIDCZPk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1grRgd-0007Wb-LM; Wed, 06 Feb 2019 18:12:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1BAFF1127EA3; Wed,  6 Feb 2019 18:12:39 +0000 (GMT)
Date:   Wed, 6 Feb 2019 18:12:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] ASoC: codecs: Add jz4725b-codec driver
Message-ID: <20190206181239.GG17630@sirena.org.uk>
References: <20190205031108.26171-1-paul@crapouillou.net>
 <20190205031108.26171-6-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aYDVKSzuImP48n7V"
Content-Disposition: inline
In-Reply-To: <20190205031108.26171-6-paul@crapouillou.net>
X-Cookie: In space, no one can hear you fart.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aYDVKSzuImP48n7V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 05, 2019 at 12:11:08AM -0300, Paul Cercueil wrote:

> --- /dev/null
> +++ b/sound/soc/codecs/jz4725b.c
> @@ -0,0 +1,599 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * JZ4725B CODEC driver

Same comment for the headers here.  Otherwise this looks good so I'll
apply, please send an incremental patch for this.

--aYDVKSzuImP48n7V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxbI5YACgkQJNaLcl1U
h9CURgf8Dehf5vAADGzm1GJerBtsOudWhj1kUeXepRUC5ifgU6/kiw2kJkeJzy0y
BKvvQz343uPdCR5bNmXDq4qGHccrLRdPHYASj+p1v7GjvN7NOBbyQttzIxgQ2lFD
gG8a0DEpm79gBAaFygl3QPIsF7EGRPbpxNQBH5cZ3ZM0EitFIOPTACJ3B+QeFJT1
9ntC1mGtMDmO/ULC+uiLdJCyRzIaAEZ5tKzawMqhOMdNdQt92Y6lYm7GKNPdS/EO
reIi01FUNtsqjp10OOn2knan/h0RosOX7HZTxrJUl0ueZ8qmxW5ysJ47rOwgoTmA
jKkBumtdLNpZBBZuXF2xjvhbJH/hEA==
=k7ew
-----END PGP SIGNATURE-----

--aYDVKSzuImP48n7V--
