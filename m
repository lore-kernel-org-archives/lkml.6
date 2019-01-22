Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D06C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5F620854
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbfAVJDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:03:15 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55845 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbfAVJDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:03:15 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B67D820898; Tue, 22 Jan 2019 10:03:12 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8E185206A7;
        Tue, 22 Jan 2019 10:03:12 +0100 (CET)
Date:   Tue, 22 Jan 2019 10:03:13 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: sunxi-ng: v3s: Fix TCON reset de-assert bit
Message-ID: <20190122090313.5sjyezx2yubsvjum@flea>
References: <20190122081619.27653-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ag3fctmm5qik2mkh"
Content-Disposition: inline
In-Reply-To: <20190122081619.27653-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ag3fctmm5qik2mkh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 09:16:19AM +0100, Paul Kocialkowski wrote:
> According to the datasheet and the reference code from Allwinner, the
> bit used to de-assert the TCON reset is bit 4, not bit 3.
>=20
> Fix it in the V3s CCU driver.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ag3fctmm5qik2mkh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEbcUQAKCRDj7w1vZxhR
xfQoAQDRqBXX3BmLCDZaKMqjb6/7gsj94y2EkbDlMdRyfQNNLgD/fTVKKG3sPefj
FEaCH7Md8zJncyIOsfQT1EncjXNntgg=
=kKxt
-----END PGP SIGNATURE-----

--ag3fctmm5qik2mkh--
