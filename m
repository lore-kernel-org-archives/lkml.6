Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217F6C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD20D2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD20D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbeLDPev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:34:51 -0500
Received: from mail.bootlin.com ([62.4.15.54]:38828 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbeLDPev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:34:51 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 64D3020E21; Tue,  4 Dec 2018 16:34:47 +0100 (CET)
Received: from localhost (unknown [185.94.189.187])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2191320A5F;
        Tue,  4 Dec 2018 16:34:37 +0100 (CET)
Date:   Tue, 4 Dec 2018 16:34:37 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v3 14/21] drm/sun4i: layer: Add tiled modifier support
 and helper
Message-ID: <20181204153437.rbqcaamghq7ok2f6@flea>
References: <20181204142218.16284-1-paul.kocialkowski@bootlin.com>
 <20181204142218.16284-15-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ulhdzh3nxfvnecmb"
Content-Disposition: inline
In-Reply-To: <20181204142218.16284-15-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ulhdzh3nxfvnecmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2018 at 03:22:11PM +0100, Paul Kocialkowski wrote:
> This introduces a list of supported modifiers for the driver, that
> includes the Allwinner tiled modifier, as well as a format_mod_supported
> callback.
>=20
> The callback uses both the backend and frontend helpers to indicate
> per-format modifier support (including for the linear modifier).
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ulhdzh3nxfvnecmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXAaejQAKCRDj7w1vZxhR
xeOhAQDlIapLw8rB+8oybOHKOPBucWazxCBIBmd40fGa6AhkAAD/R94hnP8fmjCF
GKqJa0Xbi4CHNspH8mbVW2s0rltsuQk=
=ak/L
-----END PGP SIGNATURE-----

--ulhdzh3nxfvnecmb--
