Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964D8C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C17217B7
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 21:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C17217B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbeHDXGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 19:06:39 -0400
Received: from sauhun.de ([88.99.104.3]:58902 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbeHDXGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 19:06:39 -0400
Received: from localhost (p54B337AD.dip0.t-ipconnect.de [84.179.55.173])
        by pokefinder.org (Postfix) with ESMTPSA id 2340A684DB9;
        Sat,  4 Aug 2018 23:04:41 +0200 (CEST)
Date:   Sat, 4 Aug 2018 23:04:40 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     robh+dt@kernel.org, afaerber@suse.de, linus.walleij@linaro.org,
        linux-i2c@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, andy.shevchenko@gmail.com,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com
Subject: Re: [PATCH v8 2/6] arm64: dts: actions: Add pinctrl definition for
 S900 I2C controller
Message-ID: <20180804210440.6fw4zrvk6lzawypc@ninjato>
References: <20180801180232.23680-1-manivannan.sadhasivam@linaro.org>
 <20180801180232.23680-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fv2klmawh3m7wxmq"
Content-Disposition: inline
In-Reply-To: <20180801180232.23680-3-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fv2klmawh3m7wxmq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 01, 2018 at 11:32:28PM +0530, Manivannan Sadhasivam wrote:
> Add pinctrl definition for Actions Semiconductor S900 I2C controller.
> Pinctrl definitions are only available for I2C0, I2C1, and I2C2.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Note that I don't take DTS patches, so skipping patches 2-4.


--fv2klmawh3m7wxmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltmFOgACgkQFA3kzBSg
KbbPeRAAlxaoWb347PEo/yMDhYX+Oaj3u4Ib2D2iF3IB7+bWV0AIhP5bVkx7wlmn
wYmoBv36qsPXsVRDH/OGX1aqMO07Vnsfx7ocBCp4ng2j1tdngE50nPirGFWx5fPH
pm0Vfy/FEy1GNz8ZDsndEyMt3bX7U4ELE06nSXcl4lbO29hVZCvMi+AlrCd6i+KO
rsJu8UuGOVLJNbtVDz5JLdv5aReDvReUWhrKkK7JwyKCdGtuC01K6pURDtIw/KCy
/0gcu5mLm67GsPhY8cqTy13QHhLFmSZZbmz7sWysa9NgFrnjx1m8Yut5vQ0J+wYw
TvNEdK6Br6LDV+6sp0VJIX7AiSDIyzk9STjvUq3g1lL1OcS/+4/P2IVBMwJFveg5
IeG2BuE19UQupoqIFZVU74tv7k2SraBaeiq5tTdGr3Oh5lvDOnCZOTJvO9fbXFN4
GO+GN76/u2PaQevA0ccDXm4GKvqoD+9pNnCxBYw6Cqwz2kUDAb9fBkKIGxENJszr
uSxyeLy10hxBEO46PABIa6SghEb92zBAfXJaGevTO8BFPpf7qujb1JPB25j8u/sN
hZ3ddP+/SiyXeLPuDidlJ1XdYNMQSnUHyxs9c9U33My0KjS4ZBmqutA6UKP/Slxo
+r/SdjpCfQuPdM6Cd0yXf8B207fJIb60cX30x8Dkc574KrIIjb8=
=YNDl
-----END PGP SIGNATURE-----

--fv2klmawh3m7wxmq--
