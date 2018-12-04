Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F0EC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159432082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159432082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbeLDJSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:18:06 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48478 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbeLDJSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:18:05 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BB16B20757; Tue,  4 Dec 2018 10:18:02 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-63-158.w90-88.abo.wanadoo.fr [90.88.18.158])
        by mail.bootlin.com (Postfix) with ESMTPSA id 71E5B207BF;
        Tue,  4 Dec 2018 10:17:23 +0100 (CET)
Date:   Tue, 4 Dec 2018 10:17:23 +0100
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
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe.montjoie@gmail.com>
Subject: Re: [PATCH v2 04/14] dt-bindings: rtc: sun6i-rtc: Export internal RC
 oscillator
Message-ID: <20181204091723.p2cvqzmsnnogxxfc@flea>
References: <20181203145825.20511-1-wens@csie.org>
 <20181203145825.20511-5-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ui42vfi36ynka5nl"
Content-Disposition: inline
In-Reply-To: <20181203145825.20511-5-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ui42vfi36ynka5nl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 10:58:15PM +0800, Chen-Yu Tsai wrote:
> Experiments showed that on at least the H3/H5/A64 the RTC's internal
> oscillator also feeds the CPUS mux in the PRCM.
>=20
> Export this clock through the device tree, instead of having to use
> a dummy fixed-clock device node, for the PRCM to consume. This will
> properly describe the relationship between the clocks.
>=20
> Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ui42vfi36ynka5nl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAZGIwAKCRDj7w1vZxhR
xcFyAQDQuWp+4AZRf3U61cakgx80JWbzOy9Eyg/mXLvkSWwcMAEA5zH4GrhdQXjl
yXDZofIYjsReyGlYhmvQjFCUPJUkxA0=
=390t
-----END PGP SIGNATURE-----

--ui42vfi36ynka5nl--
