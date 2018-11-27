Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0E2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED35204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED35204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbeK0UfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:35:06 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60245 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbeK0UfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:35:05 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 34025207AD; Tue, 27 Nov 2018 10:37:45 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id F1CB0207AD;
        Tue, 27 Nov 2018 10:37:34 +0100 (CET)
Date:   Tue, 27 Nov 2018 10:37:35 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Priit Laes <plaes@plaes.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH 10/14] regulator: dts: set proper lradc vref on OLinuXino
 Lime2
Message-ID: <20181127093735.amfqfcsxzreajte4@flea>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <b27515a1cfe3512253a3fbcda04a3367818520b9.1543245984.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gxurvkzd35bhwvqz"
Content-Disposition: inline
In-Reply-To: <b27515a1cfe3512253a3fbcda04a3367818520b9.1543245984.git-series.plaes@plaes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gxurvkzd35bhwvqz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 26, 2018 at 05:27:51PM +0200, Priit Laes wrote:
> From: Olliver Schinagl <oliver@schinagl.nl>
>=20
> The lradc's analog reference voltage is set to 3.0 volt in the
> hardware. This is more or less set in copper for at least lradc0. Set the
> property in the dts to ensure the lradc is referenced properly.
>=20
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>

I'm not sure why that patch is part of this series, but I applied
it. Thanks!

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gxurvkzd35bhwvqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0QXgAKCRDj7w1vZxhR
xU51AQCL4HIM87ezLgid7C4FmtPyydSlRECZ5jFdr6azvBmRGQEAyD2o7X+6vCvJ
LE5MPQQX3u8QI3ZZEmk3PhI/BCHJowg=
=njvD
-----END PGP SIGNATURE-----

--gxurvkzd35bhwvqz--
