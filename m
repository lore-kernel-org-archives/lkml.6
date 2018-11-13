Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A3BC169D4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E86C5224E0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="G2F260+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86C5224E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbeKNFpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:45:11 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50362 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbeKNFpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:45:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8icOWRIFM81Z0TmlR99JEuB8jGVaquMTYdVYqlXw5W0=; b=G2F260+2YZC+IJKsjY52aBoS+
        CuKdKxvbsmwJ9yU1mvYWwx3KCItrMoemtAemAtCblX9vPdWDs0/HupWScVwSyrm4tQP6lq3hSyMxl
        DPX43SCFHbnE3/MBX3NEVMr2QiYr+6og+Mii84haOmZob8JuAwuESIhbXOR6BGYIcTaJg=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMecl-0002Uy-GQ; Tue, 13 Nov 2018 19:45:23 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 7EBD8440078; Tue, 13 Nov 2018 19:45:17 +0000 (GMT)
Date:   Tue, 13 Nov 2018 11:45:17 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Alexander.Deucher@amd.com, Vishnuvardhanrao.Ravulapati@amd.com,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 11/11] ASoC: amd: enable acp3x drivers build
Message-ID: <20181113194517.GM2089@sirena.org.uk>
References: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1542000903-19020-12-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vTfKKTivj/mQoluA"
Content-Disposition: inline
In-Reply-To: <1542000903-19020-12-git-send-email-Vijendar.Mukunda@amd.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vTfKKTivj/mQoluA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 12, 2018 at 11:05:02AM +0530, Vijendar Mukunda wrote:
> ACP3x drivers can be built by selecting necessary kernel config option.
> The patch enables build support of the same.

Apart from the SPDX headers this all looks fine so I've applied it,
please send followup patches converting everything to SPDX headers.

--vTfKKTivj/mQoluA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrKcwACgkQJNaLcl1U
h9Bragf/VRhhS03dy0CO8cJ4szZu8pDQNzib4mOabLCFqlvyZcEEJLHf/dwPsljS
avYm1xO/PwI5pa/stGeliZUzkanQjZOPNhDcW9dZ6fXG2Q6KmR7ZsQaVY1UIdBxb
fHYz9lQjueakYg0Cb6LFxmVA6ooXtiJkC0xekqh4GUEzCLXLPugK/x9HVPE9S7HK
CicfPuvGJqyK+LO0bXdUQU1/h3UorOyClbZRhLlBCtLy2G/N+Vsp9PV+aaA9OtLI
y2si+8Ms14Nb4X7WhMixinUTF2ggdASem3vb/VfIlT8pPSraMwm+5makHS1UgF9h
JKg/9K8usJr8rSKjgAmBrWZqA5SPjA==
=XiPi
-----END PGP SIGNATURE-----

--vTfKKTivj/mQoluA--
