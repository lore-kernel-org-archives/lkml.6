Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B76C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B12D21738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfAIKLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:11:50 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38703 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729281AbfAIKLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:11:49 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8C54020A2A; Wed,  9 Jan 2019 11:11:47 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5366920A08;
        Wed,  9 Jan 2019 11:11:37 +0100 (CET)
Date:   Wed, 9 Jan 2019 11:11:37 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun6i: Add clock-output-names to osc24M clock
Message-ID: <20190109101137.sh6ioyvq5wm6ug23@flea>
References: <20190108072526.2621-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nrrmjmmauuftwoov"
Content-Disposition: inline
In-Reply-To: <20190108072526.2621-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nrrmjmmauuftwoov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2019 at 03:25:26PM +0800, Chen-Yu Tsai wrote:
> The osc24M clock does not have a "clock-output-names" property, which
> means that the clock name is derived from the node name in Linux. The
> node name was changed in commit acfd5bbe2641 ("ARM: dts: sun6i: Change
> clock node names to avoid warnings"). This breaks Linux as the sunxi-ng
> clock driver implicitly depends on the external clock being named
> "osc24M".
>=20
> Add a "clock-output-names" property to restore the previous behavior.
>=20
> Fixes: acfd5bbe2641 ("ARM: dts: sun6i: Change clock node names to avoid
> 		      warnings")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nrrmjmmauuftwoov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDXI2QAKCRDj7w1vZxhR
xZmoAQDm3bL9J9jdFm0jYD84rJW8RuzHZuBZQrjMhlByqYpQvQEAo9PkDmEnw3O+
FXvx0AK+HIKpG+Beknn8yqrrudy3+wI=
=rytg
-----END PGP SIGNATURE-----

--nrrmjmmauuftwoov--
