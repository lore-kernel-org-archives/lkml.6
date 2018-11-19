Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67FDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9163020684
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 08:30:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9163020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeKSSxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:53:33 -0500
Received: from mail.bootlin.com ([62.4.15.54]:37092 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbeKSSxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 13:53:33 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 78CC7207B0; Mon, 19 Nov 2018 09:30:36 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4D4F42039F;
        Mon, 19 Nov 2018 09:30:36 +0100 (CET)
Date:   Mon, 19 Nov 2018 09:30:36 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        TL Lim <tllim@pine64.org>, linux-sunxi@googlegroups.com,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 03/12] drm/sun4i: sun6i_mipi_dsi: Setup burst mode
 timings
Message-ID: <20181119083036.riydru5xefao3xte@flea>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-4-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gfqb2qxm2uunzzxr"
Content-Disposition: inline
In-Reply-To: <20181116163916.29621-4-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gfqb2qxm2uunzzxr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 16, 2018 at 10:09:07PM +0530, Jagan Teki wrote:
> Burst mode display timings are different from convectional
> video mode so update the horizontal and vertical timings.
>=20
> Reference code taken from BSP (from linux-sunxi/
> drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
>=20
> dsi_hsa  =3D 0;
> dsi_hbp  =3D 0;
> dsi_hact =3D x*dsi_pixel_bits[format]/8;
> dsi_hblk =3D dsi_hact;
> dsi_hfp  =3D 0;
> dsi_vblk =3D 0;
>=20
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

How is that matching the code you have in the rest of your patch?

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--gfqb2qxm2uunzzxr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCW/J0rAAKCRDj7w1vZxhR
xetpAP0dCoMoXHqmigzmb4DH/e90ORgpwLlnbMZdLp/4dwvbhAEAgaOCu2YY119R
XUp+sE1mPMcfD8XZwhUbpnxUWDas2w8=
=oCgB
-----END PGP SIGNATURE-----

--gfqb2qxm2uunzzxr--
