Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB411C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95522086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B95522086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeK0Tgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:36:45 -0500
Received: from mail.bootlin.com ([62.4.15.54]:56036 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbeK0Tgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:36:44 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F0FF420DF0; Tue, 27 Nov 2018 09:39:34 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id BF7C920DC1;
        Tue, 27 Nov 2018 09:39:24 +0100 (CET)
Date:   Tue, 27 Nov 2018 09:39:24 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 06/43] drm/sun4i: backend: Refine the logic behind
 using the frontend
Message-ID: <20181127083924.qv7vapvaq3mjb4lu@flea>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-7-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="elvd3isa5bawhepk"
Content-Disposition: inline
In-Reply-To: <20181123092515.2511-7-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--elvd3isa5bawhepk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 10:24:38AM +0100, Paul Kocialkowski wrote:
> Checking that scaling is in use is not sufficient as a condition to
> decide to use the frontend.
>=20
> Since not all layer formats are supported by the frontend, we need to
> check for that support first. Then, the frontend must only be enabled
> if the backend doesn't support the format or that scaling is required.
>=20
> Signed-off-by:Paul Kocialkowski <paul.kocialkowski@bootlin.com>

You were missing a space to that SoB. I added it and applied, thanks!
maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--elvd3isa5bawhepk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0CvAAKCRDj7w1vZxhR
xasBAP9noEgaG95qjoqXG4Xy5XpCy3WyKaqcwAruBSMdcJhWXgD/VeWgMmz3jHDU
K6sAmzwr1ux6H9MA4kVsTesm+8ywfgI=
=ovs0
-----END PGP SIGNATURE-----

--elvd3isa5bawhepk--
