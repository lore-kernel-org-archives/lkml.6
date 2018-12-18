Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109E9C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB56218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeLRTxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:53:04 -0500
Received: from sauhun.de ([88.99.104.3]:48752 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbeLRTxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:53:03 -0500
Received: from localhost (p54B3362C.dip0.t-ipconnect.de [84.179.54.44])
        by pokefinder.org (Postfix) with ESMTPSA id 548912E3542;
        Tue, 18 Dec 2018 20:53:00 +0100 (CET)
Date:   Tue, 18 Dec 2018 20:52:56 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [RFC/RFT 08/10] i2c: exynos5: use core helper to mark adapter
 suspended
Message-ID: <20181218195256.hvmgl5wt3jeebz5k@ninjato>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <CGME20181210210429epcas5p2b545f32165b5025e7cec0b5f5b98f783@epcas5p2.samsung.com>
 <20181210210310.12677-9-wsa+renesas@sang-engineering.com>
 <87b6a87b-92d3-a1eb-b77b-f91651c72270@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lmgdxylq2cyzuy6g"
Content-Disposition: inline
In-Reply-To: <87b6a87b-92d3-a1eb-b77b-f91651c72270@samsung.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lmgdxylq2cyzuy6g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks for testing!

> Similar warning was already there ('HS-I2C is not initialized' message,
> without backtrace) during system suspend/resume. It looks that cpu freq
> is resumed too early, before any device drivers, but this is not an
> issue for this patchset.

Yes, this is actually a desired outcome :) Raise awareness if the
suspend/resume ordering has issues.


--lmgdxylq2cyzuy6g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwZUBQACgkQFA3kzBSg
KbaehxAAm4Uf0X43KMdWHwO/Iyha2jVgfyVJCnEMNu0j2wFzirDaaKvmPNyDqFyS
BRhqzCjVsl00sECsaLGQLn0WB1geFHvyj7IPjVy51zaunuPVosslaZsjaS6+TLui
x8IY3u5GxRT4MW6siGMqa8iyjZQ3F0Yk8ZmIhoFvaDC14J/7XGAkkKaNxEkA8KZD
kRCTbdXYnHiwegDOZ8sorv4XNCXynvNyJ7SIuy0aaaipJG/iqIlrED3Bc2+PFz/A
LZuVHv5/mPLSdXddNJ4hIi7cEfJN6n48Ey/XaMBOzHlFBcxpMFeOOpzO7YsNnqfa
SYRqYR315lD3oKP3VCQMGKqmM3AVXMy1rAbC8LnV2Q1GEH6+PWrUPC02IAgOtce9
n2EL+rxgPwepc3ttBspZWldmXX7rbjL7jI9fSKqT71jVugMNGhYz7avM8UkzpjWR
AVAKRS/+E0TW1triR0/vkl4i6UDw3yr47/vyOacrnGpnyU6MYgtJ3kqRICf51Yos
xCltgDSelxBMHPrARsQvuv1sHw9EyEFAIDXbA2Y2h/uMY17saFA+XFhghSsbw4HA
MyGwOHVeQp0dMsWG7llpvGdZBRkodI+5lEpdbC1Uxz51DKJnCiEEHRdE/vpDsDOf
0oK6W91eX5/cWTCvbZUpcW8dY7XAFS7XK2Mi7Lis8hGxoLJOHc4=
=ZoGD
-----END PGP SIGNATURE-----

--lmgdxylq2cyzuy6g--
