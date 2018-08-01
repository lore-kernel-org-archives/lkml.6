Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D64C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D0F20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="bz5oMAxm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D0F20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbeHAMgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:36:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35544 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387575AbeHAMgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hF7GYvsO3zIzEXmwyY9Q1LoSUfI59RHx1f8i9whFF+c=; b=bz5oMAxmTOB0u2doFXp6pMMj9
        1X9ATIyrJC13ObeG4WgnvDqLj5uqeRe3ojCi0ZqnrW4EiJ+jXTo0nQnpqIBHkHqrtizzHhsoWN56h
        ufmUzE2ga+weYTVIDYu6kBTKM4W2yPcmeMbuEC05KtXBcDb72pv2nWt1E3a0gOhVsjrus=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fkoj5-0000mG-Rn; Wed, 01 Aug 2018 10:51:31 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1F1591124241; Wed,  1 Aug 2018 11:51:31 +0100 (BST)
Date:   Wed, 1 Aug 2018 11:51:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        srinivas.kandagatla@linaro.org, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] ASoC: qcom: add sdm845 sound card support
Message-ID: <20180801105131.GF5509@sirena.org.uk>
References: <1533114069-16570-1-git-send-email-rohitkr@codeaurora.org>
 <1533114069-16570-5-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rMWmSaSbD7nr+du9"
Content-Disposition: inline
In-Reply-To: <1533114069-16570-5-git-send-email-rohitkr@codeaurora.org>
X-Cookie: You are as I am with You.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rMWmSaSbD7nr+du9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 01, 2018 at 02:31:09PM +0530, Rohit kumar wrote:

> --- /dev/null
> +++ b/sound/soc/qcom/sdm845.c
> @@ -0,0 +1,286 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */

Please make the entire thing a C++ comment, it makes it look more
intentional.

--rMWmSaSbD7nr+du9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlthkLIACgkQJNaLcl1U
h9BBVAf9H4oTxZ8FrcKTi+6zDylOZrUcflwy65D1oUjD/O2ojrKbjzvrLgKQF1EQ
j8DCBTuVk0FWCU+s9JjASBe//po6IWZjV3WFW0c/5F0Ao1ubyqoKjFfISJGn0D8u
K1o/mu51BlqJBv+pehniywwaZdqM2N6iGhzq6uJRorzVtnCF+tthaDJ73m9LV4dK
1PVNETgfMazdDfR8v/d++TrOvFvwDTRke2vyjaZ9H0JrIyEkRrQaF4WFIlYCe3/+
5rI/zL6H87tPHc8uvJ8Nv4YUkTZB/lopaf+sRXpCg96WKvWkEWPKGq+wGOHZejXm
EP2CUWsrZr5edEbVY57U6m6kYD1miw==
=STS5
-----END PGP SIGNATURE-----

--rMWmSaSbD7nr+du9--
