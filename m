Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F58C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 825FB20823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfARSVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:21:11 -0500
Received: from mail.bootlin.com ([62.4.15.54]:33577 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbfARSVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:21:10 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 125E220908; Fri, 18 Jan 2019 19:21:08 +0100 (CET)
Received: from localhost (unknown [212.81.177.10])
        by mail.bootlin.com (Postfix) with ESMTPSA id B3CA9206A6;
        Fri, 18 Jan 2019 19:20:57 +0100 (CET)
Date:   Fri, 18 Jan 2019 19:20:57 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH RESEND v5 00/23] drm/sun4i: Support for linear and tiled
 YUV formats with the frontend
Message-ID: <20190118182057.uqohb7nkffgavezi@flea>
References: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2mdijpnhgcdgczxm"
Content-Disposition: inline
In-Reply-To: <20190118145133.21281-1-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2mdijpnhgcdgczxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2019 at 03:51:10PM +0100, Paul Kocialkowski wrote:
> This series implements support for YUV formats using the display engine
> frontend in the sun4i DRM driver, with various fixes along the way.
> Scaling is supported for every format handled by the frontend.
>=20
> The tiling mode used by the VPU on Allwinner platforms is also supported
> by this series and a dedicated fourcc modifier is introduced, along with
> a specific ioctl for allocating tiled buffers.
>=20
> New common fourcc helpers are also introduced in this series, especially
> related to YUV formats.
>=20
> This was tested on the A33, A20 and A10 platforms and all supported
> features work properly on them. Framebuffer offsets and source
> positions are not supported at this point.

I've applied everything, however I can't see the ioctl you mentionned
anywhere?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--2mdijpnhgcdgczxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXEIZCQAKCRDj7w1vZxhR
xQvqAQCOW8mK24R3dEouhfkDZnIISvUQ68j2sNajP+pLz57F8AD/X0jDwBFXKUhP
Q5fEC43mQS90M+7hn81uMMk8o/fNIw8=
=KCbz
-----END PGP SIGNATURE-----

--2mdijpnhgcdgczxm--
