Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6431BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372EA2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372EA2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbeK0T2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:28:51 -0500
Received: from mail.bootlin.com ([62.4.15.54]:55462 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729461AbeK0T2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:28:51 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C9AAB20DD8; Tue, 27 Nov 2018 09:31:43 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9D335207BC;
        Tue, 27 Nov 2018 09:31:33 +0100 (CET)
Date:   Tue, 27 Nov 2018 09:31:33 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 03/43] drm/sun4i: Add TODO comment about supporting
 scaling with the backend
Message-ID: <20181127083133.7gyf3ecmrlf67olf@flea>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-4-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v4ep5c2fidi6prtm"
Content-Disposition: inline
In-Reply-To: <20181123092515.2511-4-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v4ep5c2fidi6prtm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 10:24:35AM +0100, Paul Kocialkowski wrote:
> The backend allows integer-only scaling but can handle alpha components,
> unlike the frontend. It could be useful to add support for this
> eventually, so add a short TODO comment describing the situation.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--v4ep5c2fidi6prtm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0A5QAKCRDj7w1vZxhR
xZ1mAP0WipKZYCo5I/qL4OPH/7aDnahiRPGabq19g4eZeFZibAD8C+tvPi0+anqV
VYzW2AMFAVP2KR55ywxQDzhEnkh+8w0=
=n8kH
-----END PGP SIGNATURE-----

--v4ep5c2fidi6prtm--
