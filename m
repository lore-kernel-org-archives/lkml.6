Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD13C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9701B206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9701B206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeLEPia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:38:30 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58799 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeLEPi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:38:29 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C8C6420A35; Wed,  5 Dec 2018 16:38:27 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
        by mail.bootlin.com (Postfix) with ESMTPSA id 7F69B20726;
        Wed,  5 Dec 2018 16:38:17 +0100 (CET)
Date:   Wed, 5 Dec 2018 16:38:17 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v4 06/22] drm/sun4i: Move the BT.601 CSC coefficients to
 the frontend
Message-ID: <20181205153817.yrqkyzalfj4zpn5m@flea>
References: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
 <20181205083703.21488-7-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vaddcdistcgzryzd"
Content-Disposition: inline
In-Reply-To: <20181205083703.21488-7-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vaddcdistcgzryzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 09:36:47AM +0100, Paul Kocialkowski wrote:
> Both the backend and the frontend need the BT.601 CSC coefficients for
> YUV to RGB conversion. Since the backend has a dependency on the
> frontend (and not the other way round), move the coefficients there
> so that both can access them without having to duplicate them.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--vaddcdistcgzryzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAfw6QAKCRDj7w1vZxhR
xdpCAQDN8jtbKSvST3HdPxVLm62blamECkdVV/HU0QieY585WgEA8X3EYIFbaFP6
IcVhrFNhZCjA9lZOx0fSucFj7uLK7AE=
=E4db
-----END PGP SIGNATURE-----

--vaddcdistcgzryzd--
