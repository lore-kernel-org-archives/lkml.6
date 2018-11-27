Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C5AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160DE2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160DE2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbeK0UYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:24:02 -0500
Received: from mail.bootlin.com ([62.4.15.54]:59830 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728266AbeK0UYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:24:02 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 52839207BC; Tue, 27 Nov 2018 10:26:44 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 233C7207A8;
        Tue, 27 Nov 2018 10:26:34 +0100 (CET)
Date:   Tue, 27 Nov 2018 10:26:34 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 38/43] drm/sun4i: Move access control before setting
 the register as documented
Message-ID: <20181127092634.fq47rifbodtu7tk7@flea>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-39-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7zpweo5ev7pd4bed"
Content-Disposition: inline
In-Reply-To: <20181123092515.2511-39-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7zpweo5ev7pd4bed
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 10:25:10AM +0100, Paul Kocialkowski wrote:
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>=20
> Unlike what is currently being done, the ACCESS_CTRL bit documentation as=
ks
> that this bit should be set before modifying any register. The code in the
> BSP also does this, so make sure we do this as well.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

This patch (and the subsequent ones) are missing your SoB.

Maxime
--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--7zpweo5ev7pd4bed
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0NygAKCRDj7w1vZxhR
xagcAQCR3nmGAkBaPNZOnJGj7ONr4EPT6xOHFUTrc91GzvQUCQEA5uXd4t/oEC4w
OrBnealKA9GlQ0QgDkVL7DyBtO6V7wc=
=g0nt
-----END PGP SIGNATURE-----

--7zpweo5ev7pd4bed--
