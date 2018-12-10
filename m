Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F69C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1572320821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 12:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1572320821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeLJMk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 07:40:57 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33099 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727617AbeLJMkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 07:40:51 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2D27820CFB; Mon, 10 Dec 2018 13:40:49 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-79-44.w90-88.abo.wanadoo.fr [90.88.21.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 03CFC20CE8;
        Mon, 10 Dec 2018 13:40:49 +0100 (CET)
Date:   Mon, 10 Dec 2018 13:40:49 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] clk: sunxi-ng: a64: Allow parent change for VE clock
Message-ID: <20181210124049.py2auqlgd37rbwfo@flea>
References: <20181208180222.12608-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sfo3krjmlrqrn2kn"
Content-Disposition: inline
In-Reply-To: <20181208180222.12608-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sfo3krjmlrqrn2kn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 08, 2018 at 07:02:22PM +0100, Jernej Skrabec wrote:
> Cedrus driver wants to set VE clock higher than it's possible without
> changing parent rate.
>=20
> Allow changing parent rate for VE clock, so clock rate can be set
> freely.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Stephen, Mike, could you apply that patch directly?

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--sfo3krjmlrqrn2kn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXA5evQAKCRDj7w1vZxhR
xXJcAP9/JpDyBlHRQlf6EGQ+tBH79aO+g1+NSMpwRV+bD5jNlQEA+c4El29SwngA
JQUVgiBHbFljxL2/Yh5rDQIZCfDiXww=
=U0gU
-----END PGP SIGNATURE-----

--sfo3krjmlrqrn2kn--
