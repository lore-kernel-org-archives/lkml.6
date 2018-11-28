Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD57C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D1420832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 10:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01D1420832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbeK1VaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 16:30:05 -0500
Received: from mail.bootlin.com ([62.4.15.54]:47859 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727690AbeK1VaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 16:30:05 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E5D1C20DCB; Wed, 28 Nov 2018 11:28:53 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id AE27C20D2E;
        Wed, 28 Nov 2018 11:28:17 +0100 (CET)
Date:   Wed, 28 Nov 2018 11:28:17 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 14/15] ARM: dts: sun8i: r40: Add RTC device node
Message-ID: <20181128102817.4xzxlvrxxstca6dj@flea>
References: <20181128093013.24442-1-wens@csie.org>
 <20181128093013.24442-16-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="akhquq7vtaqev4k2"
Content-Disposition: inline
In-Reply-To: <20181128093013.24442-16-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--akhquq7vtaqev4k2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 28, 2018 at 05:30:12PM +0800, Chen-Yu Tsai wrote:
> The R40 has an RTC hardware block, which has additional registers
> that are not related to RTC or clock functions, and is otherwise
> compatible with the H3's RTC.
>=20
> Add a device node for it, and fix up any references to the LOSC.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--akhquq7vtaqev4k2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/5twQAKCRDj7w1vZxhR
xd3SAQC7nWY6/rjZZwKbiB4XciGOCQ3P5kCYL0bq5k6aBgu5xAEAjwDqH4mz8olk
kAG5Ucvi7jZhPqrLY7OD9PHE+lxq5wQ=
=43r4
-----END PGP SIGNATURE-----

--akhquq7vtaqev4k2--
