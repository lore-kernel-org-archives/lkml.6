Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89C4C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3702175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfBFMQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:16:58 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:48887 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfBFMQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:16:57 -0500
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id B6D741C0003;
        Wed,  6 Feb 2019 12:16:54 +0000 (UTC)
Date:   Wed, 6 Feb 2019 13:16:54 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/9] ARM: sun9i: a80: Enable GMAC
Message-ID: <20190206121654.im6j45g5ihbap44p@flea>
References: <20190206033239.3619-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ipgdex6jfl7dhk4a"
Content-Disposition: inline
In-Reply-To: <20190206033239.3619-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ipgdex6jfl7dhk4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 11:32:30AM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
>=20
> On the Allwinner A80, the PIO pin controller includes configuration
> registers to set the I/O voltage. These must match the actual voltage
> provided externally. A mismatch results in signals not being passed
> through.
>=20
> With the new PIO pin-bank regulator supply support in place, we can
> tack on support for setting up these registers.
>=20
> This in turn allows us to enable the GMAC, which runs at a reduced
> 2.5V for RGMII, instead of the standard 3.0V or 3.3V.
>=20
> Please have a look.

Applied the patches 2-9, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ipgdex6jfl7dhk4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXFrQNQAKCRDj7w1vZxhR
xYmpAQDJJQ8oTbNohjQkxjRY3l4l++Z25oTNEN9uxZAhwP73QQD+KskquCTBwl30
PrI0rn1TsAWHFYoey9iuL8ccxctCTA0=
=+p0f
-----END PGP SIGNATURE-----

--ipgdex6jfl7dhk4a--
