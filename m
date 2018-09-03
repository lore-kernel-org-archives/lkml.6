Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B33C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E905420862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 12:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E905420862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbeICQik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 12:38:40 -0400
Received: from mail.bootlin.com ([62.4.15.54]:60922 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbeICQik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 12:38:40 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4EA9220799; Mon,  3 Sep 2018 14:18:46 +0200 (CEST)
Received: from localhost (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id 20BF0203DC;
        Mon,  3 Sep 2018 14:18:46 +0200 (CEST)
Date:   Mon, 3 Sep 2018 14:18:45 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     robh+dt@kernel.org, wens@csie.org, mark.rutland@arm.com,
        mturquette@baylibre.com, sboyd@kernel.org, airlied@linux.ie,
        architt@codeaurora.org, a.hajda@samsung.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 10/27] drm/sun4i: Add compatible for H6 display engine
Message-ID: <20180903121845.znqhufx24ihcpmkn@flea>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-11-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="77ysc5vzzbqkmyxl"
Content-Disposition: inline
In-Reply-To: <20180902072643.4917-11-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--77ysc5vzzbqkmyxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Sun, Sep 02, 2018 at 09:26:26AM +0200, Jernej Skrabec wrote:
> H6 is first Allwinner SoC which supports 10 bit colors, HDR and AFBC.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/sun4i_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/su=
n4i_drv.c
> index dd19d674055c..e5731d092e1a 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -410,6 +410,7 @@ static int sun4i_drv_remove(struct platform_device *p=
dev)
> =20
>  static const struct of_device_id sun4i_drv_of_table[] =3D {
>  	{ .compatible =3D "allwinner,sun4i-a10-display-engine" },
> +	{ .compatible =3D "allwinner,sun50i-h6-display-engine" },
>  	{ .compatible =3D "allwinner,sun5i-a10s-display-engine" },
>  	{ .compatible =3D "allwinner,sun5i-a13-display-engine" },
>  	{ .compatible =3D "allwinner,sun6i-a31-display-engine" },

While it makes sens from an alphabetical point of view, we usually
follow the number order here (so after sun9i).

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--77ysc5vzzbqkmyxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAluNJqQACgkQ0rTAlCFN
r3TU3g/7BeCLrG4kOHLUDVaR380EbyM6CDNX1B8+Dbpq53AyM+um4m0GRb6bAaIo
V2USXEkIu+NBPjpOEvPTsm2SkApe7ghTLBGnypaw+QCZTDbBnK8vIpwxO22Jt9Uw
WNBAEne8Rx6O9MPUkuzZHrPch6VAWceB/FBAIgMATtYSskLKQP+WjwN8LFQHLxWd
qjRA+K2msn4PVbBmzmmBgKnnV/5wlGDjNpBgcv7MvwxXBLdbW99U54604A9JZKRh
KFf7ZF2wuBbXUM1jkLVuFYPLsxJXFB8AnVLRutBYa7uwlwPL1/n8/RcIRHzc9Cb0
M/vi3wq5NLWxuzs7SFUIGkgBHDcLtBaRDOknfci2c8cDj+kisbfzvpkL4ZiVN9if
FjIIZaOkB2xAdr7Eqau7MO3P9SnQgBPzG2eu8F1NgFlZi1+l1jEuDSUdqni3txAP
6u0MEmq6S0g027ffWy8M0tw9fIJWT3bPnWKJCzX0b2KQ/1wJqVnkBu0L6Jl0hSOc
zw7WSgUvzt0h72PYotCXmC9nEK4hlmJ+rJb+yfB5sSqrFRSJ3hTIDFbnYg+aste+
Rv9OboR8gPWAM5hH1+vovz3DG9X8qkLIXTiGGvNXQY4n0K5qCRJhvqCkWgHh+YtH
rBSMeAo4bqj5Os3BQSVALbWVxPQO8fYCNuqaHqhRAF7eCTlyfME=
=WKT1
-----END PGP SIGNATURE-----

--77ysc5vzzbqkmyxl--
