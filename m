Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8252C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949D0217D9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 13:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546521084;
	bh=4j3MsaLKM866eRO56+lwzET+Zudxn5tiJ2gwONI5xxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ttUzffkHK6UZtPL/IPnDqvEx7yrxWfkWZKprX5Yynxjdr1JD7/mMce5k+LTTOOshN
	 YUP7Kk1kzHyf85zGWxgj1ysmd2t04Mp8AvXTk4Ic6R7HztwfX+JcNCNhmQ+M1Sqz6W
	 ar7ztNMyLvGGmzzYjfG7tbkTxOWp8J4J4JR+DVaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbfACNLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 08:11:23 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36424 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730675AbfACNLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 08:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2eDQ4bVlRXsycjE1X7GXc2V755O1XKU4dZz7BmFpzFQ=; b=HyxSUxL4s0MPbKNA2zXoUDV+r
        veeKbBiwt0yi6GoGczL0K9YF7Rf/AtrXLrRwquQ8hyVUaDn9//03f7mfWVeDNo66dQuL/TP+Y4Qwm
        1MdbzBQV6vupMk/oCCk6YOZlQmESUePWRHuFjGzEu6eMq3WNH6tAgUs7Wm+U9Fk1TgayM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gf2le-0005YZ-8R; Thu, 03 Jan 2019 13:10:34 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3AB6D440080; Thu,  3 Jan 2019 13:10:33 +0000 (GMT)
Date:   Thu, 3 Jan 2019 13:10:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu,
        Bard Liao <bardliao@realtek.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In function rt274_i2c_probe(), if the regmap_read fails.
 The variable "val" could leave uninitialized but used in if statement.
Message-ID: <20190103131033.GU1846@sirena.org.uk>
References: <20190103023839.15314-1-yzhai003@ucr.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1YSLKY9nNiKnepPi"
Content-Disposition: inline
In-Reply-To: <20190103023839.15314-1-yzhai003@ucr.edu>
X-Cookie: knowledge, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1YSLKY9nNiKnepPi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2019 at 06:38:39PM -0800, Yizhuo wrote:

>  	int ret;
> -	unsigned int val;
> +	unsigned int val =3D ~0;
> =20

This just shuts warnings up which may mask further problem, it is better
to just leave it and fix the users.

> -	regmap_read(rt274->regmap,
> +	ret =3D regmap_read(rt274->regmap,
>  		RT274_GET_PARAM(AC_NODE_ROOT, AC_PAR_VENDOR_ID), &val);
> -	if (val !=3D RT274_VENDOR_ID) {
> +	if (ret || val !=3D RT274_VENDOR_ID) {
>  		dev_err(&i2c->dev,
>  			"Device with ID register %#x is not rt274\n", val);
>  		return -ENODEV;

If the read returned an error we should pass back the error code we got
=66rom it, not mask it with another error code.  This is especially true
here where the error message would be very misleading if there's a
problem with I/O.

--1YSLKY9nNiKnepPi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwuCcgACgkQJNaLcl1U
h9ATcQf/eBbwaS5qgEtEK51OPB3FNB6vrxxUk5HGFZqdFxZQVgcz3XNeMEDhcccS
cKGpg1ksiEpLIog6GK6KmLkHrfiA8aWoHhkuDGxMnogfySqU9qA3V8LbQoBGAh56
x3tnhky9Iuyj+Wcj0WKw00dsBlDxrorF3z9297WkFsopR3J7Sd7OHZjQFYopthin
mhAuUkwTfP1QQDANxH3AciBZwA8CJQQ+XqB/ORavzZqWfi8znP9NnN+fdOuHzqWK
qbzU2aLsWFiGzfOxFUjyJTWSr0UlgKTE8YpORTWNsSQhYTchJLnwAqStlaFW00VA
Dczuw8DOS8aDFgHNENAmUUhiSv0KpQ==
=D6U7
-----END PGP SIGNATURE-----

--1YSLKY9nNiKnepPi--
