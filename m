Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29DBC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E4F2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfA1KvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:51:21 -0500
Received: from mail.bootlin.com ([62.4.15.54]:50080 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfA1KvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:51:21 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 98C5020746; Mon, 28 Jan 2019 11:51:18 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6693320654;
        Mon, 28 Jan 2019 11:51:08 +0100 (CET)
Date:   Mon, 28 Jan 2019 11:51:09 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: h6: Move GIC device node fix base
 address ordering
Message-ID: <20190128105109.xijxn7wndund3ric@flea>
References: <20190127163930.985-1-wens@csie.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tixpi6cs6e2fc5of"
Content-Disposition: inline
In-Reply-To: <20190127163930.985-1-wens@csie.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tixpi6cs6e2fc5of
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 12:39:30AM +0800, Chen-Yu Tsai wrote:
> The GIC device node was placed out of order in the initial device tree
> submission. Move it so the nodes are correctly sorted by base address
> again.
>=20
> Fixes: e54be32d0273 ("arm64: allwinner: h6: add the basical Allwinner H6 =
DTSI file")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--tixpi6cs6e2fc5of
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXE7enAAKCRDj7w1vZxhR
xUEhAPsFv64cA9oqagr7M+btWbx1dy+BrVWq0CZlEBlcM9I5FAD/fiYfjkCqeqoi
tdqrZhJGV4pDJJKRpVHL1qNcjBk06Qo=
=iVZa
-----END PGP SIGNATURE-----

--tixpi6cs6e2fc5of--
