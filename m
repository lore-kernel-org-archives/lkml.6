Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC10FC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3A921019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548258701;
	bh=r4E+pvCqUihapAdoUwLnde00TByPhh0Nlj5vkksNEe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DJJDuKfcw3riVp8N1B8VqOzPhnnVM3hu4MNZIykH2awNFCRu2P40JsKZQHD85OqZu
	 hIXFyTkFdJIGtbPZ84R7nYepy/VUILrdkKcleXkObhMlInkMO/zwBPSGlF57K4LSSJ
	 EktcDyVl7UmtYT6T6HyMHRAGc0wI+QTYqXWIoyaY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfAWPvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:51:40 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59758 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAWPvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:51:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r4E+pvCqUihapAdoUwLnde00TByPhh0Nlj5vkksNEe4=; b=Zzs14wmoOPJ5EHWjT7qTKo53y
        pM4aRzA4KXipACZUFesROAwQLGBdUD5HII1S3rsStdtCVD/V47DnG9EbXeZoe5wJFVEpuHukWtkoy
        uOZMynXOh2ky59NaxW3kRWM+LPJpdC98KGbBNznZ1Hat9BGL6YLKb9mGFifzo1y72vhUc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmKoE-0005oX-0P; Wed, 23 Jan 2019 15:51:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2678B1127ABA; Wed, 23 Jan 2019 15:51:21 +0000 (GMT)
Date:   Wed, 23 Jan 2019 15:51:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lgirdwood@gmail.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        sre@kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, wim@linux-watchdog.org,
        linux@roeck-us.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [RFC PATCH v1 03/13] regulator: bd718x7 use chip specific and
 generic data structs
Message-ID: <20190123155121.GB7503@sirena.org.uk>
References: <cover.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
 <3fb3eab3a8a2767404588d0a0a531273fddfc659.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <3fb3eab3a8a2767404588d0a0a531273fddfc659.1548149337.git.matti.vaittinen@fi.rohmeurope.com>
X-Cookie: A couch is as good as a chair.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 11:43:28AM +0200, Matti Vaittinen wrote:
> Header rohm-bd718x7.h was split to generic and component specific
> parts. This changed the struct bd718x7. Adapt the regulator driver to
> these changes.

Acked-by: Mark Brown <broonie@kernel.org>

Does this need to be squashed into the earlier commit for bisection?

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxIjXgACgkQJNaLcl1U
h9A/Twf8Cy6U369BDxcnv/21rcw0n0Uj1AO6jYJvFLlzmp5afcCluF69AVR0MDaA
CqMU/8FU5UJ49/CUW9IP1pq3ZPiUB/6ro7fty0LmKuAvJ52BdzEXIAaSyFO/qBuI
urEIErNz+20P439mtrwRXjwelnkOvOTq1UcIqRGSFvQIgDJzHrqfwvG/gDTPz+zy
FfZ3Cwg/FzkGEy9BMxgfObERG0xQ3TMzBVjFf4AWw/aqhoU8xl6wt6lu4sy16GM+
k9/OZ0vcgINI1RW+/xedkwvvgx/OpyLpiLyxevKVxMaQIGPBRq4cBjEs39SnWo8z
PbDTVv2+1yyNZGTzEh7mg47Aic1MvQ==
=nP4q
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
