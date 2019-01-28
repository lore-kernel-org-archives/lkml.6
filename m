Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F57C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CD02148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfA1KwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:52:05 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50095 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfA1KwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:52:04 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 86C2C209BD; Mon, 28 Jan 2019 11:52:02 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 51929209A7;
        Mon, 28 Jan 2019 11:51:52 +0100 (CET)
Date:   Mon, 28 Jan 2019 11:51:52 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] ARM: dts: sun5i: Add backlight GPIO for reference
 design tablet
Message-ID: <20190128105152.khovy6x2mug656cc@flea>
References: <20190127144838.3578-1-wens@csie.org>
 <20190127144838.3578-2-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hj3ztet5q4obldvi"
Content-Disposition: inline
In-Reply-To: <20190127144838.3578-2-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hj3ztet5q4obldvi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 27, 2019 at 10:48:34PM +0800, Chen-Yu Tsai wrote:
> Now that we support the GPIOs on the AXP209, we can control the LCD
> backlight with them.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hj3ztet5q4obldvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXE7eyAAKCRDj7w1vZxhR
xQFXAP97Qylt8xIFjhVInbBEf07sHqlYQAhZzNjXVQlyHZlgxQEApHKJH3xahA8G
UqIwJLCRRkzR3hmYAISqngSaoCDu3Ac=
=V19I
-----END PGP SIGNATURE-----

--hj3ztet5q4obldvi--
