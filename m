Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B22C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B646320869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 11:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="I//wZm9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B646320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeJPTtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 15:49:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32952 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeJPTtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 15:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+21rALYQ5lxy1nGQjEB2NZleJYopl90B+gX+W5/nD8M=; b=I//wZm9nbvssQqLHsGXymwQIT
        peHnI+46KhEJ885TsSr5faqUtkwym649sBLGQbk5fOGQ94NmmBvXNzJv8lUmi0PSEO3Pzvm1fNRtQ
        SN8tA9H5xma16ea7e9gD6MHQpuVO5VjbGehCcA2UsButQiVVP69oi4MdIcnSSepS4Touw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gCNzx-0004uL-8Y; Tue, 16 Oct 2018 11:58:53 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D831111223AA; Tue, 16 Oct 2018 12:58:52 +0100 (BST)
Date:   Tue, 16 Oct 2018 12:58:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 0/9] ARM: dts: tegra: last minute fixes
Message-ID: <20181016115852.GE7449@sirena.org.uk>
References: <20181016104730.4598-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a1QUDc0q7S3U7/Jg"
Content-Disposition: inline
In-Reply-To: <20181016104730.4598-1-marcel@ziswiler.com>
X-Cookie: Huh?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a1QUDc0q7S3U7/Jg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 16, 2018 at 12:47:21PM +0200, Marcel Ziswiler wrote:

> Marcel Ziswiler (9):
>   ARM: tegra: fix simple-panel compatibles
>   ARM: tegra: apalis-tk1/colibri_t20/t30: eval/iris: fix regulator gpio
>     enable
>   ARM: tegra: colibri_t20: reorder pmic properties
>   ARM: tegra: apalis-tk1: further regulator clean-up
>   ARM: tegra: apalis_t30/tk1: annotate power I2C being on-module
>   ARM: tegra: colibri_t30: further regulator clean-up
>   ARM: tegra: apalis_t30: further regulator clean-up
>   ASoC: tegra_sgtl5000: fix device_node refcounting
>   ASoC: tegra_sgtl5000: fix platform name vs. of_node assignement

These ASoC patches appear to have absolutely no relationship with the
rest of the series.  Is that the case or is there some dependency I'm
missing?

--a1QUDc0q7S3U7/Jg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvF0nwACgkQJNaLcl1U
h9AFzgf+ITBvjGNS4tK/XQ0Cfn4GUpc11kkK5bQd4bUf3W3bwEnCpTsd6+NfAygz
7wOdbPJcJIbtlUgf2fMQav9od6IEuC4v/1nM9+hCXP0tQo9rQwylSO4WeEmhcrHc
dT9kvMIzzvt3Z4961v7Lrn/1/8YHbC/KV1/2lGnvzY0XiJPbKT3c5HggvDkeeE7W
kwStdeuWl2S1SR2nSqhz1jpQEvu4PZGSNaVHkC8s4wHNFMXZFgjvTTC1vp2TXX2o
HpmqazjTHdg1bptQOJChifkzj6F5RBn9gdKsqdz+T/ThSzOtnq2gY0+wKXwahYvM
g7zfc+XcHzP3Jtg7uEW+WZVaAYXwUA==
=OQtb
-----END PGP SIGNATURE-----

--a1QUDc0q7S3U7/Jg--
