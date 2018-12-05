Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D47C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E5820878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E5820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbeLEPje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:39:34 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58919 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbeLEPjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:39:33 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 71F6420C36; Wed,  5 Dec 2018 16:39:31 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
        by mail.bootlin.com (Postfix) with ESMTPSA id E1BC920CE8;
        Wed,  5 Dec 2018 16:39:04 +0100 (CET)
Date:   Wed, 5 Dec 2018 16:39:05 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v4 05/22] drm/sun4i: frontend: Determine input format
 based on colorspace
Message-ID: <20181205153905.gtsgto45omkocxrz@flea>
References: <20181205083703.21488-1-paul.kocialkowski@bootlin.com>
 <20181205083703.21488-6-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nuvzpqcwpzwepf3q"
Content-Disposition: inline
In-Reply-To: <20181205083703.21488-6-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nuvzpqcwpzwepf3q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 05, 2018 at 09:36:46AM +0100, Paul Kocialkowski wrote:
> Since all the RGB input formats have the same value for the DATA_FMT
> field of the INPUT_FMT register, we can group them when the format is
> known to be RGB. Here, we assume that a non-YUV format is RGB, because
> the hardware does not support any other colorspace than RGB and YUV.
>=20
> Use the DRM format info structure to check whether the format uses a
> YUV colorspace.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--nuvzpqcwpzwepf3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAfxGAAKCRDj7w1vZxhR
xdyTAP9S9aXImznZ2+1K97zxpbBmZsSZW49FJhUMY7OqZMmEEQD+OOEh+isTecuq
jgXyGxCSgQzezqAAYBzmFNpDWXjz9Ag=
=2Kw6
-----END PGP SIGNATURE-----

--nuvzpqcwpzwepf3q--
