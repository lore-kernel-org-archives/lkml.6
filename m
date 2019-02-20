Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7098DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A98120675
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfBTOS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:18:57 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:33191 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfBTOS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:18:56 -0500
Received: from localhost (unknown [185.94.189.187])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E908A240003;
        Wed, 20 Feb 2019 14:18:53 +0000 (UTC)
Date:   Wed, 20 Feb 2019 15:18:53 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: sun7i: add pinctrl for missing uart mux
 options
Message-ID: <20190220141853.mrcfdhv6mfhtbqjv@flea>
References: <20190216182132.12895-1-mans@mansr.com>
 <20190220120717.30650-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rq6dlezyfpcqtila"
Content-Disposition: inline
In-Reply-To: <20190220120717.30650-1-mans@mansr.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rq6dlezyfpcqtila
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 12:07:17PM +0000, Mans Rullgard wrote:
> This adds pinctrl settings for various missing uart options.
>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rq6dlezyfpcqtila
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXG1hzQAKCRDj7w1vZxhR
xf0YAQDrfcoJToPpU4dM4p5TUdQkQGKLgSSQg1bt8p/2cKZvBQD7BPqKYyQKRweF
vu1PyV0qT7POUUo5ptq9/LF2hBFMaw0=
=+gW3
-----END PGP SIGNATURE-----

--rq6dlezyfpcqtila--
