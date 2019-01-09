Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BD0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AB020883
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 10:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfAIKMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 05:12:41 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38807 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729281AbfAIKMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 05:12:40 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A51E320A11; Wed,  9 Jan 2019 11:12:38 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-45-241.w90-88.abo.wanadoo.fr [90.88.163.241])
        by mail.bootlin.com (Postfix) with ESMTPSA id 73955209C2;
        Wed,  9 Jan 2019 11:12:28 +0100 (CET)
Date:   Wed, 9 Jan 2019 11:12:28 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM: dts: sun8i: h3: Add ethernet0 alias to Beelink X2
Message-ID: <20190109101228.alsaaw6s57dbapfe@flea>
References: <20190108191840.16007-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qm6qjgqr54a5zefy"
Content-Disposition: inline
In-Reply-To: <20190108191840.16007-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qm6qjgqr54a5zefy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 08, 2019 at 08:18:40PM +0100, Jernej Skrabec wrote:
> Because "ethernet0" alias is missing, U-Boot doesn't generate board
> specific MAC address. Effect of this is random MAC address every boot
> and thus new IP address is assigned to the board.
>=20
> Fix this by adding alias.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--qm6qjgqr54a5zefy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXDXJDAAKCRDj7w1vZxhR
xes0AQCh2xjMkQpUtr/QLjruIMtez8PXG+jkhxzQMfoIBQguogD9FcH4DkappRaC
5+IbYq1TuIbsnxz3p3jMDAwATSkOIQk=
=4OB4
-----END PGP SIGNATURE-----

--qm6qjgqr54a5zefy--
