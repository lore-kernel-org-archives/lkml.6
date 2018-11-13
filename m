Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D50FC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA29208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 18:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="kZL5kBQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA29208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbeKNECp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 23:02:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48296 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732091AbeKNECp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 23:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=soiV/L8zGf9njTPHnYA7qbWKZB4CgnQMvZEoXtPQcNI=; b=kZL5kBQxBs+8jSJsDuCUJvXbm
        wgAHhcVF7P0HjUqa2VfB4jCiz2HcFgEUkREF955E8oN7eGfMmPAGbwxho51E7QI4dY4238T9qkBcc
        biawdXewhNP+oP9LWQtB8NR9j9iJrW7/PfLACT7s/MvP4ZgP5P+fowQugZGS4DRrjKHOI=;
Received: from [64.114.255.97] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gMd24-0002Mn-OK; Tue, 13 Nov 2018 18:03:24 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 85331440078; Tue, 13 Nov 2018 18:03:18 +0000 (GMT)
Date:   Tue, 13 Nov 2018 10:03:18 -0800
From:   Mark Brown <broonie@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Eric Anholt <eric@anholt.net>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Florian Kauer <florian.kauer@koalo.de>
Subject: Re: [PATCH 17/17] ASoc: bcm2835-i2s: Switch to SPDX identifier
Message-ID: <20181113180318.GE2089@sirena.org.uk>
References: <1541869351-8499-1-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Content-Disposition: inline
In-Reply-To: <1541869351-8499-1-git-send-email-stefan.wahren@i2se.com>
X-Cookie: No Canadian coins.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 10, 2018 at 06:02:31PM +0100, Stefan Wahren wrote:

> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * ALSA SoC I2S Audio Layer for Broadcom BCM2835 SoC
>   *

Please convert the entire comment to a C++ one so this looks more
intentional.

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrEeUACgkQJNaLcl1U
h9ACjwf/WDuKVcSi2mNxYSryYZ+0wU8RdjLV5swZM/PlA+7dQ/ufaaH47xCTVMXE
6+j36aLoXcJT+Z78C7CQjn6RNm1+T7I+k71Jqnu4C8eWHvxPs2TTBE4+8uVUpDGb
JSBGC1r0UblndJYL2r0/ksZOHraoy96XvDCeoefOFstw2m2YizFvrEJNut3zEv2u
7CdABvi/sSMtRj3lPfAkcxh2ZDfp97WwDicZsulrEWNfkZXnhUs/GSnVdJCK5OWX
t8KQUjNRZHEYJS+zptUjIr64krJXnvI4/BavI0PtHMC/LfUO39FkWWJ9NGdwoXH0
HTttU8MclkINtXsaNXnKA+01392+ag==
=lQyP
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--
