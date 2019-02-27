Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811EFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5808E20842
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbfB0JY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:24:29 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:59833 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfB0JY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:24:29 -0500
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id C463D200004;
        Wed, 27 Feb 2019 09:24:25 +0000 (UTC)
Date:   Wed, 27 Feb 2019 10:24:25 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Priit Laes <plaes@plaes.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Priit Laes <priit.laes@paf.com>
Subject: Re: [PATCH] ARM: dts: sun7i: olimex-lime2: Add regulators for GPIO
 banks
Message-ID: <20190227092425.ombbxgnn7ct2vkqj@flea>
References: <20190226141525.1039-1-plaes@plaes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="c4iexitjl3he7o4z"
Content-Disposition: inline
In-Reply-To: <20190226141525.1039-1-plaes@plaes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c4iexitjl3he7o4z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 04:15:25PM +0200, Priit Laes wrote:
> From: Priit Laes <priit.laes@paf.com>
>=20
> Make sure that A20 Olimex Lime2 pin bank regulators are
> properly represented.
>=20
> While pin banks A, B and F are connected to 3.3V static
> regulator, pin banks E and G tied with LDO3 and LDO4 regulators
> with 2.8V reference.
>=20
> Signed-off-by: Priit Laes <priit.laes@paf.com>

Queued for 5.2, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--c4iexitjl3he7o4z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXHZXSQAKCRDj7w1vZxhR
xduYAQDVtcIIhc/XZLqotrd0piQZ7n2yVwolG2rwqouaml+tygD8DcoKTjPDdP6T
gwxxpApIOD3V3sMKkajLuXe6JIaJawM=
=Pfh3
-----END PGP SIGNATURE-----

--c4iexitjl3he7o4z--
