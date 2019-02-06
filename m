Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D33C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8782073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbfBFMUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:20:50 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:59109 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfBFMUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:20:49 -0500
Received: from localhost (unknown [185.94.189.187])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id A5E39100007;
        Wed,  6 Feb 2019 12:20:46 +0000 (UTC)
Date:   Wed, 6 Feb 2019 13:20:46 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chris Blake <chrisrblake93@gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: allwinner: h5: libretech-all-h3-cc:
 Mark eMMC HS-DDR 3.3V capable
Message-ID: <20190206122046.ph66qe4bhtlz4qup@flea>
References: <20190205154225.14264-1-wens@csie.org>
 <20190205154225.14264-4-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ubfrzttee5yydn45"
Content-Disposition: inline
In-Reply-To: <20190205154225.14264-4-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ubfrzttee5yydn45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 11:42:25PM +0800, Chen-Yu Tsai wrote:
> The Libre Computer ALL-H3-CC H5 is one of the few boards that can have
> its eMMC run at HS-DDR speed mode. Mark it as such.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ubfrzttee5yydn45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFrRHgAKCRDj7w1vZxhR
xYywAP4kk/mZ9wOcV1YFBGrPd7uvJkpQAFJ2hfVGWku8yJFSyAEAx92O9TcsSIFv
WVTM+UyQ6ODCH72P3ukkjYDtswxmIwk=
=rmqF
-----END PGP SIGNATURE-----

--ubfrzttee5yydn45--
