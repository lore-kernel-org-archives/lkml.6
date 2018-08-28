Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57312C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE05520851
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 18:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="NjAtYyq7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE05520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeH1V5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:57:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48552 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeH1V5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zezUPnk3PmDKuvk+ymUEkhjioWYRDmbR5XR9K2Dd7BQ=; b=NjAtYyq7x9fleZeeOSGnUmzzT
        qISZQGmKrNFHwKApu2y8ubDtGOMNNgtrJJdxHxIMw1eOxtIsfrR2pvghvsytyixxECRZ33HDOuNXv
        Vd4q+vNFRVOzC8YyLAZNBFtuqUTGQk2d0JgFF1qSQ6Cd8dPP2k511wWTTPvgTYtMAweIo=;
Received: from 94.197.121.178.threembb.co.uk ([94.197.121.178] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fuiL8-0006UJ-Pb; Tue, 28 Aug 2018 18:03:43 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3AF97440078; Tue, 28 Aug 2018 19:03:35 +0100 (BST)
Date:   Tue, 28 Aug 2018 19:03:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH v2] ASoC: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20180828180335.GG2414@sirena.org.uk>
References: <20180828154433.5693-1-robh@kernel.org>
 <20180828154433.5693-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8TMLq6GPUuN4DysL"
Content-Disposition: inline
In-Reply-To: <20180828154433.5693-2-robh@kernel.org>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8TMLq6GPUuN4DysL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 28, 2018 at 10:44:28AM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

Please don't send new patches in reply to existing threads, it makes it
harder to follow what the current versions of things are.

--8TMLq6GPUuN4DysL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluFjnMACgkQJNaLcl1U
h9BnyQf/cdl8XKMk/yZXqmTYdTxNvRvHBV00zFsFCpmSB2fxFPQl9u0BC/JZSMSb
QJ2GfCxUgp1/j2S8iDUSWGCZG6bq/turgrP2m+ZYZeTvA7wsVduGMBYEVqwurAxX
6XNPCGC2ZrvUV89j1fYc4jxXjTC0vPYWnK6M3sZCKqJKP4CTeRxFDyFdBtGlmHdZ
taXllc0H3Kpp8xU5P3zmlwBW4kErt8XwBb/yj3cN0pbJbXqwrOOUTIFXTf3XFg+x
xM3pTAUEZjyhDNQHg+C6yYv8rpf8oqAeu/v7WLj9q4UsQ0y7x3vfxYmlQe7Qt+5Z
BvxDzb2t7uzOrvhRrEhcRSRs5j+EIg==
=Bsjk
-----END PGP SIGNATURE-----

--8TMLq6GPUuN4DysL--
