Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FF9C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0802F2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0802F2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbeLKIit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:38:49 -0500
Received: from mail.bootlin.com ([62.4.15.54]:39265 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbeLKIit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:38:49 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 44F4B20723; Tue, 11 Dec 2018 09:38:47 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1524020717;
        Tue, 11 Dec 2018 09:38:37 +0100 (CET)
Date:   Tue, 11 Dec 2018 09:38:37 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Fix the video engine
 compatible
Message-ID: <20181211083837.xskoxru6rokwjnf6@flea>
References: <20181210101429.21512-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7ogwtdmvudx3xb24"
Content-Disposition: inline
In-Reply-To: <20181210101429.21512-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ogwtdmvudx3xb24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2018 at 11:14:29AM +0100, Paul Kocialkowski wrote:
> When introducing the video-codec node for the video engine, the
> compatible for the H5 was used instead of the compatible for the
> A64. Use the right compatible instead.
>=20
> Fixes: d60ce24740d2 ("arm64: dts: allwinner: a64: Add Video Engine node")
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Queued as a fix for 4.21, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7ogwtdmvudx3xb24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXA93jQAKCRDj7w1vZxhR
xZ3KAQC7nyAgEKtXvl5hldByPUKjCr7UEvtwjI8fWHBevflYgQEAr/4S7Layyixy
gfJUWiGBh9uC/ypi1D+5Vl10+vsingU=
=sQ9p
-----END PGP SIGNATURE-----

--7ogwtdmvudx3xb24--
