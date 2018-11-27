Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3393C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F122086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F122086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbeK0Tqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:46:50 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56532 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbeK0Tqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:46:50 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D026620DBF; Tue, 27 Nov 2018 09:49:38 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id A41D320736;
        Tue, 27 Nov 2018 09:49:28 +0100 (CET)
Date:   Tue, 27 Nov 2018 09:49:28 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 09/43] drm/fourcc: Add format info helpers for
 checking YUV planes disposition
Message-ID: <20181127084928.qydnqypu3ppk3ksr@flea>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-10-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xeeahxfo5c54okff"
Content-Disposition: inline
In-Reply-To: <20181123092515.2511-10-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xeeahxfo5c54okff
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 10:24:41AM +0100, Paul Kocialkowski wrote:
> It is often useful to check whether the DRM format info retrieved from
> the DRM framebuffer matches a specific YUV planes disposition.
>=20
> This introduces helpers to quickly check that a provided format info
> matches a YUV format with a specific disposition, in commonly-used
> terminology.
>=20
> The intent of providing helpers taking the format info instead of the
> fourcc alone is to avoid the overhead of iterating through all formats
> when the whole format info structure is available. As a result, these
> helpers are very simple so they are made inline.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--xeeahxfo5c54okff
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0FGAAKCRDj7w1vZxhR
xYnvAP9zRFxMniU4Q9xU3X53asu+D0wWlTP6kYXZClcpvI5dCAEAinMoJw91nN5Z
CgEn31rhWudUuPz1HX3ohlbYdOuWsQ8=
=Nr5j
-----END PGP SIGNATURE-----

--xeeahxfo5c54okff--
