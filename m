Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241A3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E542720861
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 10:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfAWKkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 05:40:22 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33947 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbfAWKkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 05:40:21 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6350A207AB; Wed, 23 Jan 2019 11:40:19 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 33DED20714;
        Wed, 23 Jan 2019 11:40:09 +0100 (CET)
Date:   Wed, 23 Jan 2019 11:40:09 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2] arm: sun8i-h3-nanopi-m1-plus: enable HDMI
Message-ID: <20190123104009.zf5xxsbxacmftwwt@flea>
References: <1548143206-11404-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7sfrqbci6lvwmlro"
Content-Disposition: inline
In-Reply-To: <1548143206-11404-1-git-send-email-clabbe@baylibre.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7sfrqbci6lvwmlro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 07:46:46AM +0000, Corentin Labbe wrote:
> This patch enable HDMI output on sun8i-h3-nanopi-m1-plus.
>=20
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

The prefix must be "ARM: dts:"

I've fixed it and applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7sfrqbci6lvwmlro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEhEiQAKCRDj7w1vZxhR
xZ3pAQCJSE2FzvWr/4NVrljqNm+TQECoB/TPbuuY6UmGvzAo/QD/WmPY8QpFB2o2
VzrlhG6RqaIhvq8dRquVzMxb5Y6zVww=
=wXRH
-----END PGP SIGNATURE-----

--7sfrqbci6lvwmlro--
