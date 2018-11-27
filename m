Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E2AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DB4208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 08:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DB4208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbeK0Ty7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 14:54:59 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57937 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729637AbeK0Ty7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 14:54:59 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 74E1D20DDE; Tue, 27 Nov 2018 09:57:46 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 41CB6207BC;
        Tue, 27 Nov 2018 09:57:36 +0100 (CET)
Date:   Tue, 27 Nov 2018 09:57:36 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH v2 23/43] drm/sun4i: backend: Detail the YUV to RGB
 values coding explanation
Message-ID: <20181127085736.mz3jn4o5nofp4rtu@flea>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
 <20181123092515.2511-24-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v2u7ysgbdwge3iew"
Content-Disposition: inline
In-Reply-To: <20181123092515.2511-24-paul.kocialkowski@bootlin.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v2u7ysgbdwge3iew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 23, 2018 at 10:24:55AM +0100, Paul Kocialkowski wrote:
> From: Paul Kocialkowski <contact@paulk.fr>
>=20
> The values in the BT601 YUV to RGB colorspace translation are not
> simply coded as multiples, but rather as fixed-point signed fractional
> values on a given number of bits. Add an explanation about that.
>=20
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

Applied, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--v2u7ysgbdwge3iew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/0HAAAKCRDj7w1vZxhR
xeywAQDSnQyo4nZXSqJwom5w+JCYd6KgeGVjRwKDT/gniW3fegD9F+vvkAB1xere
XkNdCfPeqW9nj7/4nb2eKDoyRMmtqAM=
=WZBg
-----END PGP SIGNATURE-----

--v2u7ysgbdwge3iew--
