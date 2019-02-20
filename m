Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36510C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10593206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfBTPPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:15:45 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43883 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTPPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:15:45 -0500
X-Originating-IP: 185.94.189.187
Received: from localhost (unknown [185.94.189.187])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 9DD4760010;
        Wed, 20 Feb 2019 15:15:42 +0000 (UTC)
Date:   Wed, 20 Feb 2019 16:15:42 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ARM: dts: sun7i: add /omit-if-no-ref/ tags to pin
 group nodes
Message-ID: <20190220151542.dy2tdhw6cy5cn447@flea>
References: <20190220142536.21051-1-mans@mansr.com>
 <20190220142536.21051-3-mans@mansr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ltjeimt6pxkykty5"
Content-Disposition: inline
In-Reply-To: <20190220142536.21051-3-mans@mansr.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ltjeimt6pxkykty5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 20, 2019 at 02:25:36PM +0000, Mans Rullgard wrote:
> Since only one alternative at a time is used, and some functions may not
> be used at all, this cuts down the size of the board dtb files a bit.
>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Applied all three, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ltjeimt6pxkykty5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXG1vHQAKCRDj7w1vZxhR
xfpiAP9iVGo/0QxZrPmzUGNSLgkjVMj9DM6NeQ7RbTYZwtQz4wEAr+RWmjKQyocX
s8L2GhyvS60EBT5vsQL7ON8h0fUJ6wU=
=pYmc
-----END PGP SIGNATURE-----

--ltjeimt6pxkykty5--
