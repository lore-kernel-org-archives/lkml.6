Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EE1C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B2B20657
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfAJHER (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:04:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:34874 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfAJHER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:04:17 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B697520A16; Thu, 10 Jan 2019 08:04:14 +0100 (CET)
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.bootlin.com (Postfix) with ESMTPSA id 830A720729;
        Thu, 10 Jan 2019 08:04:04 +0100 (CET)
Date:   Thu, 10 Jan 2019 08:04:04 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Fix USB OTG regulator
Message-ID: <20190110070404.gmthhqpehllvatp7@flea>
References: <20190109181604.16988-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nrx4fsnyeq3jeufe"
Content-Disposition: inline
In-Reply-To: <20190109181604.16988-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nrx4fsnyeq3jeufe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 09, 2019 at 07:16:04PM +0100, Jernej Skrabec wrote:
> Currently, AXP803 driver assumes that reg_drivevbus is input which is
> wrong. Unfortunate consequence of that is that none of the USB ports
> work on the board, even USB HOST port, because USB PHY driver probing
> fails due to missing regulator.
>=20
> Fix that by adding "x-powers,drive-vbus-en" property to AXP803 node.
>=20
> Fixes: 14ff5d8f9151 ("arm64: dts: allwinner: a64: Orange Pi Win: Enable U=
SB OTG socket")
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nrx4fsnyeq3jeufe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDbuZAAKCRDj7w1vZxhR
xcNNAQCpjQz3/Y9S6ezBZ/Cpt0gKdZJEFq0gBWu+rBA/9Sc3LAD/VauvK1wSERHI
51ycvmN7+U85damhGd9JfgAZmSgebgI=
=mixa
-----END PGP SIGNATURE-----

--nrx4fsnyeq3jeufe--
