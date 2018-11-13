Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA32AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA66621582
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="t5Bj+MQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA66621582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbeKNFgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:36:02 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35002 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeKNFgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:36:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oOqcroex1tPs/2DHhvnFl0UwdwyLDVSzPLLsXWm5uCQ=; b=t5Bj+MQB3eeFCIN4Gq0u9aVzf
        eiKB7RV0iKnUPEwcG5lfICYJ+4fVRktApGngLHpsTROTd5VoYptZV5qIZO77uKXLNcvrtaCdP/J4O
        6zNw0BHyDRXM+cwJBmiO3a+bqO032+bql23EQl8a+BfQecuetWYIiohq6nYtf4KbfYvBc=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMeTy-0002UP-QT; Tue, 13 Nov 2018 19:36:19 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id CBE0D440078; Tue, 13 Nov 2018 19:36:12 +0000 (GMT)
Date:   Tue, 13 Nov 2018 11:36:12 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc:     Alexander.Deucher@amd.com, Vishnuvardhanrao.Ravulapati@amd.com,
        Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 01/11] ASoC: AMD: add ACP 3.x IP register header
Message-ID: <20181113193612.GK2089@sirena.org.uk>
References: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1542000903-19020-2-git-send-email-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UlsYxwg8UDQn+EKZ"
Content-Disposition: inline
In-Reply-To: <1542000903-19020-2-git-send-email-Vijendar.Mukunda@amd.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlsYxwg8UDQn+EKZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 12, 2018 at 11:04:52AM +0530, Vijendar Mukunda wrote:

> @@ -0,0 +1,655 @@
> +/*
> + * ACP 3.0 Register documentation
> + *
> + * Copyright (C) 2016 Advanced Micro Devices, Inc.

Please use SPDX headers on new files.


--UlsYxwg8UDQn+EKZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrJ6wACgkQJNaLcl1U
h9A8Qwf9ETej1fTRkd2dbKa04Ypx0+iHUnJI6YKM0jJPY4kMfhS1py1AQfwzfPQN
Rk20lF/6Puc80Y/YCif7bGrmbkPEb5iA/RpC0EV7PcVOjJOK4h+FiXh7vcUTA3Bx
BHW65YU5q5kmE+4mmbCESdL5EUld9xA6KcpV99fX7iQ74SPy4tTLzS1oI0azCVwL
Fi1L407CkWu1WvNo/5DySSaHfHj1AU3GtxDE5elGex7VCzNbTfzO14szVcyD2YuI
zi2bJZZGySstQvXMlXLVu/7rMLxSjXGc7Ro/mM2BWrIEIj7mVfRIJWQefQ9udJfH
JkMsaXcaILEMa/dOjEPDgmlTBOiJkQ==
=YxuY
-----END PGP SIGNATURE-----

--UlsYxwg8UDQn+EKZ--
