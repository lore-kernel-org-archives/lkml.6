Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31C8C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98FF2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfA1KxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:53:20 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50143 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfA1KxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:53:20 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 24986209BD; Mon, 28 Jan 2019 11:53:18 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id D12A9209EF;
        Mon, 28 Jan 2019 11:53:07 +0100 (CET)
Date:   Mon, 28 Jan 2019 11:53:08 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] ARM: dts: sun5i: q8-tablet: Add LCD Panel power
 supply
Message-ID: <20190128105308.jynl4hdptiprkhqo@flea>
References: <20190127144838.3578-1-wens@csie.org>
 <20190127144838.3578-5-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nzgdkp24ycyqpod3"
Content-Disposition: inline
In-Reply-To: <20190127144838.3578-5-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nzgdkp24ycyqpod3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 27, 2019 at 10:48:37PM +0800, Chen-Yu Tsai wrote:
> The A13 Q8 tablet, following the A13 reference tablet design, has the
> system's fixed 3.3V rail feed the VCC supply of the LCD panel.
> Additional voltage rails used by the panel are generated using a
> regulator fed from the unregulated IPSOUT output of the PMIC. The latter
> is unrepresentable in the device tree. Both are controlled with MOSFETs
> by the enable GPIO added in the previous patch. The actual enable or
> reset pin for the panel is tied directly to LCD-VCC after the MOSFET.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nzgdkp24ycyqpod3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXE7fFAAKCRDj7w1vZxhR
xTsJAP4lShKIc4E7kP7BDzoBlb9H7+MuXbm+Z4cAOHdUngD7yQEA6DWAGlYD+iM7
nuxiy1NvZe3U96ZAy8XnBMpC6eNj3wk=
=wHYU
-----END PGP SIGNATURE-----

--nzgdkp24ycyqpod3--
