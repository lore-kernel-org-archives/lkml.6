Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75A9C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64D72081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64D72081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbeLDPbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:31:32 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38310 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbeLDPba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:31:30 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 98E98207B0; Tue,  4 Dec 2018 16:31:26 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
        by mail.bootlin.com (Postfix) with ESMTPSA id B24CE206D8;
        Tue,  4 Dec 2018 16:30:54 +0100 (CET)
Date:   Tue, 4 Dec 2018 16:30:54 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 09/21] drm/sun4i: frontend: Add support for planar YUV
 input formats
Message-ID: <20181204153054.sdckfazc2cfu6tmo@flea>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
 <20181204142218.16284-10-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ucojaxrqyohjhg53"
Content-Disposition: inline
In-Reply-To: <20181204142218.16284-10-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ucojaxrqyohjhg53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 03:22:06PM +0100, Paul Kocialkowski wrote:
> Planar YUV formats come with 3 distinct planes, which requires
> configuring the frontend line stride and address registers for the
> third plane.
>=20
> Our hardware only supports the YUV planes order and in order to support
> formats with a YVU plane order, a helper is introduced to indicate
> whether to invert the address of the two chroma planes.
>=20
> Missing definitions for YUV411 and YUV444 input format configuration are
> also introduced as support is added for these formats. For the input
> sequence part, no configuration is required for planar YUV formats so
> zero is returned in that case.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ucojaxrqyohjhg53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAadrgAKCRDj7w1vZxhR
xaY+AQCMuRQHAsb1fFHeIiq3YjZTcCsIu0L/G8NyH1crXqfGmwD+PZi2dJD3tmwE
l897gR4O0lHx/ghX5Uf3XbdeLsrhSQQ=
=s1WY
-----END PGP SIGNATURE-----

--ucojaxrqyohjhg53--
