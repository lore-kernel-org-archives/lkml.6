Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6DDC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBFF214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfBDJcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:32:19 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44751 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfBDJcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:32:19 -0500
X-Originating-IP: 90.88.147.226
Received: from localhost (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 4CC8DE0004;
        Mon,  4 Feb 2019 09:32:14 +0000 (UTC)
Date:   Mon, 4 Feb 2019 10:32:14 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chris Blake <chrisrblake93@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mmc: sunxi: Disable HS-DDR mode for H5 eMMC
 controller by default
Message-ID: <20190204093214.7zbomq5cddacdrmj@flea>
References: <20190203155628.16767-1-wens@csie.org>
 <20190203155628.16767-2-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zfeanym3wm2ugnka"
Content-Disposition: inline
In-Reply-To: <20190203155628.16767-2-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zfeanym3wm2ugnka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 03, 2019 at 11:56:26PM +0800, Chen-Yu Tsai wrote:
> Some H5 boards seem to not have proper trace lengths for eMMC to be able
> to use the default setting for the delay chains under HS-DDR mode. These
> include the Bananapi M2+ H5 and NanoPi NEO Core2. However the Libre
> Computer ALL-H3-CC-H5 works just fine.
>=20
> For the H5 (at least for now), default to not enabling HS-DDR modes in
> the driver, and expect the device tree to signal HS-DDR capability on
> boards that work.
>=20
> Reported-by: Chris Blake <chrisrblake93@gmail.com>
> Fixes: 07bafc1e3536 ("mmc: sunxi: Use new timing mode for A64 eMMC contro=
ller")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zfeanym3wm2ugnka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFgGngAKCRDj7w1vZxhR
xQ34AQDDlWTar1du3xFEC1e1fJUNS/H5WIpD1xoqSDIRRTEesAEA/4Yh32/qyqFY
sofCnWYe+scJvJ0D+ZPFcyfJje6uDQc=
=os86
-----END PGP SIGNATURE-----

--zfeanym3wm2ugnka--
