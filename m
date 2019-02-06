Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC87EC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F592175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfBFMTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:19:31 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34479 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfBFMTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:19:31 -0500
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 5CF246000F;
        Wed,  6 Feb 2019 12:19:29 +0000 (UTC)
Date:   Wed, 6 Feb 2019 13:19:28 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: a64: Enable PMIC power
 supplies on various boards
Message-ID: <20190206121928.6t2sawpqsmf6buv3@flea>
References: <20190205150040.12343-1-wens@csie.org>
 <20190205150040.12343-2-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jf7jxt6isqtwx3zl"
Content-Disposition: inline
In-Reply-To: <20190205150040.12343-2-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jf7jxt6isqtwx3zl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 11:00:40PM +0800, Chen-Yu Tsai wrote:
> On these A64 devices, the DC input jacks are wired to the ACIN pins of
> the PMIC, which is represented by the AC power supply. With the
> exception of the Nanopi A64, all devices include LiPo batteries or have
> connectors for them, which are represented by the battery power supply.
>=20
> Enable these power supplies in the device tree.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied both, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--jf7jxt6isqtwx3zl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFrQ0AAKCRDj7w1vZxhR
xdAKAP9fz6ckXKwqb4cq4wgG3yp4QtxUn/nRE2+12D3r4GyYuAEAnOpwyf5VId9/
6sqPb0u3JsgWuwAicwCXbsTIpiWBOw0=
=pSt1
-----END PGP SIGNATURE-----

--jf7jxt6isqtwx3zl--
