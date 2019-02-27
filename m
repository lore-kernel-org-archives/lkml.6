Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDB0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD26120842
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfB0JXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:23:12 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:40875 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfB0JXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:23:11 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id BE7EC40011;
        Wed, 27 Feb 2019 09:23:07 +0000 (UTC)
Date:   Wed, 27 Feb 2019 10:23:07 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH] arm64: defconfig: Enable SPI_SUN6I
Message-ID: <20190227092307.r77fbp3vfkyty7f7@flea>
References: <20190226072812.10628-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wwr63nvtmk3ab2vv"
Content-Disposition: inline
In-Reply-To: <20190226072812.10628-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wwr63nvtmk3ab2vv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 12:58:12PM +0530, Jagan Teki wrote:
> Enable SUN6I SPI controller for Allwinner ARM64 SoC's.
>=20
> This would helpful to setup spi flash, for another booting source.
> mark it as static since it require during boot.
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Queued for 5.2, thanks

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--wwr63nvtmk3ab2vv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXHZW+wAKCRDj7w1vZxhR
xTRCAQDH6tHw4V7vNnxw+VGQD/Agj47GQYtLU6vdtUOBFZeSEAEAtPrWyGgWz7sN
zhvFSYmLiG/GPTfQ1f0qtQ6KfQHVIg0=
=2X8e
-----END PGP SIGNATURE-----

--wwr63nvtmk3ab2vv--
